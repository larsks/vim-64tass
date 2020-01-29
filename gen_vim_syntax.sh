#!/bin/sh
#
# usage: gen_vim_syntax.sh /path/to/tass64-code

if [ ! -d "$1" ]; then
	echo "ERROR: \"$1\" does not exist or is not a directory" >&2
	exit 1
fi

(cd "$1" && sh) < extract-keywords.sh > keywords.vim

sed '
	/@TASS_KEYWORDS@/ {
		r keywords.vim
		d
	}
' < 64tass.vim.in
