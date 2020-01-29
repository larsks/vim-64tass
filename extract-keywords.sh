#!/bin/sh

# Run this inside the tass source directory.

echo "Reading types..." >&2
awk '
	# Read types defined in new_type() statements.

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
	# Read list of functions from builtin_functions variable

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
	# Read list of directives from command variable

	/^static const char \* const command/ {state=1; next}
	/^};/ {state=0; next}

	state == 1 {
		kw = gensub(/.*"[^"]+" "([^"]+)",.*/, "\\1", 1);
		keywords[kwcount++] = kw
	}

	END {
		printf("syn keyword tassDirective\n");
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
' 64tass.c
