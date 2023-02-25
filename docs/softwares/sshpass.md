# sshpass

`sshpass` is a command-line tool for connecting to SSH servers without having to interactively input the user's password. The password can be provided in different ways:

* ```sh
  sshpass -p pwd123 ssh user@host
  ```
  The password will appear for a short time in the output of `ps aux | grep sshpass` before sshpass "makes a mininal attempt to hide the password". It will also appear in the shell's history.

* ```sh
  export MYENV=pwd123
  sshpass -eMYENV ssh user@host
  ```
  The password may also appear when doing `ps axe | grep MYENV` before sshpass unsets the environment variable.

* ```sh
  echo pwd123 > pwd.txt
  chmod 600 pwd.txt
  sshpass -f pwd.txt ssh user@host
  ```
  This is a less unsecure method but still implies storing the password in plaintext.

* ```sh
  echo pwd123 | gpg --personal-cipher-preferences AES256 -c -o pwd.gpg
  sshpass -f <(gpg -dq pwd.gpg) ssh user@host
  ```
  This is probably the least unsecure method as the password is stored encrypted in a file and the shell's process substitution, i.e. `<(cmd)`, is used to create an anonymous pipe (which is what sshpass recommends but with `-d` instead of `-f`).

  Notes on gpg:

## Bonus

Script to create the file with the encrypted password:

```sh
#!/usr/bin/env sh
set -eu

printf "Input password to be used for sshpass: "
trap 'stty echo' INT EXIT
stty -echo
read PWD
printf "\n"

SSHPASS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/sshpass"
SSHPASS_FILE="$SSHPASS_DIR/password.gpg"
mkdir -p "$SSHPASS_DIR"

echo "$PWD" | gpg --personal-cipher-preferences AES256 -c -o $SSHPASS_FILE
echo Password encrypted in $SSHPASS_FILE
```

Aliases:

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

Avoid storing commands starting by a space in the shell's history:

```sh
# zsh
setopt hist_ignore_space

# bash
HISTCONTROL=ignorespace
```

TODO: https://unix.stackexchange.com/questions/597966/zsh-completion-for-sshpass

## Sources

* [https://sourceforge.net/projects/sshpass/](https://sourceforge.net/projects/sshpass/)
* [https://serverfault.com/questions/241588/how-to-automate-ssh-login-with-password](https://serverfault.com/a/946191/394948)
* [https://stackoverflow.com/questions/24454037/pass-a-password-to-ssh-in-pure-bash](https://stackoverflow.com/a/24455773)
* [https://unix.stackexchange.com/questions/156084/why-does-process-substitution-result-in-a-file-called-dev-fd-63-which-is-a-pipe](https://unix.stackexchange.com/a/156088)
