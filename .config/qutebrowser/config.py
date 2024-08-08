#!/usr/bin/env python3
# load your autoconfig, use this, if the rest of your config is empty!
config.load_autoconfig()

import theme

theme.setup(c, "frappe", True)
config.set("colors.webpage.preferred_color_scheme", "dark")
#  import os
#  from urllib.request import urlopen
#
#
#  if not os.path.exists(config.configdir / "theme.py"):
#      theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
#      with urlopen(theme) as themehtml:
#          with open(config.configdir / "theme.py", "a") as file:
#              file.writelines(themehtml.read().decode("utf-8"))


# set content.headers.accept_language=en-US,en;q=0.5

config.source("qutemacs.py")
# config.set("colors.webpage.lightmode.enabled",True)
# c.fonts.web.size.default = 14
# c.fonts.default_family = "Ubuntu Mono"
# c.fonts.default_size = "11pt"
