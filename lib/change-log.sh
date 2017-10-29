#!/bin/bash

function change-log() {
	# Get JSON safe "change log" between two commits
	local change_log=$(git log --pretty=oneline --abbrev-commit $1..$2 --reverse | nl -w5 -s ". " | sed -e 's/^[ \t]*//')
	if [ "$3" == "--jsonSafe" ]; then
		awk '{printf "%s\\n", $0}' <(echo "$change_log")
	else
		echo
		echo "Change log for $1 .. $2:"
		echo
		for line in "${change_log[@]}" ; do echo "$line"; done
	fi
}
