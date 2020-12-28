#! /bin/sh
alias ll="ls -lah"
alias search="find . -name"

alias update="sudo pacman -Syy & sudo pacman -Syu"
alias install="sudo pacman -S"
alias yinstall="yay -S"

alias battery=acpi
alias open=xdg-open

alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
