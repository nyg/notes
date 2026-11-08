---
date: 2023-02-25
aliases:
  - /softwares/sshpass/
title: Configuring sshpass
tags:
  - ssh
  - gpg
  - zsh
---

**Summary**: how to encrypt and store a password into a file with GPG, and then decrypting it to provide it to sshpass. Also, some Zsh completion configuration for sshpass. Quick demo below with some dummy users and hosts:

<script async id="asciicast-563649" src="https://asciinema.org/a/563649.js"></script>

## Overview

`sshpass` is a command-line tool allowing a user to connect to SSH hosts without having to interactively input the user's password. The password can be provided to sshpass in different ways:

* Via the command-line:
  ```sh
  sshpass -p pwd123 ssh user@host
  ```
  The least secure option: the password will appear for a short time in the output of `ps aux | grep sshpass` before sshpass "makes a mininal attempt to hide the password". It will also appear in the shell's history.

* With an environment variable:
  ```sh
  export MYENV=pwd123
  sshpass -eMYENV ssh user@host
  ```
  The password may also appear when doing `ps axe | grep MYENV` before sshpass unsets the environment variable.

* Using a file:
  ```sh
  echo pwd123 > pwd.txt
  chmod 600 pwd.txt
  sshpass -f pwd.txt ssh user@host
  ```
  This is a less unsecure method but still implies storing the password in plaintext.

* Using an encrypted file:
  ```sh
  echo pwd123 | gpg --personal-cipher-preferences AES256 -c -o pwd.gpg
  sshpass -f <(gpg -dq pwd.gpg) ssh user@host
  ```
  This is probably the least unsecure method as the password is stored encrypted in a file, and the shell's process substitution, i.e. `<(command)`, is used to create an anonymous pipe (which is what sshpass recommends albeit with `-d` instead of `-f`).


### GPG

What is GPG and why use it with sshpass? GNU Privacy Guard is an implementation of the OpenPGP standard, it was created as a free-software replacement for PGP, which is developed by Broadcom Inc. under a proprietary software license.

GPG has a daemon called `gpg-agent` which, among other things, caches passphrases used to encrypt private keys, so that the user is not required to provide his passphrase everytime he needs it.

For example, when encrypting a password using a symmetric cipher (e.g. AES256) with the command below, gpg-agent will cache the passphrase for a certain amount of time before requesting it again from the user.

```sh
# this command will ask for a passphrase
$ echo mypwd123 | gpg --symmetric -o myfile
$ cat myfile
# the encrypted password

# this command will not ask for the passphrase, as it has been cached
$ gpg -d myfile
gpg: AES256.CFB encrypted data
gpg: encrypted with 1 passphrase
mypwd123
```

Thus, when combining sshpass and gpg, the user will only be required to input the passphrase on the first call to `gpg -d`. On certain OSes, it's also possible to store the passphrase in the OS's keyring app (e.g. GNOME Keyring). In this case, gpg will never ask for the passphrase, the keyring is unlocked when the user logs in with his password.

### Links

* [SourceForge: sshpass][2]
* [Server Fault: How to automate SSH login with password?][3]
* [Stack Overflow: Pass a password to SSH in pure bash][4]
* [Unix & Linux: Why does process substitution result in a file called `/dev/fd/63` which is a pipe?][5]

## Script & aliases

Script to create the file with the encrypted password and some alias definitions for sshpass.

```sh
#!/usr/bin/env sh
set -eu

SSHPASS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/sshpass"
SSHPASS_FILE="$SSHPASS_DIR/password.gpg"
mkdir -p "$SSHPASS_DIR"

# don't echo password
printf "Input password to be used for sshpass: "
trap 'stty echo' INT EXIT
stty -echo
read PWD
printf "\n"

echo "$PWD" | gpg --personal-cipher-preferences AES256 -c -o $SSHPASS_FILE
echo Password encrypted in $SSHPASS_FILE
```

```sh
SSHPASS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/sshpass"
SSHPASS_FILE="$SSHPASS_DIR/password.gpg"

if [ -r "$SSHPASS_FILE" ]
then
    alias ssh='sshpass -f <(gpg -dq "$SSHPASS_FILE") ssh -o StrictHostKeyChecking=no'
    alias scp='sshpass -f <(gpg -dq "$SSHPASS_FILE") scp -o StrictHostKeyChecking=no'
    alias ssho='/bin/ssh'
    alias scpo='/bin/scp'
fi
```

## Zsh completion

### ssh

Some basic settings to get started with Zsh completion system as well as improvements for the ssh command.

```sh
# .zshrc

# 0. general completion settings ############################################# #

# initialize zsh completion system `compsys'
autoload -Uz compinit
compinit -i

# disabled by default, try to make completion list smaller
setopt list_packed

# enabled by default, always list choices when ambiguous completion
setopt auto_list

# enabled by default, when completing an unambiguous prefix on cli, do list
# possible choices
setopt list_ambiguous

# disabled by default, when ambiguous completion, don't require another TAB to
# select the first choice, but select the first choice immediately (then use
# arrows or TAB to navigate between items)
setopt menu_complete

# Enable the interactive mode of the menu selection which allows to filter
# listed choices by continuing to type letters on the cli. May be too much as it
# prevents TAB from being used to go to the next item (see [1]). Arrow keys
# can be used but then the interactive mode will exit (see [2]).
zstyle ':completion:*' menu select interactive

# load menu selection module to define key bindings for the menuselect keymap
zmodload -i zsh/complist

# [1] TAB or Ctrl-I to move to next item while in interactive mode (but will
# exit interactive mode). Shift-TAB to go to previous item in completion.
bindkey -M menuselect '^I' vi-forward-char
bindkey -M menuselect '^[[Z' vi-backward-char

# [2] Ctrl-L to bring back the interactive mode
bindkey -M menuselect '^L' vi-insert

# Ctrl-O to accept completion item and execute command immediately
bindkey -M menuselect '^O' .accept-line

# in-word case-insensitive completion. From:
#   https://stackoverflow.com/a/68794830
#   https://stackoverflow.com/a/69014927
zstyle ':completion:*' matcher-list \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
    '+r:|[._-]=* r:|=*' \
    '+l:|=*'

# 1. ssh hosts completion #################################################### #

# Retrieve hosts from ~/.ssh/{config,known_hosts{,2}}. Note: if the ssh config
# option HashKnownHosts is enabled, the hosts in known_hosts are hashed and thus
# can't be used here. From: https://serverfault.com/a/170481

typeset -U h # remove duplicates
h=(${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
zstyle ':completion:*:(ssh|scp):*:hosts' hosts $h

# 2. ssh users completion #################################################### #

# show only wanted users (or disable users completion by leaving the list empty)
zstyle ':completion:*:(ssh|scp):*:users' users myuser produser

# 3. separate users and hosts in menu selection ############################## #

zstyle ':completion:*:*:(ssh|scp):*:descriptions' format '%F{green}-- %d%f'
zstyle ':completion:*:*:(ssh|scp):*:*' group-name ''
```

### sshpass

Put the script below in a file named `_sshpass` which must be in a folder that is in the `fpath`. If you modify the `fpath`, remember to do it before calling `compinit`. See [here][1] for more information.

The function defines the differents options accepted by sshpass to input the password, which is not that useful as an alias is usually used for sshpass. The important is that the function delegates the completion for ssh (or scp) to Zsh's builtin completion for ssh.

```sh
#compdef sshpass

_sshpass() {
  local context state line
  typeset -A opt_args

  _arguments \
    '(-d -e -f -p)-d+[read password from file descriptor]:file descriptor:_file_descriptors' \
    '(-d -e -f -p)-e[take password from $SSHPASS]' \
    '(-d -e -f -p)-f+[read password from file]:file:_files' \
    '(-d -e -f -p)-p+[actual password]::' \
    '(-)1:command:->command' \
    '*::arguments: _normal' \
    && return

  case $state in
    command)
      if ((CURRENT == 2))
      then
        # insist that the first argument must be an option
        compadd -- -d -e -f -p
      else
        # complete the `command' entered (ssh, scp, etc.)
        _command_names -e
      fi
      ;;
  esac
}

_sshpass "$@"
```

### Misc

Avoid storing commands starting by a space in the shell's history:

```sh
setopt hist_ignore_space
```

### Links

* [The Valuable Dev: A Guide to the Zsh Completion with Examples][10]
* [Description of Zsh options][6]
* [Zsh completion system][7]
* [Zsh completion widgets][8]
* [Zsh modules][9]

[1]: https://unix.stackexchange.com/a/598003/165216
[2]: https://sourceforge.net/projects/sshpass/
[3]: https://serverfault.com/a/946191/394948
[4]: https://stackoverflow.com/a/24455773
[5]: https://unix.stackexchange.com/a/156088
[6]: https://zsh.sourceforge.io/Doc/Release/Options.html#Description-of-Options
[7]: https://zsh.sourceforge.io/Doc/Release/Completion-System.html
[8]: https://zsh.sourceforge.io/Doc/Release/Completion-Widgets.html
[9]: https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html
[10]: https://thevaluable.dev/zsh-completion-guide-examples/
