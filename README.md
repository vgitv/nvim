# Neovim configuration

## Font

If needed, install and set an appropriate font from
[nerdfonts.com](https://www.nerdfonts.com/).

For instance Hack font:

```bash
# TODO: download Hack Nerd Font

# Install
mkdir -p "$XDG_DATA_HOME"/fonts
unzip Hack.zip -d "$XDG_DATA_HOME"/fonts
fc-cache -rv
```

Set the font in the terminal emulator.


## Language server

### Introduction

For Lua and Python autocompletion features, install the following language
server:

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

lua\_ls can be installed manually from the release page.


## Neovim configuration

```bash
git clone git@github.com:vgitv/nvim.git ~/.config/nvim
```

Open Neovim, wait for Lazy to install the plugins. Then restart Neovim, and run
`:checkhealth` command.
