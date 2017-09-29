#!/bin/bash

readonly release_endpoint="${GITHUB_API_URL:-https://api.github.com}/repos/%s/releases"
readonly release_json='{"tag_name": "%s", "name": "%s", "target_commitish": "%s", "body": "%s"}'

function latest-release-tag() {
	jq -r ".tag_name" <(curl -s -X GET "$1/latest?access_token=$GITHUB_ACCESS_TOKEN") > /dev/null
}

create-release() {
	# Tag the release
	local tag_name=$(date '+%d-%m-%Y@%H-%M')
	local release_url="$(printf "$release_endpoint" "$1")"
	local old_tag=$(latest-release-tag $release_url)

	git tag -a "$tag_name" -m "Production release at $(date -u)"

	local release_body=$tag_name
	if [ "$old_tag" != "null" ]; then
		echo "Building change log between $old_tag and $tag_name"
		release_body=$(change-log $old_tag $tag_name)
		echo $release_body
	fi

	git push $REMOTE --tags
	echo "Publishing $tag_name as a release"
	local release="$(printf "$release_json" "$tag_name" "$tag_name" "master" "$release_body")"
	curl -s -d "$release" "$release_url?access_token=$GITHUB_ACCESS_TOKEN"
}
