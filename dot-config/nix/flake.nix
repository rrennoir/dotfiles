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
            # pkgs.raycast # out of date
            pkgs.neovim
            pkgs.keepassxc
            pkgs.discord
            pkgs.spotify
            # pkgs.zed-editor
            # pkgs.obs-studio # unsupported platform
            # pkgs.thunderbird # unsupported platform
            # pkgs.bitwarden # unsupported platform
            pkgs.utm
            pkgs.lua-language-server
            pkgs.nodejs
            pkgs.go
            pkgs.git
            pkgs.oh-my-posh
            pkgs.zoxide
            pkgs.ranger
            pkgs.eza
            pkgs.ripgrep
            pkgs.fzf
            pkgs.fastfetch
    	    pkgs.stow
            pkgs.jq
            pkgs.yq
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
            # pkgs.helm # Doesn't exist in aarch64-darwin
            pkgs.glow
        ];

      homebrew = {
        enable = true;
        global.autoUpdate = false;
        onActivation.cleanup = "zap";
        brews = [
          "pinentry"
        ];
        casks = [
          "tunnelblick"
          "obsidian"
          "zed"
        ];
        masApps = {
          "Magnet" = 441258766;
          "Bitwarden" = 1352778147;
          "Windows App" = 1295203466;
        };
      };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
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

      security.pam.enableSudoTouchIdAuth = true;

      # Set Git commit hash for darwin-version.
      system = {
        configurationRevision = self.rev or self.dirtyRev or null;
        defaults = {
          dock = {
            autohide = true;
            persistent-apps = [
              "/Applications/Safari.app"
              "/Applications/Nix Apps/kitty.app"
              "/Applications/Nix Apps/Discord.app"
            ];
          };
          finder = {
            FXPreferredViewStyle = "Nlsv";
            ShowPathbar = true;
            ShowStatusBar = false;
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
    # $ darwin-rebuild build --flake .#lt-rre-2022
    darwinConfigurations."lt-rre-2022" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."lt-rre-2022".pkgs;
  };
}
