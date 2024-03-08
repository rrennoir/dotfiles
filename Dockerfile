from archlinux
RUN pacman -Sy && echo "Y" | pacman -S ansible sudo
RUN useradd arch --create-home --shell /bin/bash -G wheel
RUN echo "arch:12345" | chpasswd
RUN echo 'arch ALL=(ALL:ALL) ALL' >> /etc/sudoers
USER arch
