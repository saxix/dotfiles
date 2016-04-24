# -*- coding: utf-8 -*-
import atexit
import os
import readline
import rlcompleter
import sys  # noqa we want it in the interpreter session
from code import InteractiveConsole
from tempfile import mkstemp

sys.dont_write_bytecode = True

historyPath = os.path.expanduser("~/.python_history")

# change autocomplete to tab
if 'libedit' in readline.__doc__:
    readline.parse_and_bind("bind ^I rl_complete")
    readline.parse_and_bind("bind ^R em-inc-search-prev")
else:
    readline.parse_and_bind("tab: complete")


def save_history(historyPath=historyPath):
    import readline
    readline.write_history_file(historyPath)

if os.path.exists(historyPath):
    try:
        readline.read_history_file(historyPath)
    except IOError as e:
        pass
        # raise IOError("%s: %s" % (e, historyPath))

atexit.register(save_history)


class TermColors(dict):
    """Gives easy access to ANSI color codes. Attempts to fall back to no color
    for certain TERM values. (Mostly stolen from IPython.)"""

    COLOR_TEMPLATES = (("Black", "0;30"),
                       ("Red", "0;31"),
                       ("Green", "0;32"),
                       ("Brown", "0;33"),
                       ("Blue", "0;34"),
                       ("Purple", "0;35"),
                       ("Cyan", "0;36"),
                       ("LightGray", "0;37"),
                       ("DarkGray", "1;30"),
                       ("LightRed", "1;31"),
                       ("LightGreen", "1;32"),
                       ("Yellow", "1;33"),
                       ("LightBlue", "1;34"),
                       ("LightPurple", "1;35"),
                       ("LightCyan", "1;36"),
                       ("White", "1;37"),
                       ("Normal", "0"),
                       )

    NoColor = ''
    _base = '\001\033[%sm\002'

    def __init__(self):
        if os.environ.get('TERM') in ('xterm-color', 'xterm-256color',
                                      'linux', 'darwin', 'screen',
                                      'screen-256color', 'screen-bce'):
            self.update(dict([(k, self._base % v)
                              for k, v in self.COLOR_TEMPLATES]))
        else:
            self.update(dict([(k, self.NoColor)
                              for k, v in self.COLOR_TEMPLATES]))
_c = TermColors()

sys.ps1 = '%s>>> %s' % (_c['Green'], _c['Normal'])
sys.ps2 = '%s... %s' % (_c['Red'], _c['Normal'])


# utils
def ver(package):
    import pkg_resources  # part of setuptools
    return pkg_resources.require(package)[0].version


# Welcome message
#################

WELCOME = r"""
%(Cyan)s
You've got color, history, and pretty printing.
(If your ~/.inputrc doesn't suck, you've also
got completion and vi-mode keybindings.)
%(Brown)s
Type \e to get an external editor.
%(Normal)s""" % _c
#
# # atexit.register(lambda: sys.stdout.write("""%(DarkGray)s
# # Sheesh, I thought he'd never leave. Who invited that guy?
# # %(Normal)s""" % _c))
#
#
# Django Helpers
################

def SECRET_KEY():
    "Generates a new SECRET_KEY that can be used in a project settings file."

    from random import choice
    return ''.join(
            [choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)')
                for i in range(50)])

# If we're working with a Django project, set up the environment
if 'DJANGO_SETTINGS_MODULE' in os.environ:
    import django
    try:
        from django.db.models.loading import get_models
    except ImportError:
        from django.apps import apps
        get_models = apps.get_models
        django.setup()
    from django.test.client import Client
    from django.test.utils import setup_test_environment, teardown_test_environment
    from django.conf import settings as S

    class DjangoModels(object):
        """Loop through all the models in INSTALLED_APPS and import them."""
        def __init__(self):
            for m in get_models():
                setattr(self, m.__name__, m)

    M = DjangoModels()
    C = Client()

    WELCOME += """%(Green)s
Django environment detected.
* Your INSTALLED_APPS models are available as `M`.
* Your project settings are available as `S`.
* The Django test client is available as `C`.
%(Normal)s""" % _c

    setup_test_environment()
    S.DEBUG_PROPAGATE_EXCEPTIONS = True

    WELCOME += """%(LightPurple)s
Warning: the Django test environment has been set up; to restore the
normal environment call `teardown_test_environment()`.

Warning: DEBUG_PROPAGATE_EXCEPTIONS has been set to True.
%(Normal)s""" % _c


# # Start an external editor with \e
# ##################################
# # http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/438813/
#
EDITOR = os.environ.get('EDITOR', 'atom')
EDIT_CMD = '\e'

class EditableBufferInteractiveConsole(InteractiveConsole):
    def __init__(self, *args, **kwargs):
        self.last_buffer = [] # This holds the last executed statement
        InteractiveConsole.__init__(self, *args, **kwargs)

    def runsource(self, source, *args):
        self.last_buffer = [ source.encode('utf-8') ]
        return InteractiveConsole.runsource(self, source, *args)

    def raw_input(self, *args):
        line = InteractiveConsole.raw_input(self, *args)
        if line == EDIT_CMD:
            fd, tmpfl = mkstemp('.py')
            os.write(fd, b'\n'.join(self.last_buffer))
            os.close(fd)
            os.system('%s %s' % (EDITOR, tmpfl))
            line = open(tmpfl).read()
            os.unlink(tmpfl)
            tmpfl = ''
            lines = line.split( '\n' )
            for i in range(len(lines) - 1): self.push( lines[i] )
            line = lines[-1]
        return line

if 'DJANGO_SETTINGS_MODULE' not in os.environ:

    c = EditableBufferInteractiveConsole(locals=locals())
    c.interact(banner=WELCOME)

    # Exit the Python shell on exiting the InteractiveConsole
    sys.exit()

    # anything not deleted (sys and os) will remain in the interpreter session
    del atexit, readline, rlcompleter, save_history, historyPath
else:
    print(WELCOME)
