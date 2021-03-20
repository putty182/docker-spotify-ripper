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

if [ -z "${0}" ]; then
    PYTHONIOENCODING=UTF-8 spotify-ripper /config/playlists.txt
else
    PYTHONIOENCODING=UTF-8 spotify-ripper "${0}" "$@"
fi