#!/usr/bin/env sh

set -eu

mkdocs build
( cd site && tar -cvz * > ../site.tar.gz )
curl --oauth2-bearer $(cat .sr.ht.token | head -1) -Fcontent=@site.tar.gz https://pages.sr.ht/publish/nyg.srht.site
ls -lh site.tar.gz
rm site.tar.gz
