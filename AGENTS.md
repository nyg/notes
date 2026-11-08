# AGENTS.md

Hugo blog published at https://notes.andstuff.dev, with the PaperMod theme as a git submodule in `themes/PaperMod`, and a small Cloudflare Worker in `worker/` that relays page views to GoatCounter. Every push to `master` builds with the Hugo version pinned in `.github/workflows/hugo.yaml` and deploys to GitHub Pages. Commands are in the README.

## Content

- Each post is a page bundle: `content/posts/<slug>/index.md` with its images beside it. The URL is `/<slug>/` (`[permalinks]` in `hugo.toml`), so renaming a folder changes a published URL: add the old path to the post's `aliases`.
- Front matter carries `date`, `title`, `description` and `tags`. Goldmark `unsafe` is on, so raw HTML in Markdown renders.
- Post bodies are the author's writing. Change wording only when asked; fix links, front matter and markup freely.

## Theme

- Customise PaperMod through override points only: `assets/css/extended/` for CSS (the Geist look) and `layouts/_partials/extend_head.html` for head tags. Leave the submodule's files untouched; a theme update bumps the submodule commit.

## Analytics

- `static/count.js` is an unmodified copy of GoatCounter's `count.v4.js`. Replace it with a newer upstream copy, never edit it.
- `extend_head.html` loads it in production builds only, points it at the Worker's `/hit` endpoint, and swaps `sendBeacon` for `fetch` because blockers drop third-party beacons.
- The Worker accepts only `POST /hit` from `ALLOWED_ORIGIN` and forwards the hit with the visitor's IP, user agent and language. `GOATCOUNTER_TOKEN` is a Wrangler secret (`worker/.dev.vars` locally), never committed. Deploying the Worker is a manual `pnpm run deploy` in `worker/`; site deploys do not touch it.
