function get --description 'get various cmdands as helpers'
	set cmd $argv[1]
	set --erase argv[1] # Makes $argv the arguments without the command

	switch $cmd
		case clock
			tty-clock -c -b -C 1 -s
		case ip
			echo (set_color green) (curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g')
		case ssh
			cat ~/.ssh/id_rsa.pub
		case sha256
			echo -n $argv[1] | shasum -a 256
		case '*'
			echo (set_color red) "Invalid cmdand for get: $cmd"
	end
end

