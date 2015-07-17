[[ -s /home/sax/.nvm/nvm.sh ]] && . /home/sax/.nvm/nvm.sh # This loads NVM

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ $(uname) == "Darwin" ];then
    source $(brew --prefix)/etc/bash_completion
    source /sw/bin/init.sh
#    launchctl start net.devpi
# elif [[ $- == *i* ]] && [ -e /data/VENV/sax/bin/devpi-server ]; then
#    devpi-server --host=0.0.0.0 --port=3141 --serverdir=/data/pypi_cache &
fi

source ~/.bash/.lib.sh
source ~/.bash/.environment.sh
source ~/.bash/.bash_aliases.sh
source ~/.bash/.git-prompt
if [ -e /usr/local/bin/virtualenvwrapper.sh ];then
    source /usr/local/bin/virtualenvwrapper.sh
fi


source ~/.bash/.git-completion.bash
source ~/.bash/.bash-completion-fabric.sh
source ~/.bash/.bash-completion-django.sh
source ~/.bash/.bash-completion-gitflow.sh
source ~/.bash/.bash-completion-cd.sh
source ~/.bash/.bash-completion-cookiecutter.sh
source ~/.bash/.bash-completion-vagrant.sh


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
elif [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

DISPLAY=:0.0 ; export DISPLAY

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
