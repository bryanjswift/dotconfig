# Homebrew

Make sure Xcode and Command Line Tools are installed

```
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
brew install git ctags macvim
```

# Get dotfiles

```
mkdir -p ~/Documents/code && cd ~/Documents/code
git clone git://github.com/bryanjswift/dotconfig.git
git submodule init
git submodule update
```

# bash_login

`echo "source \$HOME/Documents/code/dotconfig/bash_login" > ~/.bash_login`

# vim

```
ln -s $HOME/Documents/code/dotconfig/vim ~/.vim
echo "source ~/.vim/vimrc" > ~/.vimrc
echo "source ~/.vim/gvimrc" > ~/.gvimrc
```

# git

```
echo "[include]" > ~/.gitconfig
echo "  path = Documents/code/dotconfig/gitconfig"
cp ~/Documents/code/dotconfig/gitignore ~/.gitignore
```
