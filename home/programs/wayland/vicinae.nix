{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.vicinae.homeManagerModules.default];
  services.vicinae = {
    enable = true; # default: false

    themes = {
      oxocarbon-dark = {
        meta = {
          version = 1;
          name = "oxocarbon-dark";
          variant = "dark";
          description = "Oxocarbon-theme for vicinae";
        };
        colors = {
          core = {
            accent = "#ee5396"; # Base0A (Pink) - The signature Oxocarbon color
            accent_foreground = "#161616"; # Black text on the bright pink accent for contrast
            background = "#161616"; # Base00 (Deep Black)
            foreground = "#f2f4f8"; # Base05 (Off-White)
            secondary_background = "#262626"; # Base01 (Dark Gray)
            border = "#262626"; # Base01 (Subtle borders)
          };
          accents = {
            red = "#ee5396"; # Base0A (Pink) - Used as the primary "warm" accent
            green = "#42be65"; # Base0D (Green)
            blue = "#33b1ff"; # Base0B (Bright Blue)
            cyan = "#3ddbd9"; # Base08 (Cyan)
            purple = "#be95ff"; # Base0E (Lavender)
            magenta = "#ff7eb6"; # Base0C (Light Pink)
            yellow = "#78a9ff"; # Base09 (Soft Blue) - Oxocarbon has no yellow, using soft blue as substitute
            orange = "#ff7eb6"; # Fallback to Light Pink
          };
          text = {
            default = "#f2f4f8"; # Base05
            muted = "#dde1e6"; # Base03 (Gray) - Perfect for hints/secondary text
            danger = "#ee5396"; # Base0A (Pink)
            success = "#42be65"; # Base0D (Green)
            placeholder = "#525252"; # Base03
            selection = {
              background = "#393939";
              foreground = "#f2f4f8";
            }; # Base02 Selection
            links = {
              default = "#3ddbd9"; # Cyan for links
              visited = "#be95ff"; # Purple for visited
            };
          };
          input = {
            border = "#262626"; # Base01
            border_focus = "#ee5396"; # Base0A (Pink)
            border_error = "#ff7eb6";
          };
          buttom.primary = {
            background = "#262626"; # Base01
            foreground = "#f2f4f8"; # Base05
            hover = {background = "#393939";}; # Base02

            focus = {outline = "colors.core.accent";};
          };
          list.item = {
            hover = {
              background = "#262626"; # Base01
              foreground = "#f2f4f8";
            };
            selection = {
              background = "#393939"; # Base02
              foreground = "#ffffff"; # Base06 (Pure White)
              secondary_background = "#262626";
              secondary_foreground = "#f2f4f8";
            };
          };
          grid.item = {
            background = "#262626"; # Base01
            hover = {outline = "#ee5396";}; # Pink outline on hover
            selection = {outline = "#f2f4f8";};
          };
          scrollbars = {
            background = "#161616";
          };
          loading = {
            bar = "#ee5396"; # Pink loading bar
            spinner = "#3ddbd9"; # Cyan spinner;
          };
        };
      };
    };
    systemd = {
      enable = true; # default: false
      autoStart = true; # default: false
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
  };
}
