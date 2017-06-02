# dotfiles

Yet another set of dotfiles.

## Usage

Use [GNU Stow](http://www.gnu.org/software/stow/) to manage symlinks.

On Ubuntu:
```
apt-get install stow
git clone git@github.com:Neki/dotfiles.gitu

cd dotfiles
stow ctags i3 neovim urxvt zsh  #  ...

# Full invocation (no matter what cwd is)
# stow -d dotfiles -t ~
```

## Required software

Incomplete and probably outdated list:
* [rg](https://github.com/BurntSushi/ripgrep)
* tig (apt-get install tig)
* YouCompleteMe build dependencies
* [vim-plug](https://github.com/junegunn/vim-plug)
* [zplug](https://github.com/zplug/zplug)
* ...
