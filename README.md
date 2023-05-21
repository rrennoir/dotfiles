# dotfiles

## Install Arch

> Note: If you get a blackscreen on boot, add the kernel argument nomodeset=1 inside grub

Firstly set the keymap, so it's not this fucking QWERTY

```sh
loadkeys be-latin1
```
Next check if you are connected to the internet and the system clock with `timedatectl`

### Partitioning disks

Get the disk name with `lsblk`, then use `gdisk`

```sh
gdisk /dev/sdb

# Create Boot partition
n

# Partition number will set defaut
enter

# First sector defaut
enter

# Last sector 1G
+1G

# Select partition type
ef00

# Create Root partition
n

# Default partition number
enter

# Default first sector
enter

# Default last sector (rest of the disk)
enter

# Partition type LVM
8e00

# Write changes to disk
w
```

### Create LVM

Now that the disks are partitionned we can create the LVM with `pvcreate <name> <partitions>`

```sh
pvcreate vg1 /dev/sdb1
```

Then create a logical volume with `lvcreate -l 100%FREE <volume-group-name> -n <name>`

```sh
vgcreate -l 100%FREE vg1 -n lvm1
```

Check that the lvm has been correcty with `lsblk`

```
sdb
 |
 |-sdb1 ...        1G  part
 |-sdb2 ...        95G part
    |-vg1-lvm1 ... 95G lvm

### Extent LVM

If you need to extend the current LVM with a newely formated disk

> Use -L <size><T,G,M,K> to specify a size, not the whole disk like with -l 100%FREE, eg: -L 30G

```sh
vgextend <volume-group> <disk-path>
vvextend -l 100%FREE /dev/<volume-group>/<logical-volume>
```

### Format the disks

Create the `fat` partition for `/boot` and `ext4` or `btrfs` for `/`

```sh
mkfs.fat -F32 /dev/<boot-partition>

mkfs.ext4 /dev/<lvm-partition>
# or 
mkfs.btrfs /dev/<lvm-partition>
```

Then check with `lsblk`

### Install Arch on the disk

```sh
mount /dev/<lvm-partition> /mnt
mount --mkdir /dev/<boo-partition> /mnt/boot
```
Install Arch on the disk

```sh
pacstrap /mnt base linux linux-firmware amd-ucode lvm2 vim
```

Next generate `/etc/fstab` with `genfstab`

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```
### Create SWAP file

```sh
arch-chroot /mnt

fallocate -l <size>GB /swapfile
chmod 600 /swapfile
mkswap /swapfile

swapon /swapfile
```
Then add swap file to `/etc/fstab`, by adding this line.

`/swapfile none swap default 0 0'

### Setup localisation and hosts

> Only do this while still chroot in your Arch install

 ```sh
# Get the name of your location
 timedatectl list-timezones | grep Brussels
 ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime
 hwclock --systohc

# uncomment the locals you want
vim /etc/locale.gen

# then generate them
locale-gen

echo LANG=en_US.UTF-8 >> /etc/locale.conf
echo KEYMAP=be-latin1 >> /etc/vconsole.conf
echo archlinux >> /etc/hostname
 ```

 Fill up the `/etc/hosts` file

 ```ini
127.0.0.1   localhost
::1         localhost
127.0.1.1   archlinux
 ```

### Users

Set root password with `passwd`

```
useradd -mG wheel rre
passwd
```

Don't forget to uncomment %wheel from the sudoers file

### Initramfs

If LVM has been created add lvm2 to the HOOKS inside the mkinitcpio config file, located at `/etc/mkinitcpio.conf`

`HOOKS=(... lvm2 filesystem ...)`

To recreate the initramfs simply run this command.

`mkinitcpio -P`

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
git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# ln nvim config from this repo to .config/nvim
ln -s $(pwd)/nvim ~/.config/nvim
```
## Install Hyprland and his depedencies

```sh
yay -S sddm-git hyprland-git waybar-hyprland-git kitty hyprpaper hyprshot dunst wireplumber swaylock wlogout udiskie cliphist polkit-kde-agent qt5-wayland qt6-wayland xdg-desktop-portal-hyprland
```

Next edit the SDDM config

## ZSH and oh-my-posh
