# Debian / Ubuntu

```sh
diskutil list
diskutil unmountDisk /dev/disk2

# dd seems outdated (?)
sudo dd if=/Users/user/Downloads/debian-11.3.0-amd64-netinst.iso of=/dev/rdisk2 bs=1m

# did not work
sudo cp ~/Downloads/debian-11.3.0-amd64-netinst.iso /dev/disk2 && sync
```

For Compaq laptop, download non-free firmwares for Intel Wireless card

https://packages.debian.org/bullseye/firmware-iwlwifi

iwlwifi-3945-2.ucode iwlwifi-3945-1.ucode

https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/tree/iwlwifi-3945-2.ucode

https://packages.debian.org/bullseye/all/firmware-iwlwifi/download

download deb, tar xvf deb, tar xvf data

copy firmware to usb key

https://www.linuxquestions.org/questions/debian-26/how-to-provide-non-free-firmware-files-to-the-debian-jessie-installer-4175542680/

not necessary for server as we'll use wired connection

select only ssh server and standard systems (recommended)

log in, ip a to get ip, login via ssh

add `/usr/sbin` to path to get visudo

* Doc for apt key
  * https://askubuntu.com/questions/1286545/what-commands-exactly-should-replace-the-deprecated-apt-key
  * https://www.digitalocean.com/community/tutorials/how-to-handle-apt-key-and-add-apt-repository-deprecation-using-gpg-to-add-external-repositories-on-ubuntu-22-04 \* https://askubuntu.com/questions/1437207/what-is-the-right-place-to-put-keyrings-for-repositories
* gsettings set org.gnome.mutter overlay-key ""
* Default editor, use VISUAL and let EDITOR unset
  * https://askubuntu.com/questions/454649/how-can-i-change-the-default-editor-of-the-sudoedit-command-to-be-vim
