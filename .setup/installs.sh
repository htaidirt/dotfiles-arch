#! /bin/sh

if ! command -v yay &> /dev/null
then
    sudo pacman -S yay
fi

function install() {
	if ! command -v $2 &> /dev/null
	then
		echo "Installing $1 using pacman..."
		sudo pacman -S $1 --noconfirm
	fi
}

function yinstall() {
	if ! command -v $2 &> /dev/null
	then
		echo "Installing $1 using yay [AUR]..."
		yay -S $1
	fi
}

function check_font_and_install() {
    FONT=$1
    PACKAGE=$2

    if [ $(fc-list | grep "$FONT" | wc -l) == 0 ]; then
        echo "Installing $FONT using package $PACKAGE..."
        sudo pacman -S $PACKAGE --noconfirm
    fi
}


#####################
#                   #
#  WINDOW  MANAGER  #
#                   #
#####################

install bspwm bspwm
install sxhkd sxhkd



#####################
#                   #
#      SYSTEM       #
#                   #
#####################

yinstall i3lock-color i3lock
install xorg-xbacklight xbacklight
install neofetch neofetch
yinstall ufetch ufetch
install htop htop
install tree tree
yinstall tty-clock tty-clock



#####################
#                   #
#       WEB         #
#                   #
#####################

yinstall brave brave
yinstall trezor-bridge-bin trezor-bridge-bin



#####################
#                   #
#     UTILITIES     #
#                   #
#####################

install alacritty alacritty
yinstall ranger-git ranger
install scrot scrot # Quick screenshot of current view
install flameshot flameshot
install jq jq
install fzf fzf
install skippy-xd skippy-xd # Show all active apps of desktop
yinstall oblogout oblogout # Logout and co. for Openbox
yinstall ltunify ltunify # Helps to work with Logitech MX Switch 2



#####################
#                   #
#       FONTS       #
#                   #
#####################

check_font_and_install "DejaVu" ttf-dejavu
check_font_and_install "JetBrains Mono" ttf-jetbrains-mono
check_font_and_install "Cantarell" cantarell-fonts
check_font_and_install "Material" ttf-material-design-icons



#####################
#                   #
#    DEVELOPMENT    #
#                   #
#####################

install vim vim
yinstall visual-studio-code-bin code
install nvm nvm
install docker docker
yinstall ctags ctags



#####################
#                   #
#       TOOLS       #
#                   #
#####################

yinstall notion-app notion-app
yinstall todoist-electron todoist



#####################
#                   #
#   ENTERTAINEMENT  #
#                   #
#####################

yinstall spotify spotify
yinstall discord discord



#####################
#                   #
#   UNSET HELPERS   #
#                   #
#####################

unset -f install
unset -f yinstall
unset -f check_font_and_install
