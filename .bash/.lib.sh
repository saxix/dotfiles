
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
	for command in fab ipython pep8 flake8 symilar coverage coverage2 coverage-2.7 tox codepaths.py epylint pylint* pytest py.test py.test-* sphinx-* gjslint fixjsstyle clonedigger tx; do
		#ls $TEST_ENV/bin/$command
        if [ -h "$VIRTUAL_ENV/bin/$command" ]; then
            echo "symbolic link for '$command' exists"
        else
        	echo "creating symbolic link for '$command'"
		    ln -fs "$TEST_ENV/bin/$command" "$VIRTUAL_ENV/bin/"
		fi
	done
}

function updatetestvenv {
	TEST_ENV=/data/VENV/testing
	echo "Update testing packaging and utilities to " $VIRTUAL_ENV
    pip freeze | xargs pip install -U
    ~/bin/fix_python_sha-bang.py
}

