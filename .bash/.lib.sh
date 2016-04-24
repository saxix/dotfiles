source ~/.bash/.colors.sh

function ad {
	if [ -e "$DJANGO_DIR/$1/django" ];then
		pip uninstall -y django
		pip install --pre -e "$DJANGO_DIR/$1"
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

function zapvivrtualenv {

    if [ -e $VIRTUAL_ENV ]; then
        pip list | while read line
        do
            pkg=`echo $line | awk '{print $1;}'`
            if [ "$pkg" != "pip" -a "$pkg" != "setuptools" ];then
                echo "uninstall" $pkg
                pip uninstall -y -q $pkg
            fi
        done
    fi
}

function cleanvivrtualenv {

    if [ -e $VIRTUAL_ENV ]; then
        cat src/requirements/install.any.pip | while read line
        do
            pkg=`echo $line | awk '{print $1;}'`
            if [ "$pkg" != "pip" -a "$pkg" != "setuptools" ];then
                echo "uninstall" $pkg
                pip uninstall -y -q "$pkg"
            fi
        done
    fi
}

function clean_project_dir {
    find . -name ".tox" -type d | xargs rm -fr
    find . -name "*.pyc" -type f | xargs rm -fr
    find . -name "~build" -type d | xargs rm -fr
}

function vpn-connect {
    /usr/bin/env osascript <<-EOF
tell application "System Events"
        tell current location of network preferences
                set VPN to service "mobile.wfp.org" -- your VPN name here
                if exists VPN then connect VPN
        end tell
end tell
EOF
# insert your commands here
}

function vpn-disconnect {
/usr/bin/env osascript <<-EOF
tell application "System Events"
        tell current location of network preferences
                set VPN to service "UniVPN" -- your VPN name here
                if exists VPN then disconnect VPN
        end tell
end tell
return
EOF
}
