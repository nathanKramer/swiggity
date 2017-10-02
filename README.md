# Swiggity

A few lines of bash to automate git tags, and github releases with a change log, for a CD project.
Viable only if you do not care about semantic versioning in the context of your project.

### Requirements

- A git repository exists in your current working directory
- git is installed
- GITHUB_ACCESS_TOKEN env var is set.
- REPO_NAME env var is set, or passed in as an argument (see usage)
- Currently depends on [jq](https://stedolan.github.io/jq/)

### Usage

#### `swiggity describe <org_name/repo_name>`

  - Outputs the changelog that would be used in the published release, without tagging commits or submitting a real release.

#### `swiggity latest <org_name/repo_name>`

  - Outputs the latest release tag

#### `swiggity push <org_name/repo_name>`

  - Creates a release tag, which is pushed
  - Submits a release to github, using your GITHUB_ACCESS_TOKEN

### .swiggityrc

.swiggityrc can contain:

- REMOTE
  The github remote, defaults to origin
- REPO_NAME
  The <org_name/repo_name> to push releases to. If set, you do not need to provide this as an argument to `describe` or `push`

#### Example .swiggityrc

```
# If not set, you can still pass this as an argument to `swiggity push`
REPO_NAME=<org_name/repo_name>

# If not set, defaults to `origin`
REMOTE=canon
```

## Contributing

I don't really know bash, so if you would like to make this better, please feel free to open a pull request.
