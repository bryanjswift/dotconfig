# Homebrew

Make sure Java is installed

```
java --request
```

Make sure Xcode and Command Line Tools are installed

```
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
brew install git ctags macvim rbenv ruby-build tmux s3cmd node scala gpg
```

# Ruby

List ruby versions available with `rbenv install -l`. Recommend installing the latest patch of 1.9.2 and 1.9.3.

# Get dotfiles

```
mkdir -p ~/Documents/code && cd ~/Documents/code
git clone git://github.com/bryanjswift/dotconfig.git
git submodule init
git submodule update
```

# bash_login

```
echo "source \$HOME/Documents/code/dotconfig/config/bash_login" > ~/.bash_login
```

# vim

```
ln -s $HOME/Documents/code/dotconfig/vim ~/.vim
echo "source ~/.vim/vimrc" > ~/.vimrc
echo "source ~/.vim/gvimrc" > ~/.gvimrc
```

# git

```
echo "[include]" > ~/.gitconfig
echo "  path = Documents/code/dotconfig/gitconfig" >> ~/.gitconfig
cp ~/Documents/code/dotconfig/config/gitignore ~/.gitignore
```

# Link other dotfiles

```
ln -s ~/Documents/code/dotconfig/config/rtorrent.rc ~/.rtorrent.rc
ln -s ~/Documents/code/dotconfig/config/screenrc ~/.screenrc
ln -s ~/Documents/code/dotconfig/config/tmux.conf ~/.tmux.conf
ln -s ~/Documents/code/dotconfig/config/tigrc ~/.tigrc
```

# Get Applications from web

* [Vagrant](http://downloads.vagrantup.com)
* [TextMate](https://github.com/textmate/textmate/downloads)
* [Transmit](http://panic.com/transmit)
* [Coda 2](http://panic.com/coda)
* [Adobe Creative Suite](https://creative.adobe.com)
* [VMWare Fusion](http://vmware.com)
