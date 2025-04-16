# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  security.polkit.enable = true;

  # Enable home-manager for the user
  home-manager = {
  extraSpecialArgs = {inherit inputs;};
  backupFileExtension = "backup";  # 👈 Add this line
  users = {
  Kihsir = import ./home.nix;
  };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "NixOS"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.optimise.automatic = true;

  time.timeZone = "Asia/Kolkata";

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services = {
    teamviewer.enable = true;
    gnome.gnome-keyring.enable = true;
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
    tlp.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    usbmuxd.enable = true;
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    # Enable Flatpak
    flatpak.enable = true;
  };

  fileSystems = {
    "/home".options = [
      "compress=zstd"
      "noatime"
      "autodefrag"
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.Kihsir = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #Enabling hyprland on NixOS
  programs = {
    light.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    adb.enable = true;
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    sessionVariables = {
      #If your cursor become invisible
      # WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electron apps to use wayland
      # NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      #   wget
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "24.11";
}
