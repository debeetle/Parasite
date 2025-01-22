#!/usr/bin/env python3
# load your autoconfig, use this, if the rest of your config is empty!
config.load_autoconfig()

import dracula

dracula.setup(c)
config.set("colors.webpage.preferred_color_scheme", "dark")

# set content.headers.accept_language=en-US,en;q=0.5

config.source("qutemacs.py")
# config.set("colors.webpage.lightmode.enabled",True)
# c.fonts.web.size.default = 14
# c.fonts.default_family = "Ubuntu Mono"
# c.fonts.default_size = "11pt"

# dracula.blood(c, {"spacing": {"vertical": 6, "horizontal": 8}})
