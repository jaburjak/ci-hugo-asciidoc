#!/bin/sh

# Adds support for setting maximum width of images.
#
# Use `image::example.svg[example,maxwidth=256px]` to set the desired maximum width.


set -e

patch -u "$(gem open -e echo asciidoctor)/lib/asciidoctor/converter/html5.rb" maxwidth.patch