#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


if [ -f ~/.bash_alias ]; then
       . ~/.bash_alias
fi


# http://maketecheasier.com/8-useful-and-interesting-bash-prompts/2009/09/04
PS1="\[\033[1;37m\]\342\224\214($(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;34m\]\u@\h'; fi)\[\033[1;37m\])\342\224\200(\[\033[1;34m\]\$?\[\033[1;37m\])\342\224\200(\[\033[1;34m\]\@ \d\[\033[1;37m\])\[\033[1;37m\]\n\342\224\224\342\224\200(\[\033[1;32m\]\w\[\033[1;37m\])\342\224\200(\[\033[1;32m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\])\342\224\200> \[\033[0m\]"

if [ "$TERM" == "xterm" ]; then
    # not gnome terminal
    export TERM=xterm-256color
fi

export PYTHONDONTWRITEBYTECODE='PLSSTAAAAAHP!'
export EDITOR=vim
export BLOGSTAGEDIR='/home/justanr/projects/blog'
export BLOGDIR='/home/justanr/projects/ballin-octo-bear'
export BLOGENV='blog'

export WORKON_HOME=~/.virtualenvs
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

export PEP8_IGNORE="E731,W503"

alias mkpy3virt="mkvirtualenv -p $(which python3)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
