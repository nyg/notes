---
description: Python Version Manager
---

# pyenv

```bash
# Find latest available version
latest=pyenv install -l | grep -E '^\s*\d\.\d+\.\d+$' | tail -1 | sed 's/ //g'

# Install latest version
pyenv install $latest

# Output installed packages or current version
pip freeze > requirements.txt

# Install packages from requirements.txt
pip install -r requirements.txt
```
