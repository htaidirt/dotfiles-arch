#!/bin/sh

case $1 in
	"raise")
		xbacklight -inc 10
		;;
	"lower")
		xbacklight -dec 10
		;;
	*)
		echo "Bad option $1 for brightness control"
		;;
esac

