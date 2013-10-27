# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias tree='tree -AC -I "*.pyc|_darcs|cabal-dev|dist|state"'

alias apt-get='sudo apt-get'
alias open='xdg-open'
alias e='gvim'
alias l='less'
alias pycclean='find . -name "*.pyc" | xargs -I {} rm -v "{}"'
alias env='env|sort'
alias rm='rm -i'

# These set up/down to do the history searching
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

alias ..='cd ..'
alias .-='cd -'

alias edit='$EDITOR $@'

alias mkvirtualenvtemp='mkvirtualenv TEMP__$RANDOM'


function ad {
	if [ -e "$DJANGO_DIR/$1/django" ];then
		pip uninstall -y django
		pip install -e "$DJANGO_DIR/$1"
	fi
}

function addtesting {
	TEST_ENV=/data/VENV/testing
	echo "Adding testing packaging and utilities to " $VIRTUAL_ENV
	add2virtualenv /data/VENV/testing/lib/python2.7/site-packages
	for command in fab ipython pep8 flake8 symilar coverage coverage2 coverage-2.7 tox codepaths.py epylint pylint* pytest py.test py.test-* sphinx-* gjslint fixjsstyle clonedigger tx; do
		echo "creating symbolic link for '$command'"
		#ls $TEST_ENV/bin/$command
		ln -s $TEST_ENV/bin/$command $VIRTUAL_ENV/bin/
	done
}




