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

Read `:h lspconfig-all`!

For diagnostics / autocompletion features, install the following language
server:

* [pyright](https://github.com/microsoft/pyright)
* [lua-language-server](https://luals.github.io/#neovim-install)
* [bashls](https://github.com/bash-lsp/bash-language-server)

### Exemples

#### Arch-based

```bash
sudo pacman -S pyright lua-language-server bash-language-server
```


#### Debian-based

```bash
sudo apt install npm
sudo npm i -g pyright
sudo npm i -g bash-language-server
```

lua\_ls can be installed manually from the release page.


## Neovim configuration

```bash
git clone git@github.com:vgitv/nvim.git ~/.config/nvim
```

Open Neovim, wait for Lazy to install the plugins. Then restart Neovim, and run
`:checkhealth` command.

## Special thanks

Special thanks to [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
