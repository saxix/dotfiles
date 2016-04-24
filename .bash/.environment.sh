#!/bin/bash

export PATH=~/bin:/usr/local/bin:$PATH

if [ $(uname) == "Darwin" ];then
	export LC_ALL=en_US.UTF-8
	export LANG=en_US.UTF-8
	# export PATH=/Library/PostgreSQL/9.3/bin:$PATH
	export PATH=/usr/local/mysql/bin:/Users/sax/.gem/ruby/2.0.0/bin:/usr/local/sbin:$PATH
    export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.0.13/lib/pkgconfig/
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/mysql/lib/
else
    export PATH=/data/jdk/bin:$PATH
fi
DISPLAY=:0.0 ; export DISPLAY

export USER_LOGDIR=${HOME}/logs/
export USER_TMPDIR=${HOME}/tmp/

# Django
#export DJANGO_14='-e /data/VENV/LIB/django/1.4.x'
#export DJANGO_15='-e /data/VENV/LIB/django/1.5.x'
#export DJANGO_16='-e /data/VENV/LIB/django/1.6.x'
#export DJANGO_17='-e /data/VENV/LIB/django/1.7.x'
#export DJANGO_DEV='-e /data/VENV/LIB/django/trunk'

# env
export DJANGO_DIR="/data/VENV/LIB/django/"
export PROJECT_DIR="/data/PROGETTI/saxix/"


# Java
#export JAVA_HOME=/data/jdk
#export PYCHARM_JDK=/data/jdk
#export CLASSPATH=$CLASSPATH:/usr/share/java/libreadline-java.jar

# Oracle
export ORACLE_HOME=/data/oracle/instantclient_11_2
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib/jni/:$ORACLE_HOME
export TNS_ADMIN=~
export DYLD_LIBRARY_PATH=$ORACLE_HOME:$DYLD_LIBRARY_PATH
export VERSIONER_PYTHON_PREFER_32_BIT=Yes

# python
export PYTHONDONTWRITEBYTECODE=True
export PYTHONSTARTUP="$HOME/.pythonrc.py"
export PYTHONHASHSEED=random


# Enable bash history
export HISTCONTROL=erasedups
export HISTSIZE=5000
shopt -s histappend

# node
export NODE_PATH=/data/node_modules

# virtualenvwrapper and pip
if [ `id -u` != '0' ]; then
    export WORKON_HOME=/data/VENV
    export PROJECT_HOME=/data/PROGETTI/saxix

    export VIRTUAL_ENV_DISABLE_PROMPT=1
    export VIRTUALENV_USE_DISTRIBUTE=0
#    if [ -e /data/pip_cache/raw ];then
#        export VIRTUALENV_EXTRA_SEARCH_DIR=/data/pip_cache/raw
#    fi

	export VIRTUALENVWRAPPER_PYTHON=/Users/sax/.pyenv/shims/python
    export VIRTUALENVWRAPPER_HOOK_DIR=/data/VENV/.hooks
    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS=''
    export VIRTUALENVWRAPPER_VIRTUALENV='virtualenv'
	export VIRTUALENVWRAPPER_WORKON_CD=1

    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_REQUIRE_VIRTUALENV=true
    export PIP_RESPECT_VIRTUALENV=true
#    export PIP_DOWNLOAD_CACHE=/data/pip_cache
#    export PIP_USE_MIRRORS=true
#
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH=${PYENV_ROOT}/shims:$PATH

fi

export EDITOR=vi
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$SVN_EDITOR


# terminal
# a black
# b red
# c green
# d brown
# e blue
# f magenta
# g cyan
# h light grey
# A bold black, usually shows up as dark grey
# B bold red
# C bold green
# D bold brown, usually shows up as yellow
# E bold blue
# F bold magenta
# G bold cyan
# H bold light grey; looks like bright white
# x default foreground or background
#
# The order of the attributes are as follows:
# 1. directory
# 2. symbolic link
# 3. socket
# 4. pipe
# 5. executable
# 6. block special
# 7. character special
# 8. executable with setuid bit set
# 9. executable with setgid bit set
# 10. directory writable to others, with sticky bit
# 11. directory writable to others, without sticky bit

export CLICOLOR=1
export LSCOLORS=HxGxxxxxbx
# export LSCOLORS=GxFxCxDxBxegedabagaced
