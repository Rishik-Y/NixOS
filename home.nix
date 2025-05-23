{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

nixpkgs.config.allowUnfree = true;

wayland.windowManager.hyprland = {
  enable = true;
  xwayland.enable = true;
  extraConfig = ''
  ${builtins.readFile ./hyprland.conf}
'';};

programs = {
  neovim = {
    enable = true;
    # defaultEditor = true;
    };
  fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
      };
};

  home.username = "Kihsir";
  home.homeDirectory = "/home/Kihsir";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    android-tools
    ani-cli
    autotiling
    blueman
    bottles
    brightnessctl
    clamav
    clamtk
    clipse
    copilot-language-server
    emote
    fastfetch
    flatpak
    git
    gitkraken
    home-manager
    hypridle
    #ifuse
    #jay
    kitty
    # libimobiledevice
    libnotify
    linux-wifi-hotspot
    # louvre
    lunarvim
    mcontrolcenter
    mpv
    nautilus
    ncdu
      networkmanagerapplet
      ntfs3g
      onedriver
      pgadmin4-desktopmode
      playerctl
      protonvpn-gui
      # rquickshare
      slurp
      swaynotificationcenter
      swappy
      # teamviewer
      telegram-desktop
      termius
      thefuck
      tlp
      waybar
      wayshot
      wluma
      wl-clipboard
      wofi
      yazi
      xfce.thunar






    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/Kihsir/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "lvim";
    systemd_editor = "lvim";
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
