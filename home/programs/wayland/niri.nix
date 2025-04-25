{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  keyboardlight = pkgs.writeShellScriptBin "keyboardlight" ''
                            device='asus::kbd_backlight'

    #retrives current status

    current=$(${pkgs.brightnessctl}/bin/brightnessctl --device=$device | awk -F': ' '/Current brightness/ {print $2}' | awk '{print $1}')

    if [ "$current" = 1 ]; then
    	${pkgs.brightnessctl}/bin/brightnessctl --device=$device set 2
    elif [ "$current" = 2 ]; then
    	${pkgs.brightnessctl}/bin/brightnessctl --device=$device set 3
    elif [ "$current" = 3 ]; then
    	${pkgs.brightnessctl}/bin/brightnessctl --device=$device set 0
    elif [ "$current" = 0 ]; then
    ${pkgs.brightnessctl}/bin/brightnessctl --device=$device set 1

    fi
  '';
in {
  imports = [
    inputs.niri.homeModules.niri
  ];
  home.packages = with pkgs; [
    wl-clipboard
    keyboardlight
    clipse
    swww
    satty
    grimblast
  ];

  programs.niri = {
    settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            options = "grp:alt_shift_toogle, ctrl:nocaps";
          };
        };

        mouse = {
          accel-profile = "flat";
          accel-speed = 0.5;
        };

        touchpad = {
          click-method = "clickfinger";
          dwt = true;
          natural-scroll = false;
          scroll-method = "two-finger";
        };

        workspace-auto-back-and-forth = true;
      };

      spawn-at-startup = let
        xwayland = [
          # "sh"
          # "${pkgs.writeShellScript "xwayland_on_niri" ''
          #   ${pkgs.toybox}/bin/setsid ${pkgs.xwayland-satellite}/bin/xwayland-satellite
          #   ${pkgs.toybox}/bin/sleep 4
          #   ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd "DISPLAY"
          # ''}"
        ];
      in [
        {
          command = ["${pkgs.wluma}/bin/wluma"];
        }
        {command = ["swww-daemon"];}
        # {command = ["gauntlet" "--minimized"];}
        # {command = xwayland;}
        {command = ["${pkgs.xwayland-satellite}/bin/xwayland-satellite"];}
        {command = ["fcitx5"];}
        # {command = ["walker" "--gapplication-service"];}
        # {command = ["rofi" "-show" "drun"];}
        {command = ["clipse" "-listen"];}
      ];

      prefer-no-csd = true;

      outputs = {
        "eDP-1" = {
          scale = 2;
          mode = {
            height = 3840;
            width = 2160;
          };
          variable-refresh-rate = true;
        };
        "HDMI-A-1" = {
          scale = 1.3;
        };
      };

      # cursor = with hmConfig.home.pointerCursor; {
      #   inherit size;
      #   theme = name;
      # };

      layout = {
        border = {
          enable = false;
        };

        focus-ring = {
          enable = true;
          width = 2;
        };

        center-focused-column = "on-overflow";

        gaps = 5;
        # preset-column-widths = [
        #   {proportion = 1./3.;}
        #   {proportion = 1./2.;}
        #   {proportion = 3./3.;}
        # ];
      };

      environment = {
        QT_QPA_PLATFOMR = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        KDE_SESSION_VERISON = "5";
        DISPLAY = ":0";
      };

      window-rules = [
        {
          geometry-corner-radius = let
            r = 8.0;
          in {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
          clip-to-geometry = true;
        }
        {
          # dim unfocused windows
          matches = [{is-focused = false;}];
          opacity = 0.95;
        }
        {
          matches = [
            {title = "clipse";}
          ];
          open-floating = true;
        }
      ];

      binds = with config.lib.niri.actions; let
        mod = "Super";
        ms = "${mod}+Shift";
        mc = "${mod}+Ctrl";
        sh = spawn "sh" "-c";
        screenarea = "grimblast save area - | satty --filename - ";
        screenactive = "grimblast save active - | satty --filename - ";
      in {
        "${mod}+Return".action = spawn "${inputs.ghostty.packages.${pkgs.system}.default}/bin/ghostty";
        "${mod}+Space".action = spawn "${pkgs.rofi-wayland-unwrapped}/bin/rofi" "-show" "drun";
        #wait for fix of:https://github.com/project-gauntlet/gauntlet/issues/45
        # "${mod}+Space".action = sh "gauntlet 'open'";
        "${mod}+S".action = sh ''${screenarea}'';
        "${ms}+S".action = sh ''${screenactive}'';
        "${ms}+A".action = sh "${inputs.ghostty.packages.${pkgs.system}.default}/bin/ghostty '--title=clipse' -e 'clipse'";
        "${mod}+f".action = toggle-window-floating;
        "${mc}+t".action = switch-focus-between-floating-and-tiling;

        "${ms}+Q".action = close-window;
        "${mc}+H".action = move-column-left;
        "${mc}+J".action = move-window-down-or-to-workspace-down;
        "${mc}+K".action = move-window-up-or-to-workspace-up;
        "${mc}+L".action = move-column-right;
        "${ms}+C".action = center-column;
        "${ms}+R".action = reset-window-height;
        "${ms}+W".action = toggle-column-tabbed-display;

        "XF86KbdLightOnOff".action = sh ''keyboardlight'';
        "${ms}+J".action = focus-workspace-down;
        "${ms}+K".action = focus-workspace-up;
        "${mod}+m".action = maximize-column;

        "${ms}+F".action = fullscreen-window;
        "${mod}+H".action = focus-column-left;
        "${mod}+J".action = focus-window-down;
        "${mod}+K".action = focus-window-up;
        "${mod}+L".action = focus-column-right;
        "Alt+Plus".action = set-column-width "+10%";
        "Alt+Equal".action = set-column-width "+10%";
        "Alt+Minus".action = set-column-width "-10%";
        "Mod+Plus".action = set-window-height "+10%";
        "Mod+Equal".action = set-window-height "+10%";
        "Mod+Minus".action = set-window-height "-10%";
        "${mod}+E".action = expand-column-to-available-width;

        "${mod}+bracketleft".action = consume-window-into-column;
        "${mod}+bracketright".action = expel-window-from-column;

        #workspace movement
        "${mod}+1".action = focus-workspace 1;
        "${mod}+2".action = focus-workspace 2;
        "${mod}+3".action = focus-workspace 3;
        "${mod}+4".action = focus-workspace 4;
        "${mod}+5".action = focus-workspace 5;
        "${mod}+6".action = focus-workspace 6;
        "${mod}+7".action = focus-workspace 7;
        "${mod}+8".action = focus-workspace 8;
        "${mod}+9".action = focus-workspace 9;

        "${ms}+1".action = move-column-to-workspace 1;
        "${ms}+2".action = move-column-to-workspace 2;
        "${ms}+3".action = move-column-to-workspace 3;
        "${ms}+4".action = move-column-to-workspace 4;
        "${ms}+5".action = move-column-to-workspace 5;
        "${ms}+6".action = move-column-to-workspace 6;
        "${ms}+7".action = move-column-to-workspace 7;
        "${ms}+8".action = move-column-to-workspace 8;
        "${ms}+9".action = move-column-to-workspace 9;
      };
    };
  };
}
