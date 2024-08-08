# The aim of this binding set is not to provide bindings for absolutely
# everything, but to provide a stable launching point for people to make their
# own bindings.
#
# Installation:
#
# 1. Copy this file or add this repo as a submodule to your dotfiles.
# 2. Add this line to your config.py, and point the path to this file:
# config.source('qutemacs/qutemacs.py')

config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103

c.tabs.background = True
# disable insert mode completely
c.input.insert_mode.auto_enter = False
c.input.insert_mode.auto_leave = False
c.input.insert_mode.plugins = True
c.input.insert_mode.auto_load = False

# Forward unbound keys
c.input.forward_unbound_keys = "all"

ESC_BIND = "clear-keychain ;; search ;; fullscreen --leave"

import string

c.bindings.default["normal"] = {}
# c.bindings.default['insert'] = {}

# Bindings
c.bindings.commands["normal"] = {
    # Navigation
    # '<Ctrl-a>': 'toggle-selection',
    "<Ctrl-j>": "scroll-page 0 0.2",
    "<Ctrl-k>": "scroll-page 0 -0.2",
    "<Ctrl-home>": "home",
    #  '<alt-v>': 'scroll-page 0 1',
    #  '<alt-Shift-v>': 'scroll-page 0 -1',
    "<Ctrl-t>": "open -t",
    "<Ctrl-Shift-t>": "undo",
    "<Ctrl-r>": "reload",
    "<Ctrl-Shift-r>": "reload -f",
    "<Ctrl-w>": "tab-close",
    "<Ctrl-q>": "quit --save",
    # searching
    "<Ctrl-s>": "cmd-set-text /",
    "<Ctrl-Shift-s>": "cmd-set-text ?",
    # hinting
    "<Ctrl-h>": "hint all",
    "<Ctrl-Shift-m>": "hint links spawn mpv {hint-url}",
    # tabs
    "<Ctrl-tab>": "tab-next",
    "<Ctrl-Shift-tab>": "tab-prev",
    # open links
    "<Ctrl+;>": "cmd-set-text :",
    "<Ctrl-l>": "cmd-set-text -s :open",
    "<Ctrl-Shift-l>": "cmd-set-text -s :open -t",
    # editing
    "<Alt-left>": "back",
    "<Alt-right>": "forward",
    # '<Ctrl-c>': 'yank -s -q selection inline',
    # '<Ctrl-v>': 'insert-text {primary}',
    "<Ctrl-Shift-y>": "yank url",
    "1": "fake-key 1",
    "2": "fake-key 2",
    "3": "fake-key 3",
    "4": "fake-key 4",
    "5": "fake-key 5",
    "6": "fake-key 6",
    "7": "fake-key 7",
    "8": "fake-key 8",
    "9": "fake-key 9",
    "0": "fake-key 0",
    "<Ctrl-1>": "tab-focus 1",
    "<Ctrl-2>": "tab-focus 2",
    "<Ctrl-3>": "tab-focus 3",
    "<Ctrl-4>": "tab-focus 4",
    "<Ctrl-5>": "tab-focus 5",
    "<Ctrl-6>": "tab-focus 6",
    "<Ctrl-7>": "tab-focus 7",
    "<Ctrl-8>": "tab-focus 8",
    "<Ctrl-9>": "tab-focus -1",
    # escape hatch
    "<Ctrl-g>": ESC_BIND,
}

# c.bindings.commands['insert'] = {
#     '<Ctrl-g>': 'leave-mode;;fake-key <Left>;;fake-key <Right>',
#     '<Ctrl-f>': 'fake-key <Shift-Right>',
#     '<Ctrl-b>': 'fake-key <Shift-Left>',
#     # '<Ctrl-a>': 'toggle-selection',
#     '<Ctrl-c>': 'yank -s -q selection inline',
#     '<Ctrl-v>': 'insert-text {primary}',
#      # '<Ctrl-e>': 'fake-key <Shift-End>',
#     '<Ctrl-k>': 'fake-key <Shift-Up>',
#     '<Ctrl-j>': 'fake-key <Shift-Down>',
#     # '<Return>': 'leave-mode',
#     '<backspace>': 'fake-key <backspace>;;leave-mode',
#     '<Ctrl-t>': 'open -t',
#     '<Ctrl-Shift-t>': 'undo --window',
#     '<Ctrl-home>': 'home',
#     '<Ctrl-r>': 'reload',
#     '<Ctrl-Shift-r>': 'reload -f',
#     #  '<Tab>': 'fake-key <f1>'
#
#     # '<Ctrl-Shift-d>': 'set colors.webpage.darkmode.enabled true',
#     # '<Ctrl-d>': 'set colors.webpage.darkmode.enabled false',
# }
#
# for char in list(string.ascii_lowercase):
#     c.bindings.commands['insert'].update({char: 'fake-key ' + char + ';;leave-mode'})
#
# for CHAR in list(string.ascii_uppercase):
#     c.bindings.commands['insert'].update({CHAR: 'fake-key ' + char + ';;leave-mode'})
#
# for num in list(map(lambda x : str(x), range(0, 10))):
#     c.bindings.commands['insert'].update({num: 'fake-key ' + num + ';;leave-mode'})
#
# for symb in [',', '.', '/', '\'', ';', '[', ']', '\\',
#              '!', '@','#','$','%','^','&','*','(',')','-','_', '=', '+', '`', '~',
#              ':', '\"', '<', '>', '?','{', '}', '|']:
#     c.bindings.commands['insert'].update({symb: 'insert-text ' + symb + ' ;;leave-mode'})

c.bindings.commands["command"] = {
    # '<Ctrl-a>': 'toggle-selection',
    "<Ctrl-k>": "completion-item-focus prev",
    "<Ctrl-j>": "completion-item-focus next",
    "<alt-p>": "command-history-prev",
    "<alt-n>": "command-history-next",
    # escape hatch
    "<Ctrl-g>": "leave-mode",
    "<Ctrl-t>": "open -t",
    "<Ctrl-Shift-t>": "undo",
    "<Ctrl-r>": "reload",
    "<Ctrl-Shift-r>": "reload -f",
    "<Ctrl-home>": "home",
    "<Ctrl-w>": "tab-close",
    "<Ctrl-q>": "quit --save",
    "<Ctrl-s>": "search-next",
    "<Ctrl-Shift-s>": "search-prev",
}

c.bindings.commands["hint"] = {
    # escape hatch
    "<Ctrl-g>": "leave-mode",
}


c.bindings.commands["caret"] = {
    # escape hatch
    "<Ctrl-g>": "leave-mode",
}

#  config.bind('<Tab>', 'fake-key <f1>')
