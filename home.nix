{ config, pkgs, nixgl, nix-openclaw, zen-browser, ... }:

{
  home.username = "kihsir";
  home.homeDirectory = "/home/kihsir";
  
  # Note: Ensure "25.05" matches your actual nixpkgs version (e.g., 24.11 is current stable).
  home.stateVersion = "25.11"; 

  nixpkgs.config.allowUnfree = true;

targets.genericLinux.enable = true;

# New Syntax for nixGL
  targets.genericLinux.nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "mesa"; # or "nvidia"
    installScripts = [ "mesa" ]; 
  };

imports = [
    # Add this line:
    nix-openclaw.homeManagerModules.openclaw
    zen-browser.homeModules.beta
];

programs.zen-browser.enable = true;

   # --- Window Manager ---
   # wayland.windowManager.hyprland = {
   #  enable = true;
   #  xwayland.enable = true;
   #  package = config.lib.nixGL.wrap pkgs.hyprland; 
   #  extraConfig = builtins.readFile ./hyprland.conf;
   #};

  # --- Programs ---

programs.openclaw = {
  enable = true;    # ← this is what actually installs it
#  documents = ./documents;

  # Add this:
#  bundledPlugins = {
#    gogcli.enable = true;
#  };

#  config = {
#    gateway = {
#      mode = "local";
#      auth.token = "3f918dabff4e8e592b5eeb287b34a098f68b127ee1b5932e875c211c5caf33cb";
#    };
#    channels.telegram = {
#      tokenFile = "/home/kihsir/.secrets/telegram-bot-token";
#      groups."*".requireMention = true;
#    };
#  };

  instances.default = {
    enable = true;
    plugins = [];
  };
};

  programs.neovim.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "archlinux" "command-not-found" "gitfast" ];
      theme = "robbyrussell";
    };
  };

  # --- Packages ---
  home.packages = with pkgs; [
    # Active Packages
    gemini-cli
    gitkraken
    #jetbrains.idea
    mpv
    ghostty
    swappy
    waybar
    goose-cli
    wl-clipboard
    #msedit
    wofi
    thunar

    # Commented / Inactive Packages
     android-tools 
#antigravity
    # bottles
     brightnessctl
    # distrobox
    # podman
     fastfetch
#linux-wifi-hotspot
    #lunarvim
     mcontrolcenter 
     #mtpfs 
    # onedriver
    # pay-respects
     playerctl
    # protonvpn-gui
    # rustup
    # swaynotificationcenter
     telegram-desktop
    # termius
    # wluma 
    # yazi
    # blueman
    # clamav
    # clamtk
    # copilot-language-server
     #emote
    # hypridle
    # libimobiledevice
     libnotify
    # ncdu
    # networkmanagerapplet
     ntfs3g
    # rquickshare
    # tlp 
  ];

  # --- Session Variables ---
  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
