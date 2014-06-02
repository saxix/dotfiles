PREFIX=${HOME}
DATADIR=/data

mkdirs:
	sh ${PWD}/.bash/.environment.sh; mkdir -p ${WORKON_HOME} ${PROJECT_HOME} ${VIRTUALENVWRAPPER_HOOK_DIR} ${PIP_DOWNLOAD_CACHE}


all: mkdirs install-vcprompt install-bash install-bin install-python install-pip


install-bash:
	@echo install-bash
ifeq ($(shell uname),Darwin)

endif
	@bash -c "if [ -h ${PREFIX}/.bash ]; then rm ${PREFIX}/.bash; fi"
	ln -fs `pwd`/.bash/ ${PREFIX}/.bash

	@sh -c "if [ -h ~/.profile ]; then rm ~/.profile; fi"
	ln -fs ${PREFIX}/.bash/.profile ${PREFIX}/.profile

	@bash -c "if [ -h ${PREFIX}/.bashrc ]; then rm ${PREFIX}/.bashrc; fi"
	ln -fs ${PREFIX}/.bash/.bashrc ${PREFIX}/.bashrc

	@bash -c "if [ -h ${PREFIX}/.inputrc ]; then rm ${PREFIX}/.inputrc; fi"
	ln -fs ${PREFIX}/.bash/.inputrc ${PREFIX}/.inputrc

	ln -fs ${PREFIX}/.bash/.ansible.cfg ${PREFIX}/.ansible.cfg

install-git-flow:
	curl -O https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh
	chmod u+x gitflow-installer.sh
	INSTALL_PREFIX=~/bin ./gitflow-installer.sh
	rm -f gitflow-installer.sh


install-bin:
	ln -fs `pwd`/bin/ ${PREFIX}/


install-pip:
	ln -fs `pwd`/pip/pip.conf ${PREFIX}/.pip/


install-git:
	ln -fs `pwd`/git/.gitconfig ${PREFIX}/.gitconfig
	ln -fs `pwd`/git/.gitignore ${PREFIX}/.gitignore

install-python:
	ln -fs `pwd`/python/.pythonrc.py ${PREFIX}/.pythonrc.py


install-vcprompt:
	@rm -rf /tmp/vcprompt
	@mkdir -p /tmp/vcprompt
	@cd /tmp/vcprompt && curl -OL https://bitbucket.org/mitsuhiko/vcprompt/get/default.tar.gz && \
	    tar zxf default.tar.gz && cd mitsuhiko-* && make && \
	    echo "Installing vcprompt to ~/bin/vcprompt" && mv vcprompt ~/bin/vcprompt
	@rm -rf /tmp/vcprompt


install-virtualenvwrapper: mkdirs
	mkdir -p ${VIRTUALENVWRAPPER_HOOK_DIR}
	ln -fs `pwd`/virtualenvwrapper/* ${VIRTUALENVWRAPPER_HOOK_DIR}/
