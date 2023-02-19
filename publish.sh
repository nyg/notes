#!/usr/bin/env sh
# pip install mkdocs mkdocs-material

set -eu

echo Building website…
mkdocs build

echo Creating archive…
( cd site && tar -cvz * > ../site.tar.gz )

echo Uploading archive to pages.sr.ht…
TOKEN=$(cat .sr.ht.token | head -1)
curl --progress-bar \
     --oauth2-bearer $TOKEN \
     -Fcontent=@site.tar.gz \
     https://pages.sr.ht/publish/nyg.srht.site | cat

echo Uploaded archive:
ls -lh site.tar.gz

echo Removing archive…
rm site.tar.gz
