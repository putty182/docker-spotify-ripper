#!/bin/sh
set -u
rm -Rf 

if ! [ -f /config/playlists.txt ]; then
    touch /config/playlists.txt
fi

if ! [ -f /config/config.ini ]; then
    touch /config/config.ini
fi

ln -sfT /config/ ~/.spotify-ripper

PYTHONIOENCODING=UTF-8 spotify-ripper /config/playlists.txt