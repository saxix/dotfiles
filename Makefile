PREFIX?=${HOME}
DATADIR=/data
UNAME_S := $(shell uname -s)

mkdirs:
	source ${PWD}/_bash/.environment.sh ; mkdir -p ${WORKON_HOME} \
			${PROJECT_HOME} \
			${VIRTUALENVWRAPPER_HOOK_DIR} \
			${USER_LOGDIR} \
			${USER_TMPDIR} 


all: mkdirs install-bash \
			install-bin \
			install-brew \
			install-docker \
			install-pip \
			install-python \
			python-venv \


install-brew:
	@echo install-brew
	ruby -e `curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`
	brew update
	brew upgrade
	brew install expat pyenv git-flow bash-completion


install-bash:
	@echo install-bash

	@bash -c "if [ -h ${PREFIX}/.bash ]; then rm ${PREFIX}/.bash; fi"
	ln -fs `pwd`/_bash/ ${PREFIX}/.bash

	@sh -c "if [ -h ~/.profile ]; then rm ~/.profile; fi"
	ln -fs ${PREFIX}/.bash/.profile ${PREFIX}/.profile

	@bash -c "if [ -h ${PREFIX}/.bashrc ]; then rm ${PREFIX}/.bashrc; fi"
	ln -fs ${PREFIX}/.bash/.bashrc ${PREFIX}/.bashrc

	@bash -c "if [ -h ${PREFIX}/.inputrc ]; then rm ${PREFIX}/.inputrc; fi"
	ln -fs ${PREFIX}/.bash/.inputrc ${PREFIX}/.inputrc


ifeq ($(shell uname),Darwin)
	ln -fs ${PREFIX}/.bash/.tmux.conf ${PREFIX}/.tmux.conf
	ln -fs `pwd`/osx/LaunchAgents/* ${PREFIX}/Library/LaunchAgents/
endif

install-docker:
	if [ ! -d  /Applications/Docker.app ]; then \
		[ -e Docker.dmg ] || wget https://download.docker.com/mac/stable/Docker.dmg; \
		sudo hdiutil attach Docker.dmg; \
		sudo cp -R /Volumes/Docker/Docker.app /Applications; \
		sudo hdiutil detach /Volumes/Docker; \
	fi
	docker &
	cd docker && docker-compose start devpi

install-bin:
	ln -fs `pwd`/bin/* ${PREFIX}/bin


install-pip:
	mkdir -p ${PREFIX}/.pip
	ln -fs `pwd`/pip/pip.conf ${PREFIX}/.pip/


install-git:
	ln -fs `pwd`/git/.gitconfig ${PREFIX}/.gitconfig
	ln -fs `pwd`/git/.gitignore ${PREFIX}/.gitignore


install-python:
	ln -fs `pwd`/python/.pypirc ${PREFIX}/.pypirc
	ln -fs `pwd`/python/.pdbrc.py ${PREFIX}/.pdbrc.py
	ln -fs `pwd`/python/.pdbrc ${PREFIX}/.pdbrc
	ln -fs `pwd`/python/.pydistutils.cfg ${PREFIX}/.pydistutils.cfg
	ln -fs `pwd`/python/.pythonrc.py ${PREFIX}/.pythonrc.py
	ln -fs `pwd`/python/.isort.cfg ${PREFIX}/.isort.cfg
	ln -fs `pwd`/python/.cookiecutterrc ${PREFIX}/
	ln -fs `pwd`/python/.fancycompleterrc.py ${PREFIX}/

	ln -fs `pwd`/_ipython ${PREFIX}/.ipython
#	PIPSI
	curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
	pipsi install cookiecutter tox twine pre-commit pipenv

ifeq ($(shell uname),Darwin)
#	brew install readline pyenv
#	-xcode-select --install
endif
	pyenv install 2.7.14
	pyenv install 3.3.7
	pyenv install 3.4.7
	pyenv install 3.5.4
	pyenv install 3.6.4
	pyenv install pypy2.7-5.9.0
	pyenv global 2.7.14 3.3.7 3.4.7 3.5.4 3.6.4 pypy2.7-5.9.0


install-odbc:
ifeq ($(shell uname),Darwin)
	brew install unixodbc
	brew install freetds --with-unixodbc
	ln -fs `pwd`/odbc/.odbc* ${PREFIX}
	ln -fs `pwd`/odbc/.freetds.conf ${PREFIX}
	find /usr/local/Cellar/freetds/ -name freetds.conf | xargs -0 -I file ln -fs ~/.freetds.conf file
	# ; AA=`find /usr/local/Cellar/freetds/ -name freetds.conf` rm -f ${AA} ; ln -fs ~/.freetds.conf ${AA}
	# ;find /usr/local/Cellar/freetds/ -name freetds.conf | xargs chmod 554
endif


install-vcprompt:
	@rm -rf /tmp/vcprompt
	@mkdir -p /tmp/vcprompt
	@cd /tmp/vcprompt && curl -OL https://bitbucket.org/mitsuhiko/vcprompt/get/default.tar.gz && \
	    tar zxf default.tar.gz && cd mitsuhiko-* && make && \
	    echo "Installing vcprompt to ~/bin/vcprompt" && mv vcprompt ~/bin/vcprompt
	@rm -rf /tmp/vcprompt


test:
	mkdir -p ~build
	PREFIX=${PWD}/~build $(MAKE) install-bash
