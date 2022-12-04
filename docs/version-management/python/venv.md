# venv

> The [`venv`](https://docs.python.org/3/library/venv.html#module-venv) module provides support for creating lightweight “virtual environments” with their own site directories, optionally isolated from system site directories. Each virtual environment has its own Python binary (which matches the version of the binary that was used to create this environment) and can have its own independent set of installed Python packages in its site directories.

```bash
python -m venv .venv      # create a venv
source .venv/bin/activate # activate the venv
deactivate                # deactivate the venv
```

