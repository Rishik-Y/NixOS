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

virtualisation.vmware.host.enable = true;

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["Kihsir"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "Kihsir" ];
  virtualisation.virtualbox.host.enableKvm = true;
  virtualisation.virtualbox.host.addNetworkInterface = false;
  
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
    "/home".options = [ "compress=zstd" "noatime" "autodefrag"];
  }; 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.Kihsir = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
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
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
    # zsh = {
    #   enable = true;
    #   enableCompletion = true;
    #   autosuggestions.enable = true;
    #   syntaxHighlighting.enable = true;
    # };
    fish.enable = true;
    nix-ld = {
    enable = true;
    libraries = with pkgs; [
        stdenv.cc.cc
        openssl
        xorg.libXcomposite
        xorg.libXtst
        xorg.libXrandr
        xorg.libXext
        xorg.libX11
        xorg.libXfixes
        libGL
        libva
        pipewire
        xorg.libxcb
        xorg.libXdamage
        xorg.libxshmfence
        xorg.libXxf86vm
        libelf
        
        # Required
        glib
        gtk2
        bzip2
        
        # Without these it silently fails
        xorg.libXinerama
        xorg.libXcursor
        xorg.libXrender
        xorg.libXScrnSaver
        xorg.libXi
        xorg.libSM
        xorg.libICE
        gnome2.GConf
        nspr
        nss
        cups
        libcap
        SDL2
        libusb1
        dbus-glib
        ffmpeg
        # Only libraries are needed from those two
        libudev0-shim
        
        # Verified games requirements
        xorg.libXt
        xorg.libXmu
        libogg
        libvorbis
        SDL
        SDL2_image
        glew110
        libidn
        tbb
        
        # Other things from runtime
        flac
        freeglut
        libjpeg
        libpng
        libpng12
        libsamplerate
        libmikmod
        libtheora
        libtiff
        pixman
        speex
        SDL_image
        SDL_mixer
        SDL2_ttf
        SDL2_mixer
        libappindicator-gtk2
        libdbusmenu-gtk2
        libindicator-gtk2
        libcaca
        libcanberra
        libgcrypt
        libvpx
        librsvg
        xorg.libXft
        libvdpau
        pango
        cairo
        atk
        gdk-pixbuf
        fontconfig
        freetype
        dbus
        alsa-lib
        expat
        # Needed for electron
        libdrm
        mesa
        libxkbcommon  
	    ];
    };
    adb.enable = true;
    neovim.enable = true;
    neovim.defaultEditor = true;
  };

  # programs.firefox.enable = true;
  nixpkgs.overlays = [
  (
  import /home/Kihsir/Git_Clone/nixpkgs-mozilla/firefox-overlay.nix
  )
  ]; 

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
 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
  variables = {
  EDITOR = "lvim";
  SYSTEMD_EDITOR = "lvim";
  VISUAL = "lvim";
  };
sessionVariables = {
  #If your cursor become invisible
  # WLR_NO_HARDWARE_CURSORS = "1";
  # Hint electron apps to use wayland
  # NIXOS_OZONE_WL = "1";
  };

    systemPackages = with pkgs; [
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
copilot-language-server
dia
emote
fastfetch
flatpak
ghostty
git
gitkraken
go
gparted
#grim
#home-manager
hypridle
ifuse
#kdePackages.dolphin
kitty
latest.firefox-nightly-bin
libimobiledevice
libnotify
linux-wifi-hotspot
lunarvim
mcontrolcenter
mpv
nautilus
ncdu
networkmanagerapplet
ntfs3g
onedriver
#pgadmin4
pgadmin4-desktopmode
playerctl
postgresql
protonvpn-gui
#ranger
rquickshare
#sbt
#scala
#scala_2_12
slurp
swaynotificationcenter
swappy
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
  ];

  };

nixpkgs.config.allowUnfree = true;

  # Enable home-manager for the user
  home-manager.users.Kihsir = {
    home.stateVersion = "24.11"; # Set the version of home-manager configuration
    # Additional home-manager config can be added here, e.g.:
    # home.packages = [ pkgs.foo ];
  };

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

