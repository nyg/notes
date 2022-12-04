# git xargs

[git-xargs](https://github.com/gruntwork-io/git-xargs) is a command-line tool for making updates across multiple GitHub repositories with a single command.

```
export GITHUB_OAUTH_TOKEN=<your-secret-github-oauth-token>
git-xargs \
  --dry-run \
  --skip-pull-requests \
  --base-branch-name dev \
  --commit-message "Update CODEOWNERS and renovate.json" \
  --repos <file-with-list-of-owner-repo> \
  $(pwd)/script-to-execute.sh
```

### GitHub Enterprise support

Doesn't look like it's [supported](https://github.com/gruntwork-io/git-xargs/issues/5).

1. Install [Golang](https://go.dev/doc/install)
2. Clone the repo `https://github.com/gruntwork-io/git-xargs.git`
3. Apply this [patch](https://github.com/gruntwork-io/git-xargs/issues/5#issuecomment-840790709)
4. [Run git-xargs](https://github.com/gruntwork-io/git-xargs#running-the-tool-without-building-the-binary)
