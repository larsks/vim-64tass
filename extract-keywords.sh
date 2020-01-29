#!/bin/sh

# Run this inside the tass source directory.

tmpfile=$(mktemp syntaxXXXXXX)
trap "rm -f $tmpfile" EXIT

echo "Reading types..." >&2
awk '
	/new_type(.*);/ {
		kw = gensub(/.*new_type\(\S+, \S+, "([^"]+)", .*/, "\\1", 1);
		keywords[kwcount++] = kw
	}

	END {
		printf("syn keyword tassType\n");
		for (i in keywords) {
			line = sprintf("%s %s", line, keywords[i]);
			if (length(line) >= 60) {
				printf("  \\%s\n", line)
				line = "";
			}
		}
		if (line) printf("  \\%s\n", line);
		printf("\n");
	}
' *.c

echo "Reading functions..." >&2
awk '
	/^static struct builtin_functions_s builtin_functions/ {state=1; next}
	/NULL, F_NONE/ {state=0; next}

	state == 1 {
		kw = gensub(/.*"([^"]+)", .*/, "\\1", 1);
		keywords[kwcount++] = kw
	}

	END {
		printf("syn keyword tassFunction\n");
		for (i in keywords) {
			line = sprintf("%s %s", line, keywords[i]);
			if (length(line) >= 60) {
				printf("  \\%s\n", line);
				line = "";
			}
		}
		if (line) printf("  \\%s\n", line);
		printf("\n");
	}
' functionobj.c

echo "Reading directives..." >&2
awk '
	/^static const char \* const command/ {state=1; next}
	/^};/ {state=0; next}

	state == 1 {
		kw = gensub(/.*"[^"]+" "([^"]+)",.*/, "\\1", 1);
		keywords[kwcount++] = kw
	}

	END {
		printf("syn keyword tassDirective\n");
		for (i in keywords) {
			line = sprintf("%s .%s", line, keywords[i]);
			if (length(line) >= 60) {
				printf("  \\%s\n", line);
				line = "";
			}
		}
		if (line) printf("  \\%s\n", line);
		printf("\n");
	}
' 64tass.c
