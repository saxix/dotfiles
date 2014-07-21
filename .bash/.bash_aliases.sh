# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#alias tree='tree -AC -I "*.pyc|_darcs|cabal-dev|dist|state"'

if [ $(uname) == "Linux" ];then
    alias apt-get='sudo apt-get'
    alias open='xdg-open'
elif [ $(uname) == "Darwin" ];then
    alias broken='find -L . -type l -ls'
fi


alias l='less'
alias ll='ls -al'
alias la='ls -A'
alias pycclean='find . -name "*.pyc" | xargs -I {} rm -v "{}"'
alias env='env|sort'
alias rm='rm -i'
alias route='route -n'


# These set up/down to do the history searching
if [[ $- == *i* ]];then
    bind '"\e[A"':history-search-backward
    bind '"\e[B"':history-search-forward
fi

alias ..='cd ..'

alias e='$EDITOR $@'

alias mkvirtualenvtemp='mkvirtualenv TEMP__$RANDOM'




