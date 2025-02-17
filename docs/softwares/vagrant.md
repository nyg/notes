---
title: Vagrant
---

* [CLI docs](https://www.vagrantup.com/docs/cli/)

## Boxes

* Add boxes with `vagrant box add generic/openbsd6`
* Boxes are installed in `~/.vagrant.d/boxes`
* List boxes with `vagrant box list -i`
* Update box with `vagrant box update generic/openbsd6`

## Workflow

* `vagrant init`, reads Vagrantfile of current directory and initializes the .vagrant directory
* `vagrant up`, creates vm and starts it (adding it to virtualbox)
* `vagrant halt` (i.e. shutdown), `suspend`
* `vagrant destroy`, deletes vm (e.g. from virtualbox)

## macOS install

```shell
brew install --cask vagrant

# to use vmware instead of virtualbox -> more support for apple silicon images
# e.g. bento/debian-12
brew install --cask vagrant-vmware-utility
vagrant plugin install vagrant-vmware-desktop
```
