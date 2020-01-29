#!/bin/sh

# Run this inside the tass64 source directory.

tmpfile=$(mktemp syntaxXXXXXX)
trap "rm -f $tmpfile" EXIT

(cd "$1" && sh) < extract-keywords.sh > $tmpfile

cp $tmpfile foo.txt

sed '
	/@TASS64_KEYWORDS@/ {
		r '"$tmpfile"'
		d
	}
' < tass64.vim.in > tass64.vim
