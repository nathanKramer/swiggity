# Swiggity

A few lines of bash to automate git tags, and github releases with a change log, for a CD project.
Viable only if you do not care about semantic versioning in the context of your project.

### Requirements

- A git repository exists in your current working directory
- git is installed
- GITHUB_ACCESS_TOKEN env var is set.
- REPO_NAME env var is set, or passed in as an argument (see usage)

### Usage: `swiggity push <org_name/repo_name>`

  - Submits a release to github, using your GITHUB_ACCESS_TOKEN, containing the changelog between HEAD and the previous github release

### .swiggityrc

.swiggityrc can contain:

- REMOTE
  The github remote, defaults to origin
- REPO_NAME
  The <org_name/repo_name> to push releases to.

#### Example .swiggityrc

```
# If not set, you can still pass this as an argument to `swiggity push`
REPO_NAME=<org_name/repo_name>

# If not set, defaults to `origin`
REMOTE=canon
```

## Contributing

I don't really know bash, so if you would like to make this better, please feel free to open a pull request.
