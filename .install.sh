#! /bin/bash

echo "Setting up your Mac..."

#
# Set up Mac defaults
#
.macos/osx
.macos/macos-enable-sudo-pam_tid

#
# Set up git (using Nulogy's config)
git config --global push.default simple
git config --global remote.origin.push HEAD
git config --global branch.autosetupmerge true
git config --global color.branch auto
git config --global color.diff auto
git config --global color.ui true

#
# set up oh-my-zsh
#
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# TODO: Pick a patched font
#
# install brew - instructions from brew.sh
#
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file .brew_manifest

# 
# set up rvm
#
echo "Setting up RVM"
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

