PREFIX=${HOME}
DATADIR=/data

mkdirs:
	sh ${PWD}/.bash/.environment.sh; mkdir -p ${WORKON_HOME} ${PROJECT_HOME} ${VIRTUALENVWRAPPER_HOOK_DIR} ${PIP_DOWNLOAD_CACHE}


install: mkdirs install-vcprompt install-bash install-bin install-python install-virtualenvwrapper


install-bash:
	@echo install-bash
ifeq ($(shell uname),Darwin)

endif
	@bash -c "if [ -h ${PREFIX}/.bash ]; then rm ${PREFIX}/.bash; fi"
	ln -fs `pwd`/.bash/ ${PREFIX}/.bash

	@bash -c "if [ -h ${PREFIX}/.bash_profile ]; then rm ${PREFIX}/.bash_profile; fi"
	ln -fs ${PREFIX}/.bash/.bash_profile ${PREFIX}/.bash_profile

	@bash -c "if [ -h ${PREFIX}/.inputrc ]; then rm ${PREFIX}/.inputrc; fi"
	ln -fs ${PREFIX}/.bash/.inputrc ${PREFIX}/.inputrc

install-git-flow:
	curl -O https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh
	chmod u+x gitflow-installer.sh
	INSTALL_PREFIX=~/bin ./gitflow-installer.sh
	rm -f gitflow-installer.sh


install-bin:
	@echo install-bin
	ln -fs `pwd`/bin/* ${PREFIX}/bin


install-git:
	@echo install-git
	ln -fs `pwd`/git/.gitconfig ${PREFIX}/.gitconfig
	ln -fs `pwd`/git/.gitignore ${PREFIX}/.gitignore
	curl -o ~/.bash/.git-completion.bash https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -OL

install-python:
	@echo install-python
	ln -fs `pwd`/python/.pythonrc.py ${PREFIX}/.pythonrc.py


install-vcprompt:
	@rm -rf /tmp/vcprompt
	@mkdir -p /tmp/vcprompt
	@cd /tmp/vcprompt && curl -OL https://bitbucket.org/mitsuhiko/vcprompt/get/default.tar.gz && \
	    tar zxf default.tar.gz && cd mitsuhiko-* && make && \
	    echo "Installing vcprompt to ${PREFIX}/bin/vcprompt" && mv vcprompt ${PREFIX}/bin/vcprompt
	@rm -rf /tmp/vcprompt


install-virtualenvwrapper:
ifeq ($(shell uname),Darwin)

endif
	mkdir -p ${VIRTUALENVWRAPPER_HOOK_DIR}
	ln -fs `pwd`/virtualenvwrapper/* ${VIRTUALENVWRAPPER_HOOK_DIR}/


setup:
	@echo install-local
ifeq ($(shell uname),Darwin)
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew install tree bash-completion
endif
    sudo mkdir /data
    chown sax /data
    mkdir -p /data/{VENV/LIB,PROGETTI}

