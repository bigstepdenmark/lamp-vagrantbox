#!/bin/bash

# ---------------------------------------
# Configure zsh
# ---------------------------------------
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

# Copy zsh config file to home
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# Change zsh theme
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="awesomepanda"/g' ~/.zshrc

# Add promt and aliases to .zshrc config file
echo '

# Prompt
PROMPT="$fg[green]%}$USER@%{$fg[blue]%}~%d ${PROMPT}"

# Aliases
alias c="clear"
alias home="cd ~/"
alias h="cd ~/"
alias pa="php artisan"
alias config="nano ~/.zshrc"
alias del="rm -rf"
alias cpr="cp -r"
alias getsize="du -hs"
alias lines="wc -l"
' >> ~/.zshrc

# Source .zshrc
source ~/.bashrc
