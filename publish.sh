#!/usr/bin/env sh

set -eu

echo Building website…
mkdocs build

echo Creating archive…
( cd site && tar -cvz * > ../site.tar.gz )

echo Copying archive to host
source .sshenv
ssh $SSH_USER@$SSH_HOST 'rm -rf /home/public/notes.andstuff.club/* || echo Folder already empty'
scp site.tar.gz $SSH_USER@$SSH_HOST:$SSH_DIR
ssh $SSH_USER@$SSH_HOST "cd $SSH_DIR && tar -xvf site.tar.gz && rm site.tar.gz"

echo Uploaded archive:
ls -lh site.tar.gz

echo Removing archive…
rm site.tar.gz
