import pdb
import readline
from fancycompleter import Completer, ConfigurableClass, Color


def format_line(self, lineno, marker, line):
    lineno = '%4d' % lineno
    if self.config.highlight:
        lineno = Color.set(self.config.line_number_color, lineno)
    line = '%s  %2s %s' % (lineno, marker, line)
    if self.config.highlight and marker == '->':
        line = pdb.setbgcolor(line, self.config.current_line_color)
    return "".join(line[:-1])

class Config(pdb.DefaultConfig):
    current_line_color = 40
    highlight = True
    encoding = 'utf-8'
    sticky_by_default = True  # False
    editor = '${EDITOR:-vi}'
    stdin_paste = 'epaste'
    use_terminal256formatter = False
    current_line_color  = 22 # 44
    use_pygments = True # True

    def __init__(self):
        readline.parse_and_bind('set convert-meta on')
        readline.parse_and_bind('Meta-/: complete')

    def setup(self, pdb):
        # make 'l' an alias to 'longlist'
        Pdb = pdb.__class__
        Pdb.do_ll = Pdb.do_longlist
        Pdb.do_l = Pdb.do_list
        Pdb.do_st = Pdb.do_sticky
        Pdb.format_line = lambda self, lineno, marker, line: format_line(self, lineno, marker, line)
