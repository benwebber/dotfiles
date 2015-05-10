c = get_config()

c.InteractiveShellApp.extensions = [
    'autoreload',
]

c.TerminalIPythonApp.exec_lines = [
    'from __future__ import print_function',
    'import requests',
]

c.TerminalIPythonApp.display_banner = False

c.TerminalInteractiveShell.pdb = True

c.TerminalInteractiveShell.confirm_exit = False
