#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
if [ -f ~/.bash_ps1 ]; then . ~/.bash_ps1; fi


if [ -f ~/.bash_alias ]; then
       . ~/.bash_alias
fi

if [ -f ~/.bash_extras ]; then . ~/.bash_extras; fi

if [ "$TERM" == "xterm" ]; then
    # not gnome terminal
    export TERM=xterm-256color
fi

export PYTHONDONTWRITEBYTECODE=1
export EDITOR=vim
export BLOGSTAGEDIR='~/projects/blog'
export BLOGDIR='~/projects/ballin-octo-bear'
export BLOGENV='blog'

VIRTUALENVWRAPPER_LOCATION=/usr/local/bin/virtualenvwrapper.sh

if [ -f $VIRTUALENVWRAPPER_LOCATION ]; then
	export WORKON_HOME=~/.virtualenvs;
	source $VIRTUALENVWRAPPER_LOCATION;
fi

export PEP8_IGNORE="E731,W503"
