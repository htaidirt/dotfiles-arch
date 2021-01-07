# To make fish your default shell, run:
# chsh -s $(which fish)


# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

# Setup bare git repo for my configs
set DOTFILES_GIT "$HOME/.dotfiles.git"

if not test -d $DOTFILES_GIT
	mkdir -p $DOTFILES_GIT
	git init --bare $DOTFILES_GIT
end

set DOTFILE_CMD "/usr/bin/git --git-dir=$DOTFILES_GIT/ --work-tree=$HOME"
eval "$DOTFILE_CMD config --local status.showUntrackedFiles no"

# Add local scripts
set PATH $PATH:$HOME/.local/bin

# Add SSH for fast authentication
if test -e "$HOME/.ssh/id_rsa"
	/usr/bin/ssh-add -K "$HOME/.ssh/id_rsa" &> /dev/null
end

ufetch &

