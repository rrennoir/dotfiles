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

### chroot the partitions

```sh
mount /dev/<lvm-partition> /mnt
mount --mkdir /dev/<boo-partition> /mnt/boot
```
Install Arch on the disk

```sh
pacstrap /mnt base linux linux-firmware amd-ucode lvm2 vim
```


