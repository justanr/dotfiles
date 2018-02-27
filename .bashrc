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
export EDITOR=nvim
export BLOGSTAGEDIR=~/projects/blog
export BLOGDIR=~/projects/ballin-octo-bear
export BLOGENV='blog'

VIRTUALENVWRAPPER_LOCATION=/usr/local/bin/virtualenvwrapper.sh

if [ -f $VIRTUALENVWRAPPER_LOCATION ]; then
	export WORKON_HOME=~/.virtualenvs;
	source $VIRTUALENVWRAPPER_LOCATION;
fi

if [ -f ~/.blog ]; then
        source ~/.blog;
fi;

export PEP8_IGNORE="E731,W503"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$PATH:~/.npm/bin
export RIPGREP_CONFIG_PATH=~/.ripgreprc
#export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH
#export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
