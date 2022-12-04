# macOS

* `ps -p $$ | cut -d " " -f1 | xargs lsof -p`
* backup: check which config can be added to git and symlinked
* Links
  * https://macos-defaults.com/
  * https://github.com/catilac/plistwatch
* Time Machine
  * Local snapshots: https://support.apple.com/en-us/HT204015
  * `tmutil addexclusion`: useful to exclude .node\_modules

```sh
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ICL="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"
export PATH=$HOME/.$USER-sh/bin:$PATH
export SAGE_ROOT="/usr/local/Caskroom/sage/9.4,1.2.2/SageMath-9-4.app/Contents/Frameworks/Sage.framework/Versions/9.4"
export SAGE_LOCAL="$SAGE_ROOT/local"

if [ "$OS" = 'Darwin' ]
then
    # https://zsh.sourceforge.io/Guide/zshguide02.html#l6
    # https://zsh.sourceforge.io/Doc/Release/zsh_toc.html
    # https://www.softec.lu/site/DevelopersCorner/MasteringThePathHelper
    # https://unix.stackexchange.com/questions/22979/path-helper-and-zsh
    # https://osxdaily.com/2010/05/06/speed-up-a-slow-terminal-by-clearing-log-files/
    # https://github.com/yb66/path_helper
    export PATH=/usr/local/bin:$PATH
fi
```
