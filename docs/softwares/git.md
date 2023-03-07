# git

### Resources

* [https://git-scm.com/docs](https://git-scm.com/docs)
* [https://ohshitgit.com/](https://ohshitgit.com/)
* [10 Common Git Problems and How to Fix Them](https://citizen428.net/blog/10-common-git-problems-and-how-to-fix-them/)
* [Recover deleted uncommitted files](https://citizen428.net/blog/git-quick-tips-3-recover-deleted-uncommited-files/)

### Commits

* `git commit --amend`
    * To edit a commit message or add files to the previous commit.
* `git rebase -i '<commit hash>^'`
    * Modify commits using:
        * `reword` to edit commit message
        * `edit` to edit commit
            * commit corrections with `git commit --amend --no-edit`
            * and then `git rebase --continue`
* `git commit <remote> <branch> -f`
    * Force push a commit (if it was already push and then locally modified).
* Links
    * [https://stackoverflow.com/questions/2719579/how-to-add-a-changed-file-to-an-older-not-last-commit-in-git](https://stackoverflow.com/questions/2719579/how-to-add-a-changed-file-to-an-older-not-last-commit-in-git)
    * [https://stackoverflow.com/questions/1186535/how-to-modify-a-specified-commit](https://stackoverflow.com/questions/1186535/how-to-modify-a-specified-commit)

### Tags

* List tags with message: `git tag -n`
* Create annotated tag and push:
    * `git tag -a -m <tag message> <tag name> [commit hash]`
    * `git push --tags` or `git push <remote> <tag name>`
* Remove tag that is already pushed:
    * remove tag on remote with `git push origin :refs/tags/<tag name>`, `:` stands for `--delete`
    * replace tag locally with `git tag -af <tag annotation> <commit hash>`, `-f` means replace existing tag.
    * force push tags with `git push --tags -f`

### Config

```sh
# disable pager mode when doing git branch
git config --global pager.branch false

# set a global gitignore file
git config --global core.excludesfile ~/.config/git/global-ignore

# aliases
git config --global alias.co checkout
```

### Misc

* `git fetch/pull -p`
    * Removes any remote-tracking references that no longer exist on the remote.
* `git show`
    * Show changes in latest commit.
* `git log --oneline --graph --all`
    * Nice view of commit history
* `git add -p`
    * Stage only parts of a file. Split a hunk manually with `s` or `e`: [https://stackoverflow.com/a/37769129/5536516](https://stackoverflow.com/a/37769129/5536516)
