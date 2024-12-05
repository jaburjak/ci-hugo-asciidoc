#!/bin/sh

# Adds support for rel="noreferrer" attribute to hyperlinks.
#
# Use `http://example.com[example,opts=noreferrer]` to add the attribute.


set -e

FILE="/var/lib/gems/3.1.0/gems/asciidoctor-2.0.23/lib/asciidoctor/converter/html5.rb"

if !(grep -F "rel = 'nofollow' if node.option? 'nofollow'" "$FILE" >/dev/null 2>&1); then
	echo 'Cannot find line to patch.'
	exit 1
fi

sed -i -E "s/(rel = 'nofollow' if node\\.option\\? 'nofollow')/\\1\nrel = (rel || '') + ' noreferrer' if node.option? 'noreferrer'\nrel = rel.strip if rel\nrel = nil if rel == ''/" "$FILE"