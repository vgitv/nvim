# Neovim configuration

## Font

Install and set an appropriate font, for instance from
[nerdfonts.com](https://www.nerdfonts.com/).

Exemple:

```bash
# Download Hack Nerd Font

# Install font
mkdir -p "$XDG_DATA_HOME"/fonts
unzip Hack.zip -d "$XDG_DATA_HOME"/fonts
fc-cache -rv
```


## Language server

### Introduction

For Python autocompletion features (used by
[nvim-cmp](https://github.com/hrsh7th/nvim-cmp) plugin).

Install the following language server:

* [pyright](https://github.com/microsoft/pyright)
* [lua-language-server](https://luals.github.io/#neovim-install)

### Exemples

#### Arch-based

```bash
sudo pacman -S pyright lua-language-server
```


#### Debian-based

```bash
sudo apt install npm
sudo npm i -g pyright
```


## Neovim configuration

```bash
git clone git@github.com:vgitv/nvim.git ~/.config/nvim
```
