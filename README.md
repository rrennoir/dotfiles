# dotfiles

## Install yay

Clone the repo and install yay

```sh
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## Install neovim

```sh
yay -S neovim lua-language-server

# ln nvim config from this repo to .config/nvim
ln -s $(pwd)/nvim ~/.config/nvim
```
## Install Hyprland and his depedencies

```sh
yay -S hyprland-git waybar kitty hyprpaper hyprshot \
    dunst wireplumber swaylock swayidle playerctl wlogout udiskie cliphist polkit-kde-agent \
    qt5-wayland qt6-wayland xdg-desktop-portal-hyprland tuigreet
```

## ZSH and oh-my-posh
