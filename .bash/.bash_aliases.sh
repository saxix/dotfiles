# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias tree='tree -AC -I "*.pyc|_darcs|cabal-dev|dist|state"'

if [ $(uname) == "Linux" ];then
    alias apt-get='sudo apt-get'
    alias open='xdg-open'
fi


alias l='less'
alias ll='ls -al'
alias pycclean='find . -name "*.pyc" | xargs -I {} rm -v "{}"'
alias env='env|sort'
alias rm='rm -i'
alias broken='find -L . -type l -ls'
alias proxypypi='$WORKON_HOME/sax/bin/proxypypi -P /tmp/proxypypi.pid -o ~/logs/proxypypi.out -l ~/logs/proxypypi.log -p 31415 -d /data/pypi'

# These set up/down to do the history searching
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

alias ..='cd ..'
alias .-='cd -'

alias e='$EDITOR $@'

alias mkvirtualenvtemp='mkvirtualenv TEMP__$RANDOM'




