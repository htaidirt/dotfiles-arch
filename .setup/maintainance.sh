#! /bin/sh

##
#	Maintainance script. Run every month or so.
##

sudo pacman-key --refresh-keys  # Refresh keys
sudo pacman-mirrors -f 3  # Select 3 fastest mirrors for downloads
sudo pacman -Syy
