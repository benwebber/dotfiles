c = get_config()

c.InteractiveShellApp.extensions = [
    'autoreload',
]

c.TerminalIPythonApp.display_banner = False

c.TerminalInteractiveShell.pdb = True

c.TerminalInteractiveShell.confirm_exit = False
