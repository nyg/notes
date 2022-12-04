---
description: Node Version Manager
---

# nvm

```bash
# Update current version to latest version
current_version=$(nvm version)
nvm install node --reinstall-packages-from=$current_version
nvm uninstall $current_version
```

