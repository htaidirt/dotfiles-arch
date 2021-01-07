function take --description 'Make a directory and cd into it'
	mkdir -pv "$argv[1]" && cd "$argv[1]"
end

