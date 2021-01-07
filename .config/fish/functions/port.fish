function port --description 'Which application is running on specified port'
	lsof -i :$argv[1]
end

