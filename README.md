# Swiggity

A few lines of bash to automate git tags, and github releases with a change log, for a CD project.
Viable only if you do not care about semantic versioning in the context of your project.

NB: This is a couple of hours worth of largely untested bash, that force pushes to your repository, so don't just copy it and use it.

## How it works

Swiggity basically just keeps track of two "rolling" branches: "blue" and "green".
These might correspond with blue/green stacks in a blue/green deploy process.

Use swiggity in your release pipeline, and these branches will be updated everytime a release occurs, and will be used to submit a release to github containing an automatically generated changelog.

Do *_NOT_* use these branches for development, because they will be [yolo-plopped on](https://www.github.com/nathanKramer/lit-git) indiscriminately.

### Requirements

- A git repository exists in your current working directory
- git is installed
- GITHUB_ACCESS_TOKEN env var is set.
- REPO_NAME env var is set, or passed in as an argument (see usage)

### Usage: `swiggity push <org_name/repo_name>`

  - Renames old production backup branch to blue, and branches HEAD to new production backup branch
  - _Force pushes_ these branches to your repository (Yes, that's right. Use at your own risk, I'm not liable.)
  - Creates a release tag, which is pushed
  - Submits a release to github, using your GITHUB_ACCESS_TOKEN, containing the changelog between blue/production

### .swiggityrc

.swiggityrc can contain:

- BLUE_BRANCH
  The name of the branch to use for 'blue'
- GREEN_BRANCH
  The name of the branch to use for 'green'
- REPO_NAME
  The <org_name/repo_name> to push releases to.

#### Example .swiggityrc

```
# If not set, you can still pass this as an argument to `swiggity push`
REPO_NAME=<org_name/repo_name>

# If not set, defaults to `origin`
REMOTE=canon

# Github Branch names.
# NB: These branches should be considered volatile.
#     They are maintained by swiggity as convenient backups for diffing etc.

# If not set, defaults to blue-backup
BLUE_BRANCH=blue

# If not set, defaults to production-backup
GREEN_BRANCH=green
```

## Contributing

I don't really know bash, so if you would like to make this better, please feel free to open a pull request.
