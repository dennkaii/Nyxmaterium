{pkgs, ...}: let
  minimal-dot = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-dotbar";
    version = "0.1.0";
    src = pkgs.fetchFromGitHub {
      owner = "vaaleyard";
      repo = "tmux-dotbar";
      rev = "master";
      sha256 = "sha256-n9k18pJnd5mnp9a7VsMBmEHDwo3j06K6/G6p7/DTyIY=";
    };
    rtpFilePath = "dotbar.tmux";
  };
in {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "a";
    aggressiveResize = true;
    clock24 = true;
    escapeTime = 0;
    plugins = with pkgs.tmuxPlugins; [
      pain-control
      tmux-floax
      sensible
      minimal-dot
      battery
      cpu
    ];
    extraConfigBeforePlugins = ''
      # set -as terminal-features ",alacritty*:RGB,foot*:RGB,xterm-kitty*:RGB"
      # set -as terminal-features ",alacritty*:hyperlinks,foot*:hyperlinks,xterm-kitty*:hyperlinks"
      # set -as terminal-features ",alacritty*:usstyle,foot*:usstyle,xterm-kitty*:usstyle"
      set -g base-index 1
      setw -g pane-base-index 1
      set -g renumber-windows on

      bind C-[ previous-window
      bind C-] next-window
      bind r source-file /etc/tmux.conf \; display "Reloaded tmux.conf"


    '';
    extraConfig = ''
      #floax
            # M- means "hold Meta/Alt"
            set -g @floax-bind '-n M-p'
            set -g @floax-bind-menu 'P'

            set -g @tmux-dotbar-position top
            set -g @tmux-dotbar-left true
            set -g @tmux-dotbar-right true
            set -g @tmux-dotbar-status-right "%H:%M | CPU: #{cpu_percentage} | #{battery_graph} "


    '';
  };
}
