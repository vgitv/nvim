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


## Plug

See https://github.com/junegunn/vim-plug

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```


## Pyright

For Python autocompletion features (used by
[nvim-cmp](https://github.com/hrsh7th/nvim-cmp) plugin).

### Arch-based

```bash
sudo pacman -S pyright
```


### Debian-based

```bash
sudo apt install npm
sudo npm i -g pyright
```


## Neovim configuration

```bash
git clone git@github.com:vgitv/nvim.git ~/.config/nvim
```

Inside neovim:

```
:PlugInstall
```
