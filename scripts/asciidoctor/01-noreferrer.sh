#!/bin/sh

# Adds support for rel="noreferrer" attribute to hyperlinks.
#
# Use `http://example.com[example,opts=noreferrer]` to add the attribute.


set -e

patch -u "$(gem open -e echo asciidoctor)/lib/asciidoctor/converter/html5.rb" 01-noreferrer.patch