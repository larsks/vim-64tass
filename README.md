This is a vim syntax file for 6502 assembly language as implemented by the
[64tass][] assembler.

64tass-specific keywords are extracted programtically from the 64tass sources in order to generate the syntax file.

[64tass]: http://tass64.sourceforge.net/

## Known issues

It's hard to differentiate between a macro call (`#macroname`) and an immediate operand using a named constant (`#someconstant`).
