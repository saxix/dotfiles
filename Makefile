PREFIX=${HOME}
DATADIR=/data

mkdirs:
ifeq ($(shell uname),Darwin)

endif
	source "${PWD}/.bash/.environment.sh"
	mkdir -p ${WORKON_HOME} ${PROJECT_HOME} ${VIRTUALENVWRAPPER_HOOK_DIR} ${PIP_DOWNLOAD_CACHE} ${PREFIX}/bin


install: mkdirs install-vcprompt install-bash install-bin install-python install-virtualenvwrapper


install-bash:
	@echo install-bash
	@bash -c "if [ '-h ${PREFIX}/.bash' ]; then rm '${PREFIX}/.bash'; fi"
	ln -fs `pwd`/.bash/ ${PREFIX}/.bash

	@bash -c "if [ '-h ${PREFIX}/.bashrc' ]; then rm '${PREFIX}/.bashrc'; fi"
	ln -fs ${PREFIX}/.bash/.bashrc ${PREFIX}/.bashrc

	@bash -c "if [ '-h ${PREFIX}/.inputrc' ]; then rm '${PREFIX}/.inputrc'; fi"
	ln -fs ${PREFIX}/.bash/.inputrc ${PREFIX}/.inputrc


install-bin:
	@echo install-bin
	ln -fs `pwd`/bin/* ${PREFIX}/bin


install-git:
	@echo install-git
	ln -fs `pwd`/git/.gitconfig ${PREFIX}/.gitconfig
	ln -fs `pwd`/git/.gitignore ${PREFIX}/.gitignore
	curl -o ~/.git-completion.bash https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -OL

install-python:
	@echo install-python
	ln -fs `pwd`/python/.pythonrc.py ${PREFIX}/.pythonrc.py


install-vcprompt:
	@rm -rf /tmp/vcprompt
	@mkdir -p /tmp/vcprompt
	@cd /tmp/vcprompt && curl -OL https://bitbucket.org/mitsuhiko/vcprompt/get/default.tar.gz && \
	    tar zxf default.tar.gz && cd mitsuhiko-* && make && \
	    echo "Installing vcprompt to ~/bin/vcprompt" && mv vcprompt ~/bin/vcprompt
	@rm -rf /tmp/vcprompt


install-virtualenvwrapper: 
	mkdir -p ${VIRTUALENVWRAPPER_HOOK_DIR}
	ln -fs `pwd`/virtualenvwrapper/* ${VIRTUALENVWRAPPER_HOOK_DIR}/
