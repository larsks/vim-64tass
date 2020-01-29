#!/bin/sh

# Run this inside the tass64 source directory.

tmpfile=$(mktemp syntaxXXXXXX)
trap "rm -f $tmpfile" EXIT

echo "Reading types..." >&2
awk '
	/new_type(.*);/ {
		kw = gensub(/.*new_type\(\S+, \S+, "([^"]+)", .*/, "\\1", 1);
		keywords[kwcount++] = kw
	}

	END {
		printf("syn keyword tass64Type\n");
		line = "  \\";
		for (i in keywords) {
			line = sprintf("%s %s", line, keywords[i]);
			if (length(line) >= 60) {
				print line;
				line = "  \\";
			}
		}
	}
' *.c

echo "Reading functions..." >&2
awk '
	/^static struct builtin_functions_s builtin_functions/ {state=1; next}

	state == 1 {
		kw = gensub(/.*"([^"]+)", .*/, "\\1", 1);
		keywords[kwcount++] = kw
	}

	/^};/ {state=0; next}

	END {
		printf("syn keyword tass64Function\n");
		line = "  \\";
		for (i in keywords) {
			line = sprintf("%s %s", line, keywords[i]);
			if (length(line) >= 60) {
				print line;
				line = "  \\";
			}
		}
	}
' *.c

echo "Reading directives..." >&2
awk '
	/^static const char \* const command/ {state=1; next}

	state == 1 {
		kw = gensub(/.*"[^"]+" "([^"]+)",.*/, "\\1", 1);
		keywords[kwcount++] = kw
	}

	/^};/ {state=0; next}

	END {
		printf("syn keyword tass64Directive\n");
		line = "  \\";
		for (i in keywords) {
			line = sprintf("%s .%s", line, keywords[i]);
			if (length(line) >= 60) {
				print line;
				line = "  \\";
			}
		}
	}
' *.c
