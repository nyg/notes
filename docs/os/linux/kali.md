# mount shared drive to get ssh keys

```sh
sudo /usr/bin/vmhgfs-fuse .host:/ /mnt -o subtype=vmhgfs-fuse,allow_other
mkdir .ssh && cp /mnt/vb-shared/* .ssh/
```

# clone repo and run install file
```sh
git clone ***/linux-sh .$USER-sh
.$USER-sh/install/install.sh
```

# todo
1. panel configuration
