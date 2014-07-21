export PATH=/data/jdk/bin:~/bin:$PATH
if [ $(uname) == "Darwin" ];then
	export LC_ALL=en_US.UTF-8
	export LANG=en_US.UTF-8
	export PATH=/Library/PostgreSQL/9.3/bin/:$PATH
fi

# env
DJANGO_DIR="/data/VENV/LIB/django/"
PROJECT_DIR="/data/PROGETTI/saxix/"


# Java
export JAVA_HOME=/data/jdk
export PYCHARM_JDK=/data/jdk
export CLASSPATH=$CLASSPATH:/usr/share/java/libreadline-java.jar

# Oracle
export ORACLE_HOME=/data/oracle/instantclient_11_2
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib/jni/:$ORACLE_HOME
export TNS_ADMIN=~
export DYLD_LIBRARY_PATH=$ORACLE_HOME:$DYLD_LIBRARY_PATH
export VERSIONER_PYTHON_PREFER_32_BIT=Yes

# python
export PYTHONDONTWRITEBYTECODE=1
#unset PYTHONDONTWRITEBYTECODE
export PYTHONSTARTUP="$HOME/.pythonrc.py"
export PYTHONHASHSEED=random


# Enable bash history
export HISTCONTROL=erasedups
export HISTSIZE=5000
shopt -s histappend


# virtualenvwrapper and pip
if [ `id -u` != '0' ]; then
    export WORKON_HOME=/data/VENV
    export PROJECT_HOME=/data/PROGETTI/saxix

    export VIRTUAL_ENV_DISABLE_PROMPT=1
    export VIRTUALENV_USE_DISTRIBUTE=0
#    if [ -e /data/pip_cache/raw ];then
#        export VIRTUALENV_EXTRA_SEARCH_DIR=/data/pip_cache/raw
#    fi

    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
    export VIRTUALENVWRAPPER_HOOK_DIR=/data/VENV/.hooks
    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS=''
    export VIRTUALENVWRAPPER_VIRTUALENV='virtualenv'

    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_REQUIRE_VIRTUALENV=true
    export PIP_RESPECT_VIRTUALENV=true
#    export PIP_DOWNLOAD_CACHE=/data/pip_cache
#    export PIP_USE_MIRRORS=true
fi

export EDITOR=nano
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$SVN_EDITOR
