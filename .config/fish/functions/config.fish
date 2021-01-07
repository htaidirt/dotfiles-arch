function config --description 'Config environment'
	set DOTFILES_GIT "$HOME/.dotfiles.git"
	/usr/bin/git --git-dir=$DOTFILES_GIT/ --work-tree=$HOME
end

