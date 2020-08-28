# Languages and Initial Setup

Make sure Xcode and Command Line Tools are installed. Install Homebrew. Check
[brew.sh][brew] for the latest installation instructions.

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Install the basic tools:

    brew install git tig macvim tmux

[brew]: https://brew.sh

## Java

If Java is not installed `java -version` (on macOS) will open a window linking
to the installer. There are alternatives available in Homebrew such as
[AdoptOpenJDK][adoptopenjdk]. The adoptopenjdk formulae run package installers
so require a root or sudo password.

    # Access adoptopenjdk formulae
    brew tap adoptopenjdk/openjdk
    # Install the latest from adoptopenjdk
    brew cask install adoptopenjdk
    # Install useful versions for lambda development
    brew cask install adoptopenjdk8 adoptopenjdk11 adoptopenjdk14

[adoptopenjdk]: https://adoptopenjdk.net

To set a specific JDK version

    # adoptopenjdk8 = version 1.8
    # adoptopenjdk11 = version 11
    # adoptopenjdk14 = version 14
    export JAVA_HOME=$(/usr/libexec/java_home -v <version>

## Ruby

Ruby versions can be managed with [`rbenv`][rbenv] and installed with
[`ruby-install`][ruby-install].

    brew install rbenv ruby-install

List ruby versions available with `rbenv install -l`.

[rbenv]: https://github.com/rbenv/rbenv
[ruby-install]: https://github.com/postmodern/ruby-install

# Get and Setup dotfiles

    mkdir -p ~/Documents/code && cd ~/Documents/code
    git clone git://github.com/bryanjswift/dotconfig.git
    git submodule update --init

## bash_login

Sourcing the `bash_login` file as below can also be done in a `.profile` file
if `.bash_login` doesn't already exist.

    # Include the bash_login file from dotfiles
    echo "source \$HOME/Documents/code/dotconfig/config/bash_login" > ~/.profile

## [starship](https://starship.rs)

    # Link the starship configuration.
    mkdir -p ~/.config
    ln -s $HOME/Documents/code/dotconfig/config/starship.toml ~/.config/starship.toml

## vim

    # Link the vim directory from dotfiles to $HOME
    ln -s $HOME/Documents/code/dotconfig/vim ~/.vim
    # Source the vimrc and gvimrc files from dotfiles in the editor defaults
    echo "source ~/.vim/vimrc" > ~/.vimrc
    echo "source ~/.vim/gvimrc" > ~/.gvimrc

## git

    # Create an "include" block in the root git config file
    echo "[include]" > ~/.gitconfig
    # Source the gitconfig file from dotfiles
    echo "  path = Documents/code/dotconfig/config/gitconfig" >> ~/.gitconfig
    # Copy a global gitignore file into place
    cp ~/Documents/code/dotconfig/config/gitignore ~/.gitignore

# offlineimap and company

Make it possible to read mail locally and offline from the terminal (or
anything supporting Maildir). Open up the 'Keychain Access' app and add the
entries for IMAP and SMTP servers referenced in
[config/offlineimap/offlineimaprc](config/offlineimap/offlineimaprc) and
[config/msmtprc](config/msmtprc). IMAP entries have should have a 'where' of
`http://imap.domain.name`; SMTP entries should have a 'where' of
`smtp://smtp.domain.name`. See [Steve Losh's the Homely
Mutt](http://stevelosh.com/blog/2012/10/the-homely-mutt/), specifically the
section on [Retrieving
Passwords](http://stevelosh.com/blog/2012/10/the-homely-mutt/#retrieving-passwords)
for more information about seeting this up.

    # Install the tools for syncing, reading and sending email locally
    brew install lynx msmtp mutt offlineimap
    # Add the command line tool for searching the macOS contacts
    brew install keith/formulae/contacts-cli
    # Link dotfiles for these tools into the home directory
    ln -s ~/Documents/code/dotconfig/config/mutt ~/.mutt
    ln -s ~/Documents/code/dotconfig/config/offlineimap ~/.offlineimap
    ln -s ~/Documents/code/dotconfig/config/msmtprc ~/.msmtprc
    ln -s ~/Documents/code/dotconfig/config/offlineimap/offlineimaprc ~/.offlineimaprc
    # Link the cert bundle into the volume where maildirs are stored
    ln -s ~/Documents/code/dotconfig/certs/ca-bundle.crt /Volumes/Mail/ca-bundle.crt

## Certificate Authority

[certs/ca-bundle.crt](certs/ca-bundle.crt) comes from
[curl.haxx.se][cabundle] and can be used as a certificate authority
trust file. The bundle is linked from the [curl project][curl]. The certs
are extracted fromt he Mozilla CA bundle and converted to PEM using
[mk-ca-bundle.pl][mkbundle] from the curl repository.

[cabundle]: https://curl.haxx.se/docs/caextract.html
[curl]: http://curl.haxx.se/docs/caextract.html
[mkbundle]: https://github.com/bagder/curl/blob/master/lib/mk-ca-bundle.pl

# gpg

If `gpg-agent` isn't installed and running then signing commits can get to be
quite cumbersome, particularly during `git rebase` executions. The gpg setup
and config files are cribbed from [yoshuawuyts][yoshuawuyts-gpg].

    brew install gpg pinentry-mac
    mkdir ~/.gnupg
    cp config/gpg/gpg.conf config/gpg/gpg-agent.conf ~/.gnupg

[yoshuawuyts-gpg]: https://gist.github.com/yoshuawuyts/69f25b0384d41b46a126f9b42d1f9db2

# Link other dotfiles

    # Link dotfile for tmux into the home directory
    ln -s ~/Documents/code/dotconfig/config/tmux.conf ~/.tmux.conf
    # Link dotfile for tig into the home directory
    ln -s ~/Documents/code/dotconfig/config/tigrc ~/.tigrc

# Get Applications from web

* [1Password](https://agilebits.com/downloads)
* [Visual Studio Code](https://code.visualstudio.com)
