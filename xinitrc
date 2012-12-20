#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Source all the scripts in /etc/X11/xinit/xinitrc.d/
if [ -d /etc/X11/xinit/xinitrc.d  ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
   	[ -x "$f"  ] && . "$f"
  done
  unset f
fi

# gnome keyring settings
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNONE_KEYRING_PID

# urxvtd settings
/usr/bin/urxvtd -q -o -f

# clipboard syncing
/usr/bin/autocutsel -fork &
/usr/bin/autocutsel -selection CLIPBOARD -fork &

# settings for SCIM
export XMODIFIERS=SCIM
export GTK_IM_MODULE="scim"
export QT_IM_MODULE="scim"
scim -d &

# set cursor name
xsetroot -cursor_name left_ptr &

# Hide cursor
unclutter -noevents -idle 5 &

# piping conky to dzen2
dzen2-personalized &

# start compositing manager
xcompmgr &

# wallpaper
nitrogen --restore &
exec dwm

