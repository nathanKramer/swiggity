#!/bin/bash

readonly release_endpoint="${GITHUB_API_URL:-https://api.github.com}/repos/%s/releases"
readonly release_json='{"tag_name": "%s", "name": "%s", "target_commitish": "%s", "body": "%s"}'

manage-branches() {
	# Maintain rolling "blue" and "production" branches
	git branch --color=auto $GREEN_BRANCH &> /dev/null || : # Creates production if it didn't exist.
	git branch -M production $BLUE_BRANCH # Rename old production to blue
	git branch --color=auto $GREEN_BRANCH

	# Update remote branches.
	# NB: These branches should be considered transient backups, used for diffing and convenience, NOT for development or any CD process
	# (Hence the force pushing)
	git checkout $BLUE_BRANCH && git push --force origin $BLUE_BRANCH
	git checkout $GREEN_BRANCH && git push --force origin $GREEN_BRANCH
}

create-release() {
	# Tag the release
	local tag_name=$(date '+%d-%m-%Y@%H-%M')
	git tag -a "$tag_name" -m "Production release at $(date -u)"
  git push $REMOTE --tags

	local release="$(printf "$release_json" "$tag_name" "$tag_name" "master" "${2:-$tag_name}")"
	local release_url="$(printf "$release_endpoint" "$1")"
	echo "Creating a release at: $release_url"
	curl -s -d "$release" "$release_url?access_token=$GITHUB_ACCESS_TOKEN"
}
