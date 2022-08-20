#!/usr/bin/env bash
# shellcheck shell=bash

# sudo apt-get install bash-completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

alias gitversion="${HOME}/.dotnet/tools/dotnet-gitversion"
alias semver="${HOME}/.dotnet/tools/dotnet-gitversion"
alias semversion="${HOME}/.dotnet/tools/dotnet-gitversion"
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\]\w\[\033[01;32m\]\$\[\033[34m\] '
