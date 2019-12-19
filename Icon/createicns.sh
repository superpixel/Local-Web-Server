#!/bin/sh
# Assuming 'imagemagick' is installed. (brew install imagemagick)
convert icon-*.tiff icon.tiff
echo "Merged TIFF 'icon.tiff' created"
tiff2icns icon.tiff droplet.icns
echo "Icon file 'droplet.icns' created from multipage TIFF"