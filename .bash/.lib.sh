source ~/.bash/.colors.sh

function ad {
	if [ -e "$DJANGO_DIR/$1/django" ];then
		pip uninstall -y django
		pip install -e "$DJANGO_DIR/$1"
	fi
}

function addtestvenv {
	TEST_ENV=/data/VENV/testing
	echo "Adding testing packaging and utilities to " $VIRTUAL_ENV
	add2virtualenv /data/VENV/testing/lib/python2.7/site-packages
	for command in fab ipython pep8 flake8 symilar  \
	                tox codepaths.py epylint gjslint fixjsstyle \
	                clonedigger tx \
	                py* sphinx-* rst2*; do
	    cd $TEST_ENV/bin/
		for cmd in `ls -w1 $command`; do
            if [ -h "$VIRTUAL_ENV/bin/$cmd" ]; then
                warn "${YELLOW}symbolic link for '$cmd' exists" ;
            else
                success "creating symbolic link for '$cmd'";
                ln -fs "$TEST_ENV/bin/$cmd" "$VIRTUAL_ENV/bin/"
#                echo "ln -fs '$cmd' '$VIRTUAL_ENV/bin/'"
            fi
	    done
	done
}

function updatetestvenv {
	TEST_ENV=/data/VENV/testing
	echo "Update testing packaging and utilities to " $VIRTUAL_ENV
    pip freeze | xargs pip install -U
    ~/bin/fix_python_sha-bang.py
}

