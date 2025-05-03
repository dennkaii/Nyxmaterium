{pkgs, ...}: {
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
      dracula
      sensible
    ];
    extraConfigBeforePlugins = ''
      # set -as terminal-features ",alacritty*:RGB,foot*:RGB,xterm-kitty*:RGB"
      # set -as terminal-features ",alacritty*:hyperlinks,foot*:hyperlinks,xterm-kitty*:hyperlinks"
      # set -as terminal-features ",alacritty*:usstyle,foot*:usstyle,xterm-kitty*:usstyle"
      set -g renumber-windows on

      bind C-[ previous-window
      bind C-] next-window

    '';
    extraConfig = ''
      #floax
            # M- means "hold Meta/Alt"
            set -g @floax-bind '-n M-p'
            set -g @floax-bind-menu 'P'

      #theme
        set -g @dracula-show-left-icon "#S | #W"
        set -g @dracula-transparent-powerline-bg true
        set -g @dracula-show-battery true
        set -g @dracula-show-powerline true


    '';
  };
}
