#!/bin/sh

# Add support for alternative syntax that allows nesting open blocks.
# 
# For example:
# [open]
# ====
# [open]
# =====
# nested
# =====
# ====

set -e

gem_path="$(gem open -e echo asciidoctor)"

mkdir -p "$gem_path/lib/asciidoctor/lab_ext/"

curl 'https://raw.githubusercontent.com/asciidoctor/asciidoctor-extensions-lab/ad5cdd659e78d034d44425eb2cabc8ce1aceb133/lib/nested-open-block.rb' -o "$gem_path/lib/asciidoctor/lab_ext/nested_open_block.rb"

if [ ! -f "$gem_path/lib/asciidoctor/lab_ext.rb" ]; then
	echo '# frozen_string_literal: true' > "$gem_path/lib/asciidoctor/lab_ext.rb"
fi

echo "require_relative 'lab_ext/nested_open_block'" >> "$gem_path/lib/asciidoctor/lab_ext.rb"

echo "require_relative 'asciidoctor/lab_ext'" >> "$gem_path/lib/asciidoctor.rb"