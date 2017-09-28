DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Defaults
BLUE_BRANCH=blue-backup
GREEN_BRANCH=production-backup
REMOTE=origin

if [ -f "$PWD/.swiggityrc" ]; then
	source "$PWD/.swiggityrc"
fi

# Import lib
source "$DIR/create-release.sh"
source "$DIR/change-log.sh"
