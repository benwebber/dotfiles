c = get_config()

c.InteractiveShellApp.extensions = [
    'autoreload',
]
c.InteractiveShellApp.exec_lines = [
    '%autoreload 1',
]

c.TerminalIPythonApp.display_banner = False

c.TerminalInteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.pdb = True
