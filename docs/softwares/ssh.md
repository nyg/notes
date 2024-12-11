---
title: ssh
tags:
  - ssh
---

OpenSSH is an implementation of the SSH protocol. It is mostly used to connect securely to remote hosts. OpenSSH is composed of different command-line tools:

* services running on the server: `sshd`, `sftp-server`, `ssh-agent`,
* key management tools: `ssh-add`, `ssh-keysign`, `ssh-keyscan`, `ssh-keygen`,
* client-side utilities: `ssh`, `scp`, `sftp`.

### Resources

* [https://www.openssh.com/manual.html](https://www.openssh.com/manual.html)
    * [https://man.openbsd.org/sshd](https://man.openbsd.org/sshd)
    * [https://man.openbsd.org/sshd\_config](https://man.openbsd.org/sshd\_config)
    * [https://man.openbsd.org/ssh](https://man.openbsd.org/ssh)
    * [https://man.openbsd.org/ssh\_config](https://man.openbsd.org/ssh\_config)
* Key types: [https://security.stackexchange.com/a/50890/](https://security.stackexchange.com/a/50890/)

### Installation

```sh
# install the OpenSSH server
sudo apt install openssh-server

# check the status of the daemon, enable it if necessary
sudo systemctl status ssh
```

### Configuration

#### Allow only public-key authentication

Before disabling password-based authentication, we need to add a public key in the user's `~/.ssh/authorized_keys` file.

```sh
## Client

# Generate a public and private key (e.g. in ~/.ssh).
ssh-keygen -t ed25519 -C "description of the key"

# Copy the public key into user's remote ~/.ssh/authorized_keys file, requires the
# user's remote password.
ssh-copy-id -i ~/.ssh/<key.pub> <user>@<host>

# ~/.ssh/config might need to be modified for the correct identity file to be used
# by ssh when connecting to the server.
vim ~/.ssh/config

# Test the connection, should not prompt for the user's remote password.
ssh openbsd_user@openbsd_host

# When connecting for the first time, ssh will ask if the fingerprint of the
# server's public key is correct.
#
# If correct, the public key is added in the user's local ~/.ssh/known_hosts file.
#
# On the server, the file is defined by sshd HostKey value.
for i in /etc/ssh/*.pub; do ssh-keygen -lf $i; done
```

Now, we can update the server's configuration and reload the service.

```sh
## Server

# Set the authentication methods to publickey in /etc/ssh/sshd_config.
AuthenticationMethods publickey
PasswordAuthentication no
PermitEmptyPasswords no

# Reload the daemon's configuration.
/etc/rc.d/sshd reload      # OpenBSD
sudo systemctl restart ssh # Debian
```

#### Disable root login

```sh
# /etc/ssh/sshd_config
PermitRootLogin no
```

#### Check and dump effective configuration

```sh
# validate the configuration, useful before restarting sshd, sudo is important
sudo sshd -t

# validate and dump the effective config
sudo sshd -T -f /etc/ssh/sshd_config | sort
```

#### Host keys

Host keys are the keys proving the identity of the server. They may not be
enabled or properly created by default. If the validation of the config throws
errors regarding host keys, it may be fixed in the following way:

```sh
sudo rm -f /etc/ssh/ssh_host_* # remove existing key
sudo ssh-keygen -A # generate keys

# enable HostKey directives in the sshd_config file
HostKey /etc/ssh/ssh_host_ed25519_key
```

#### Configuration overview

```sh
# Host Keys Configuration
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

# Security Settings
PermitRootLogin no
StrictModes yes
RequiredRSASize 3072

# Authentication Methods
AuthenticationMethods publickey
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
PasswordAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
UsePAM no
MaxAuthTries 3

# User Access Control
AllowUsers user

# Network and Forwarding
X11Forwarding no
AllowAgentForwarding no
AllowTcpForwarding no
PermitTunnel no
UseDNS no
AllowStreamLocalForwarding no
ClientAliveInterval 300

# Logging and Miscellaneous
Banner none
Compression no
LogLevel VERBOSE
```

#### RemoteCommand and RequestTTY

```sh
# Executes a single non-interactive command and exits
Host my-host
	HostName localhost
	User user
	RemoteCommand tail -100f /my-logs.txt

# Executes a interactive
Host my-host
	HostName localhost
	User user
	RemoteCommand less /my-logs.txt
	RequestTTY force

# Defines bash functions, useful if they can't be set directly on the host
Host my-host
	HostName localhost
	User user
	RemoteCommand function logs { cd /logs;  } && export -f log && bash -l
	RequestTTY force
```
