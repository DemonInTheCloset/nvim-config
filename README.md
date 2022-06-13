# My NeoVim Configuration

Uses Neovim `0.7+` on Linux

## Setup

- Install Language Server Executables (see `:checkhealth`)
- Packer should bootstrap itself, but it it doesn't work check it's
  [Readme](https://github.com/wbthomason/packer.nvim)
- You should make a python virtual environment on the project root:

  ```cli
  $ virtualenv .venv
  created virtual environment CPython3.10.5.final.0-64 in 1704ms
    creator CPython3Posix(dest=/tmp/test/.venv, clear=False, no_vcs_ignore=False, global=False)
    seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/home/user/.local/share/virtualenv)
    added seed packages: pip==22.0.4, setuptools==62.1.0, wheel==0.37.1
    activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator
  $ source .venv/bin/activate
  $ pip install -r requirements.txt
  ```
