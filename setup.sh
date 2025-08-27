#!/bin/bash

WORKDIR=$(pwd)

# symlinks
printf "\e[1mSymlinks:\e[0m\n"

# restore bash config
printf "(1/3) Restoring bash configuration...\n"
ln -sf $WORKDIR/bash/bashrc /home/$USER/.bashrc
ln -sfnT $WORKDIR/bash/bashrc.d /home/$USER/.bashrc.d

# restore btop config
printf "(2/3) Restoring btop configuration...\n"
mkdir -p ~/.config/btop/
ln -sf $WORKDIR/btop/btop.conf /home/$USER/.config/btop/btop.conf

# restore btop config
printf "(3/3) Restoring macchina configuration...\n"
ln -sfnT $WORKDIR/macchina /home/$USER/.config/macchina

# dconf restore
printf "\n\e[1mdconf:\e[0m\n"

# restore ptyxis config
printf "(1/3) Restoring Ptyxis configuration...\n"
dconf load /org/gnome/Ptyxis/ < $WORKDIR/dconf/ptyxis.dconf

# restore keybindings
printf "(2/3) Unbind default keybindings...\n"
gsettings set org.gnome.shell.keybindings toggle-message-tray []
gsettings set org.gnome.shell.keybindings switch-to-application-1 []
gsettings set org.gnome.shell.keybindings switch-to-application-2 []
gsettings set org.gnome.shell.keybindings switch-to-application-3 []
gsettings set org.gnome.shell.keybindings switch-to-application-4 []
gsettings set org.gnome.shell.keybindings switch-to-application-5 []
gsettings set org.gnome.shell.keybindings switch-to-application-6 []
gsettings set org.gnome.shell.keybindings switch-to-application-7 []
gsettings set org.gnome.shell.keybindings switch-to-application-8 []
gsettings set org.gnome.shell.keybindings switch-to-application-9 []

printf "(3/3) Restoring custom keybindings...\n"
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < $WORKDIR/dconf/shortcuts.dconf
dconf load /org/gnome/desktop/wm/keybindings/ < $WORKDIR/dconf/keybindings.dconf

# git setup
printf "\n\e[1mGit:\e[0m\n"
printf "(1/1) Creating gitconfig for \"Aarush Kumbhakern\" (aarushbeleren11@gmail.com)...\n"
git config --global user.name "Aarush Kumbhakern"
git config --global user.email "aarushbeleren11@gmail.com"

# firefox message
printf "\n\e[3mNOTE: Restore custom Firefox CSS manually\e[0m\n" 
