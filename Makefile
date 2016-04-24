PREFIX=${HOME}
DATADIR=/data

mkdirs:
	source ${PWD}/.bash/.environment.sh ; mkdir -p ${WORKON_HOME} ${PROJECT_HOME} ${VIRTUALENVWRAPPER_HOOK_DIR} ${USER_LOGDIR} ${USER_TMPDIR}


all: mkdirs install-vcprompt install-bash install-bin install-python install-pip install-sax-virtualenv


install-bash:
	@echo install-bash

	@bash -c "if [ -h ${PREFIX}/.bash ]; then rm ${PREFIX}/.bash; fi"
	ln -fs `pwd`/.bash/ ${PREFIX}/.bash

	@sh -c "if [ -h ~/.profile ]; then rm ~/.profile; fi"
	ln -fs ${PREFIX}/.bash/.profile ${PREFIX}/.profile

	@bash -c "if [ -h ${PREFIX}/.bashrc ]; then rm ${PREFIX}/.bashrc; fi"
	ln -fs ${PREFIX}/.bash/.bashrc ${PREFIX}/.bashrc

	@bash -c "if [ -h ${PREFIX}/.inputrc ]; then rm ${PREFIX}/.inputrc; fi"
	ln -fs ${PREFIX}/.bash/.inputrc ${PREFIX}/.inputrc

	ln -fs ${PREFIX}/.bash/.ansible.cfg ${PREFIX}/.ansible.cfg

ifeq ($(shell uname),Darwin)
	ln -fs ${PREFIX}/.bash/.tmux.conf ${PREFIX}/.tmux.conf
endif


install-git-flow:
	curl -O https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh
	chmod u+x gitflow-installer.sh
	INSTALL_PREFIX=~/bin ./gitflow-installer.sh
	rm -f gitflow-installer.sh


install-bin:
	ln -fs `pwd`/bin/* ${PREFIX}/bin
	ln -fFs `pwd`/supervisord ${PREFIX}/supervisord
ifeq ($(shell uname),Darwin)
else
	rm ${PREFIX}/bin/ssh-copy-id.sh
endif


install-pip:
	ln -fs `pwd`/pip/pip.conf ${PREFIX}/.pip/


install-git:
	ln -fs `pwd`/git/.gitconfig ${PREFIX}/.gitconfig
	ln -fs `pwd`/git/.gitignore ${PREFIX}/.gitignore

install-python:
	#ln -fs `pwd`/python/.pythonrc.py ${PREFIX}/.pythonrc.py
	ln -fs `pwd`/python/.pdbrc.py ${PREFIX}/.pdbrc.py
	ln -fs `pwd`/python/.pydistutils.cfg ${PREFIX}/.pydistutils.cfg
	ln -fs `pwd`/python/buildout.cfg ${PREFIX}/.buildout/default.cfg
	ln -fs `pwd`/python/.pythonrc.py ${PREFIX}/.pythonrc.py
	ln -fs `pwd`/python/.isort.cfg ${PREFIX}/.isort.cfg

	ln -fs `pwd`/.ipython ${PREFIX}/
	ln -fs `pwd`/.bash/.pdbrc.py ${PREFIX}/
	ln -fs `pwd`/.bash/.pdbrc ${PREFIX}/
	ln -fs `pwd`/.bash/.fancycompleterrc.py ${PREFIX}/
	ln -fs `pwd`/.bash/.cookiecutterrc ${PREFIX}/

ifeq ($(shell uname),Darwin)
	ln -fs `pwd`/Library/LaunchAgents/* ${PREFIX}/Library/LaunchAgents
endif


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

install-pycharm:
ifeq ($(shell uname),Darwin)
	cp .PyCharm/pycharm.vmoptions ~/Library/Preferences/PyCharm45/pycharm.vmoptions
endif

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

install-sax-virtualenv:
	virtualenv ${WORKON_HOME}/sax
	${WORKON_HOME}/sax/bin/pip install -U pip ipython uwsgi devpi supervisor
