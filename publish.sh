#!/usr/bin/env sh
# pip install mkdocs mkdocs-material

set -eu

echo Building website…
mkdocs build

echo Creating archive…
( cd site && tar -cvz * > ../site.tar.gz )

echo Uploading archive to pages.sr.ht
curl --oauth2-bearer $(cat .sr.ht.token | head -1) -Fcontent=@site.tar.gz https://pages.sr.ht/publish/nyg.srht.site

echo Upload archive:
ls -lh site.tar.gz

echo Removing archive…
rm site.tar.gz
