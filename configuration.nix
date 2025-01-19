# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "NixOS"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
      };
    };
    gvfs.enable = true;
    udisks2.enable = true;
    usbmuxd.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  # Enable Flatpak
    flatpak.enable = true;
  };

fileSystems = {
  "/home".options = [ "compress=zstd" "noatime" "autodefrag"];
}; 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.Kihsir = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  #Enabling hyprland on NixOS
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    adb.enable = true;
  };

  environment.sessionVariables = {
  #If your cursor become invisible
  # WLR_NO_HARDWARE_CURSORS = "1";
  # Hint electron apps to use wayland
  # NIXOS_OZONE_WL = "1";
  };

  hardware = {
  #Opengl
  graphics.enable = true;
  graphics.enable32Bit = true;
  cpu.amd.updateMicrocode = true;
  enableRedistributableFirmware = true;
  bluetooth.enable = true;
  bluetooth.powerOnBoot = true;
  #Most wayland compositor need this
  # nvidia.modesetting.enable = true;
  };

  # programs.firefox.enable = true;
  nixpkgs.overlays = [
  (
  import /home/Kihsir/Git_Clone/nixpkgs-mozilla/firefox-overlay.nix
  )
  ]; 
 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget

android-tools
ani-cli
blueman
bottles
brightnessctl
clamav
clamtk
clipse
#cliphist
emote
fastfetch
flatpak
ghostty
git
gitkraken
go
gparted
grim
home-manager
hypridle
ifuse
kdePackages.dolphin
kitty
latest.firefox-nightly-bin
libimobiledevice
libnotify
linux-wifi-hotspot
mcontrolcenter
mpv
nautilus
neovim
networkmanagerapplet
ntfs3g
onedriver
playerctl
protonvpn-gui
#ranger
rquickshare
slurp
swaynotificationcenter
swappy
telegram-desktop
#termius
thefuck
tlp
waybar
wluma
wl-clipboard
wofi
yazi
xfce.thunar
  ];

nixpkgs.config.allowUnfree = true;

  # Enable home-manager for the user
  home-manager.users.Kihsir = {
    home.stateVersion = "24.11"; # Set the version of home-manager configuration
    # Additional home-manager config can be added here, e.g.:
    # home.packages = [ pkgs.foo ];
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

