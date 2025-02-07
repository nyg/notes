---
title: pnpm
---

```shell
# npx is replaced by:
# - e.g. pnpm exec next build (next is already installed)
# - e.g. pnpm dlx create-react-app my-app (create-react-app is not installed)

pnpm add <package>
pnpm install
pnpm dev (or name of script in package.json)
```

* https://stackoverflow.com/questions/73711800/hardhat-support-for-pnpm
* pnpm add -g pnpm
    * Run "pnpm setup" to create it automatically, or set the global-bin-dir
      setting, or the PNPM_HOME env variable. The global bin directory should be
      in the PATH.
