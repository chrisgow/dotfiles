# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

plugins=(git kubectl history-substring-search nulogy)

source $ZSH/oh-my-zsh.sh


# When a new command line being added to the history list duplicates an older
# one, the older command is removed from the list.
setopt HIST_IGNORE_ALL_DUPS

# Do not display duplicates of a line previously found.
setopt HIST_FIND_NO_DUPS

# Commands that start with a space are not added to history.
setopt HIST_IGNORE_SPACE

# When writing out the history, omit older commands that duplicate newer ones.
setopt HIST_SAVE_NO_DUPS

# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS

export EDITOR=vim

# aliases

# store shell configuration in git
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Snip current branch to clipboard
alias gbcopy="git branch --show-current | pbcopy"

# rg <gem_name> - open rubygems for the gem specified
function rg() {
  open "https://rubygems.org/gems/$1"
}

# Shows the branches that have been merged.
alias glm=locally_merged

# use exa - a modern ls replacement - for ls
alias ls='exa'

alias permit_chromedriver='xattr -d com.apple.quarantine $(which chromedriver) > /dev/null 2>&1'

# Brew functions
alias brewdump='pushd $HOME && brew bundle dump --force && popd'
function brupdate { brew update; brew upgrade; brew cleanup; brew doctor; }

function update_homebrew {
  rm -rf /usr/local/var/homebrew/locks
  brew cleanup -q
  brewdump
  brew update -q
  brew upgrade -q
  brew upgrade -q --cask
  brew cleanup -q
  permit_chromedriver
}


# Source from a file that will not go into my dotfiles repo
[ -f .zshrc_private ] && source .zshrc_private

# Nulogy/Packmanager specific settings
export CAPYBARA_MAX_WAIT_TIME=600
export PM_REQUEST_TIMEOUT_IN_MINUTES=10
export PACKMANAGER_HOME=$HOME/d/opscore

alias pm="cd $PACKMANAGER_HOME"
alias dqi="cd $HOME/d/dqi"
#alias mobbing="open https://nulogy.zoom.us/j/7286849403"
#alias old_teamroom="open https://nulogy.zoom.us/j/7513224419\?pwd\=MVkrOVN4alpZSWdrUmZxOTA5K2hCZz09"
alias teamroom="open https://nulogy.zoom.us/j/91076568627\?pwd\=dzFxZ1V5ZHBwYUdacXgyczVoY3hIZz09"
alias okta='open https://nulogy.okta.com/app/UserHome'
alias kb='open https://nulogy-go.atlassian.net/jira/software/c/projects/PM/boards/171'
alias bk='buildkite'

# Use improved outdated
alias outdated='./development/scripts/outdated_gems/outdated_gems.rb'

# Choose openssl over native OS X libraries.
export PATH=/usr/local/opt/openssl/bin:$PATH

# nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.bin:$PATH"

# Calling nvm use automatically in a directory with a .nvmrc file 
# (from https://gist.github.com/tcrammond/e52dfad4c2b36258f83f7a964af10097)
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
