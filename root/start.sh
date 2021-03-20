#!/bin/sh
set -u
rm -Rf 
touch /config/playlists.txt
ln -sf /config/ ~/.spotify-ripper
pip3 install --upgrade git+https://github.com/putty182/spotify-ripper

if [ -z "${0}" ]; then
    PYTHONIOENCODING=UTF-8 spotify-ripper /config/playlists.txt
else
    PYTHONIOENCODING=UTF-8 spotify-ripper "${0}" "$@"
fi