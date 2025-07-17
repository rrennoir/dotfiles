# dotfiles

## Requirements

Install brew, nix, git and stow

Hostname set, will be used by nix

## Install

### Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
### dotfiles

```sh
git clone git@github.com:rrennoir/dotfiles.git
```

### Nix

First use the Nix install script and follow the instruction (lots of `y`)

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

Next nix darwin, first rename the hostname to the current hostname in `flake.nix` and set the username too

```sh
cd dotfiles/dot-config/nix
scutil --get LocalHostName
vi flake.nix
```

then Install nix-darwin

```sh
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ./flake.nix
```

### Install dotfile

```sh
cd dotfiles
stow .
```
