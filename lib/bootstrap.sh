DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Defaults
REMOTE=origin

if [ -f "$PWD/.swiggityrc" ]; then
	source "$PWD/.swiggityrc"
fi

# Import lib
source "$DIR/create-release.sh"
source "$DIR/change-log.sh"
