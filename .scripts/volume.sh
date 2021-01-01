#!/bin/sh

case $1 in
	"raise")
		amixer set Master -q 5%+
		;;
	"lower")
		amixer set Master -q 5%-
		;;
	"toggle")
		amixer -q sset Master,0 toggle
		;;
	*)
		echo "Bad option $1 for volume control"
		;;
esac

