#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

syndaemon -t -k -i 2 -d &
/usr/lib/notification-daemon/notification-daemon &
guake &
feh --bg-scale /usr/share/slim/themes/debian-spacefun/background.jpg &
exec i3
