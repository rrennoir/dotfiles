{
  description = "Ryan Rennoir's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
            pkgs.kitty
            pkgs.raycast
            pkgs.neovim
            pkgs.keepassxc
            pkgs.discord
            pkgs.spotify
            # pkgs.krita # unsupported platform
            pkgs.zed-editor
            # pkgs.obs-studio # unsupported platform
            pkgs.thunderbird
            # pkgs.bitwarden-desktop # using the AppStore version instead
            pkgs.utm
            pkgs.lua-language-server
            pkgs.nodejs
            pkgs.go
            pkgs.git
            pkgs.git-lfs
            pkgs.oh-my-posh
            pkgs.zoxide
            pkgs.ranger
            pkgs.eza
            pkgs.ripgrep
            pkgs.fzf
            pkgs.fastfetch
    	    pkgs.stow
            pkgs.jq
            pkgs.yq-go
            pkgs.gnupg
            pkgs.glab
            pkgs.gh
            pkgs.wget
            pkgs.nmap
            pkgs.watch
            pkgs.tree
            pkgs.rsync
            pkgs.kubectl
            pkgs.openshift
            pkgs.kubectx
            pkgs.awscli
            pkgs.ansible
            pkgs.ansible-lint
            pkgs.terraform # or pkgs.opentofu
            pkgs.kubernetes-helm
            pkgs.kustomize
            pkgs.glow
            pkgs.python312
            pkgs.ffmpeg
            pkgs.mpv
            pkgs.yt-dlp
            pkgs.jetbrains.idea
            pkgs.jetbrains.pycharm
            pkgs.sdl2-compat
            pkgs.podman
            pkgs.k9s
            pkgs.talosctl
        ];

      homebrew = {
        enable = true;
        global.autoUpdate = true;
        onActivation.cleanup = "zap";
        brews = [
          "pinentry-mac"
          "mas"
        ];
        casks = [
          "tunnelblick"
          "obsidian"
          "postman"
          "krita"
          "unifi-identity-endpoint"
        ];
        masApps = {
          # "Magnet" = 441258766;
          "Bitwarden" = 1352778147;
          "Windows App" = 1295203466;
        };
      };

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

      # Auto upgrade nix package and the daemon service.
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          enableFzfHistory = true;
          enableSyntaxHighlighting = true;
          enableFzfCompletion = true;
        };
      };

      power.sleep.computer = 15;
      power.sleep.display = 5;

      security.pam.services.sudo_local.touchIdAuth = true;

      # Set Git commit hash for darwin-version.
      system = {
        configurationRevision = self.rev or self.dirtyRev or null;
        primaryUser = "rre";
        startup = {
            chime = false;
        };
        defaults = {
          dock = {
            enable-spring-load-actions-on-all-items = false;
            autohide = true;
            magnification = false;
            mru-spaces = false;
            orientation = "bottom";
            persistent-apps = [
              "/System/Applications/System Settings.app"
              # "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
              "/Applications/Brave Browser.app"
              "${pkgs.kitty}/Applications/kitty.app"
              "${pkgs.discord}/Applications/Discord.app"
            ];
            show-recents = false;
            wvous-bl-corner = 4;
            wvous-br-corner = 14; # Default (Note)
          };
          finder = {
            AppleShowAllExtensions = false; # Shown by default except for apps
            AppleShowAllFiles = false;
            FXDefaultSearchScope = "SCcf"; # current folder
            FXPreferredViewStyle = "Nlsv";
            FXEnableExtensionChangeWarning = false;
            NewWindowTarget = "Home";
            ShowPathbar = true;
            ShowStatusBar = true;
          };
          NSGlobalDomain = {
            AppleShowAllExtensions = false;
            AppleShowAllFiles = false;
            InitialKeyRepeat = 15;
            KeyRepeat = 2;
          };
          WindowManager = {
            EnableStandardClickToShowDesktop = true;
            EnableTiledWindowMargins = false;
            EnableTilingByEdgeDrag = false; # Using magnet
            EnableTilingOptionAccelerator = false; # Using magnet
            EnableTopTilingByEdgeDrag = false; # Using magnet
          };
          controlcenter = {
            AirDrop = false;
            BatteryShowPercentage = false;
            Bluetooth = true;
            NowPlaying = true;
            # Sound = true; # Removed in favor of show when active
          };
          screensaver = {
            askForPassword = false;
            askForPasswordDelay = 120;
          };
        };

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        stateVersion = 5;
      };
      # The platform the configuration will be used on.
      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config.allowUnfree = true;
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#lt-rre-2026
    darwinConfigurations."lt-rre-2026" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."lt-rre-2026".pkgs;
  };
}
