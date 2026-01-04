{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  keyboardlight = pkgs.writeShellScriptBin "keyboardlight" ''
    device='asus::kbd_backlight'
    #get current brighness
    current=$(${pkgs.brightnessctl}/bin/brightnessctl --device=$device | awk -F': ' '/Current brightness/ {print $2}' | awk '{print $1}')
    #cycle keyboard light level 0 to 3
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
  kanshictl = "${pkgs.kanshi}/bin/kanshictl";
  xwaylandSatellite = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
  xwaylandSatelliteDisplay = ":1";
in {
  imports = [
    inputs.niri.homeModules.niri
  ];
  home.packages = with pkgs; [
    wl-clipboard
    keyboardlight
    clipse
    grim
    slurp
    waybar
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
          tap = true;
          dwt = true;
          natural-scroll = true;
          scroll-method = "two-finger";
        };

        workspace-auto-back-and-forth = true;
      };

      spawn-at-startup = [
        {
          command = ["${pkgs.wluma}/bin/wluma"];
        }
        {command = ["swww-daemon"];}
        # {command = ["${inputs.sherlock.packages.${pkgs.system}.default}/bin/sherlock --daemonize"];}
        {command = [xwaylandSatellite xwaylandSatelliteDisplay];}
        {command = ["fcitx5"];}
        # {command = ["walker" "--gapplication-service"];}
        # {command = ["rofi" "-show" "drun"];}
        {command = ["clipse" "-listen"];}
        {command = [kanshictl "reload"];}
      ];

      prefer-no-csd = true;

      outputs = {
        "eDP-1" = {
          scale = 2.3;
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
        XDG_SESSION_DESKTOP = "niri";
        DISPLAY = xwaylandSatelliteDisplay;
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11,*";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        NIXOS_OZONE_WL = "1";
        GDK_SCALE = "1.0";
        GDK_DPI_SCALE = "1.0";
        XCURSOR_SIZE = "32";
        TERM = "ghostty";
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
          matches = [{app-id = "waybar";}];
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
        screenarea = ''grim -g "$(slurp -o -r -c '#ff0000ff')" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png'';
        screenactive = "grimblast save active - | satty --filename - ";
      in {
        "${mod}+Return".action = spawn "${inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/ghostty";
        # "${mod}+Space".action = spawn "${pkgs.rofi-wayland-unwrapped}/bin/rofi" "-show" "drun";
        "${mod}+Space".action = spawn "sherlock";
        # "${mod}+Space".action = spawn "${inputs.sherlock.packages.${pkgs.system}.default}/bin/sherlock";

        "${mod}+S".action = sh ''${screenarea}'';
        "${ms}+S".action = sh ''${screenactive}'';
        "${ms}+A".action = sh "${inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/ghostty '--title=clipse' -e 'clipse'";
        "${mod}+f".action = toggle-window-floating;
        "${mc}+t".action = switch-focus-between-floating-and-tiling;

        #utilities
        "XF86AudioMute".action = spawn ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        "XF86AudioLowerVolume".action = spawn ["wpctl" "set-volume" "-l" "1.4" "@DEFAULT_AUDIO_SINK@" "2%-"];
        "XF86AudioRaiseVolume".action = spawn ["wpctl" "set-volume" "-l" "1.4" "@DEFAULT_AUDIO_SINK@" "2%+"];
        "XF86AudioPrev".action = spawn ["playerctl" "previous"];
        "XF86AudioPlay".action = spawn ["playerctl" "play-pause"];
        "xf86audioNext".action = spawn ["playerctl" "next"];
        "XF86MonBrightnessDown".action = spawn ["brightnessctl" "set" "2%-"];
        "XF86MonBrightnessUp".action = spawn ["brightnessctl" "set" "+2%"];
        "XF86KbdLightOnOff".action = sh ''keyboardlight'';

        "${ms}+Q".action = close-window;
        "${mc}+H".action = move-column-left;
        "${mc}+J".action = move-window-down-or-to-workspace-down;
        "${mc}+K".action = move-window-up-or-to-workspace-up;
        "${mc}+L".action = move-column-right;
        "${ms}+C".action = center-column;
        "${ms}+R".action = reset-window-height;

        "${ms}+J".action = focus-workspace-down;
        "${ms}+K".action = focus-workspace-up;
        "${mod}+m".action = maximize-column;

        "${ms}+F".action = fullscreen-window;
        "${mod}+H".action = focus-column-left;
        "${mod}+J".action = focus-window-down;
        "${mod}+K".action = focus-window-up;
        "${mod}+L".action = focus-column-right;
        "Alt+Minus".action = set-column-width "-10%";
        "Alt+Equal".action = set-column-width "+10%";

        #group windows
        "${mod}+BracketLeft".action = consume-or-expel-window-left;
        "${mod}+BracketRight".action = consume-or-expel-window-right;
        #toogle tabbed
        "${ms}+t".action = toggle-column-tabbed-display;
        "${ms}+Tab".action = move-column-to-monitor-next;

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
      };
      switch-events = with config.lib.niri.actions; {
        lid-close.action = spawn ["kanshictl" "switch" "peacehavenDockedClosed"];
        lid-open.action = spawn ["kanshictl" "switch" "peacehavenDockedOpen"];
      };
    };
  };
}
