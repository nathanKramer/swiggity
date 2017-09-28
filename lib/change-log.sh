#!/bin/bash

function change-log() {
	# Get JSON safe "change log" between two commits
	local change_log=$(git log --pretty=oneline --abbrev-commit $1..$2 --reverse | nl "-s: ")
	awk '{printf "%s\\n", $0}' <(echo "$change_log")
}
