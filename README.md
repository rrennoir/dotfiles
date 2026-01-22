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

Backup original default `bashrc` and `zshrc` files (nix did it, but nix-darwin doesn't)

```sh
sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
```

then Install nix-darwin, for the first execution experimental features must be enabled

```sh
sudo nix run --extra-experimental-features "nix-command flakes" nix-darwin/master#darwin-rebuild -- switch --flake ./flake.nix
```

### Install dotfile

```sh
cd dotfiles
stow .
```

## Update / Add nix packages

```sh
cd ~/.config/nix
nix flake update
vim flake.nix
mac-rebuild-nix
```
