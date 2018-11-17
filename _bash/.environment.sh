#!/bin/bash

#if [ "`shopt -q login_shell`" == "" ];then
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
#$i

if [ $(uname) == "Darwin" ];then
	export LC_ALL=en_US.UTF-8
	export LANG=en_US.UTF-8
	export BREW_PREFIX=$(brew --prefix)
    export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.0.13/lib/pkgconfig/
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/Cellar/mysql/5.7.13/lib/
fi
DISPLAY=:0.0 ; export DISPLAY

export USER_LOGDIR=${HOME}/logs/
export USER_TMPDIR=${HOME}/tmp/
export PGHOST=127.0.0.1
export PGUSER=postgres

# pipenv
# http://pipenv-ja.readthedocs.io/ja/latest/advanced.html#configuration-with-environment-variables
export PIPENV_VENV_IN_PROJECT=1
#PIPENV_DOTENV_LOCATION=
#export PIPENV_DONT_LOAD_ENV=0
export PIPENV_DEFAULT_PYTHON_VERSION=3.6
export PIPENV_SHELL_FANCY=0
# expat
if [ $(uname) == "Darwin" ];then
    export LDFLAGS="-L$BREW_PREFIX/opt/expat/lib $LDFLAGS"
    export CPPFLAGS="-I$BREW_PREFIX/opt/expat/include $CPPFLAGS"
fi

# openssl
if [ $(uname) == "Darwin" ];then
    export PATH="/usr/local/opt/openssl/bin:$PATH"
 	export LDFLAGS="-L$BREW_PREFIX/openssl/lib $LDFLAGS"
	export CPPFLAGS="$CPPFLAGS -I$BREW_PREFIX/opt/openssl/include"
	export PKG_CONFIG_PATH="$PKG_CONFIG_PATH,$BREW_PREFIX/opt/openssl/lib/pkgconfig"
	export CFLAGS="-I$BREW_PREFIX/openssl/include -I$(xcrun --show-sdk-path)/usr/include $CFLAGS "
fi

# readline
if [ $(uname) == "Darwin" ];then
	LDFLAGS="-L$BREW_PREFIX/readline/lib $LDFLAGS"
	CFLAGS="-I$BREW_PREFIX/readline/ $CFLAGS"
fi

# env
export DJANGO_DIR="/data/VENV/LIB/django/"
export PROJECT_DIR="/data/PROGETTI/saxix/"
export PROJECT_HOME="/data/PROGETTI/saxix"
export WORKON_HOME="/data/VENV"


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

# pip
export PIP_IGNORE_INSTALLED=1

export EDITOR=vi
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$SVN_EDITOR
export DEVPI_ROOT=/data/devpi/root

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
