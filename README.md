# dotfiles

Yet another set of dotfiles.

## Usage

Use [GNU Stow](http://www.gnu.org/software/stow/) to manage symlinks.

On Ubuntu:

```
apt-get install stow
git clone git@github.com:Neki/dotfiles.git

cd dotfiles
stow ctags i3 neovim zsh  #  ...

# Full invocation (no matter what cwd is)
# stow -d dotfiles -t ~
```

## Required software

Incomplete and probably outdated list:

-   [rg](https://github.com/BurntSushi/ripgrep)
-   tig (apt-get install tig)
-   [vim-plug](https://github.com/junegunn/vim-plug)
-   [zplug](https://github.com/zplug/zplug)
-   [fzf](https://github.com/junegunn/fzf)
-   ...
