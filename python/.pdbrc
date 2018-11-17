# The prompt to show when in interactive mode.
prompt = '(pdb++) '
# Highlight line numbers and the current line when showing the
# longlist of a function or when in sticky mode.
highlight = True
# File encoding. Useful when there are international characters
# in your string literals or comments.
encoding = 'utf-8'
# Determine whether pdb++ starts in sticky mode or not.
sticky_by_default = False
# The color to use for line numbers.
# line_number_color = Color.turquoise
# The color to use for file names when printing the stack entries.
# filename_color = Color.yellow
# The background color to use to highlight the current line;
# the background color is set by using the ANSI escape sequence ^[Xm
# where ^ is the ESC character and X is the background color.
# 44 corresponds to "blue".
current_line_color = 44
# If pygments is installed and highlight == True,apply syntax highlight to
# the source code when showing the longlist of a function or when in sticky mode.
use_pygments = True
# Passed directly to the pygments.formatters.
# TerminalFormatter constructor. Selects the color scheme to use, depending
# on the background color of your terminal. If you have a light background color,
# try to set it to 'light'.
bg = 'dark'
# Passed directly to the pygments.formatters.TerminalFormatter constructor.
# It expects a dictionary that maps token types to (lightbg, darkbg)
# color names or None (default: None = use builtin colorscheme).
colorscheme = None
# The command to invoke when using the edit command.
# By default, it uses $EDITOR if set, else vi.
# The command must support the standard notation COMMAND +n filename to open
# filename at line n. emacs and vi are known to support this.
editor = '${EDITOR:-vi}'
# Truncate lines which exceed the terminal width.
truncate_long_lines = True
# Shell command to execute when starting the pdb prompt and the terminal
# window is not focused. Useful to e.g. play a sound to alert the user that
# the execution of the program stopped. It requires the wmctrl module.
exec_if_unfocused = None
# Old versions of py.test crash when you execute pdb.set_trace() in a test,
# but the standard output is captured (i.e., without the -s option, which is the
# default behavior). When this option is on, the stdout capturing is automatically
# disabled before showing the interactive prompt.
disable_pytest_capturing = True
# This method is called during the initialization of the Pdb class.
# Useful to do complex setup.
def setup(self, pdb): pass
