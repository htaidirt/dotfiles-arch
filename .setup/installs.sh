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
#       FONTS       #
#                   #
#####################

check_font_and_install "DejaVu" ttf-dejavu
check_font_and_install "JetBrains Mono" ttf-jetbrains-mono



#####################
#                   #
#      SYSTEM       #
#                   #
#####################

install neofetch neofetch
yinstall pfetch pfetch
install htop htop
install tree tree
yinstall tty-clock tty-clock



#####################
#                   #
#     UTILITIES     #
#                   #
#####################

install flameshot flameshot
install jq jq



#####################
#                   #
#    DEVELOPMENT    #
#                   #
#####################

install vim vim
yinstall visual-studio-code-bin code\
install nvm nvm
install docker docker



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