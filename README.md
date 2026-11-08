# notes

Published at: [notes.andstuff.dev](https://notes.andstuff.dev/). The older computer science notes live in [graveyard/notes](https://github.com/nyg/graveyard/tree/master/notes).

## Instructions

```sh
# fetch the theme
git submodule update --init

# serve the site
hugo server

# create a new article
hugo new content posts/my-article/index.md
```

Pushing to `master` builds the site and deploys it to GitHub Pages.

## Analytics

Page views go to [GoatCounter](https://nyg-notes.goatcounter.com) through a Cloudflare Worker, so that blockers listing GoatCounter's domains don't drop them. `static/count.js` is an unmodified copy of `https://gc.zgo.at/count.v4.js`, served from the site itself, and `layouts/_partials/extend_head.html` points it at the Worker's `/hit` endpoint. The Worker in `worker/` only accepts `POST /hit` from `https://notes.andstuff.dev`, and forwards the hit to GoatCounter's API with the visitor's IP, user agent and language.

```sh
cd worker
pnpm install

# the GoatCounter API token, never committed (use worker/.dev.vars for local runs)
pnpm wrangler secret put GOATCOUNTER_TOKEN

pnpm run deploy
```
