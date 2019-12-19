#!/bin/sh
BASEDIR=$(dirname "$0")
osacompile -s -o "$BASEDIR/Local Web Server.app" "$BASEDIR/Local Web Server.applescript"
echo "Compiled 'Local Web Server.app'"
cp "$BASEDIR/Icon/droplet.icns" "$BASEDIR/Local Web Server.app/Contents/Resources/"
echo "Default icon replaced"