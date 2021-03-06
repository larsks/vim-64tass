" Vim syntax file
" Language:	64TASS 6502 assembler
" By: Lars Kellogg-Stedman <lars@oddbit.com>
" Last modified: that's why we have git
"
" Based on:
" asmM6502.vim
" By: Oyd E. Leven <oyd11@softhome.net>
" Creation date: 29-Jan-2005
" Version 0.01

" Remove any old syntax stuff hanging about
syn clear
syn case ignore
"
" registers
syn keyword asm65Reg x y a

" opcodes:

syn keyword asm65Op
  \ adc and asl bit brk clc cld cli clv cmp cpx cpy dec dex dey
  \ eor inc inx iny  lda ldx ldy lsr nop ora pha php pla plp
  \ rol ror rti rts sbc sec sed sei sta stx sty tax tay tsx txa txs tya

syn keyword asm65Branch
  \ bcc bcs beq bmi bne bpl bvc bvs jmp jsr
  \ geq gne gcc gcs gpl gmi gvc gvs glt gge

" 64tass keywords extracted from 64tass source:

syn keyword tassType
  \ address bits bool bytes code dict error float fold function
  \ gap ident anonident int label list tuple addresslist colonlist
  \ macro segment struct union memblocks function namespace none
  \ lbl default funcargs oper register str type

syn keyword tassFunction
  \ abs acos all any asin atan atan2 binary cbrt ceil cos cosh deg
  \ exp floor format frac hypot len log log10 pow rad random range
  \ repr round sign sin sinh size sort sqrt tan tanh trunc

syn keyword tassDirective
  \ addr al align as assert autsiz bend bfor binary binclude block
  \ break breakif brept bwhile byte case cdef cerror char check
  \ comment continue continueif cpu cwarn databank default dint
  \ dpage dsection dstruct dunion dword edef else elsif enc end
  \ endc endf endif endm endn endp ends endswitch endu endv endweak
  \ endwith eor error fi fill for function goto here hidemac if
  \ ifeq ifmi ifne ifpl include lbl lint logical long macro mansiz
  \ namespace next null offs option page pend proc proff pron ptext
  \ rept rta section seed segment send shift shiftl showmac sint
  \ struct switch text union var virtual warn weak while with word
  \ xl xs


syn match tassMacro	"\.macro"
syn match tassMacro	"\.endm"
syn match tassMacro	"#[a-z_][a-z0-9_]*"

" Atari 800XL 'Sally' undocumented opcodes
" mnemonics taken from Trevin Beattie's 'Atari Technical Information' page
" at "http://www.xmission.com/~trevin/atari/atari.shtml"
syn keyword asmSallyUndoc
  \ anc arr asr asx ax7 axe brk dcp jam las lax
  \ php rla rra sax slo sre sx7 sy7 xea xs7

syn match asmLabel		"^[a-z_][a-z0-9_]*"
syn match asmComment		";.*"hs=s+1 contains=asmTodo
syn keyword asmTodo	contained todo fixme xxx warning danger note notice bug
syn region asmString		start=+"+ skip=+\\"+ end=+"+
syn keyword asmSettings		opt org

syn match decNumber	"\<\d\+\>"
syn match hexNumber	"\$\x\+\>" " 'bug', but adding \< doesn't behave!
syn match binNumber	"%[01]\+\>" 
syn match asmImmediate	"#\$\x\+\>"
syn match asmImmediate	"#\d\+\>"
syn match asmImmediate	"<\$\x\+\>"
syn match asmImmediate	"<\d\+\>"
syn match asmImmediate	">\$\x\+\>"
syn match asmImmediate	">\d\+\>"
syn match asmImmediate	"#<\$\x\+\>"
syn match asmImmediate	"#<\d\+\>"
syn match asmImmediate	"#>\$\x\+\>"
syn match asmImmediate	"#>\d\+\>"

hi link tassFunction  Function
hi link tassType      Type
hi link tassDirective PreProc
hi link tassMacro     Macro

hi link asm65Branch    Conditional
hi link asm65Op        Statement
hi link asm65Reg       Identifier
hi link asmComment     Comment
hi link asmImmediate   Special
hi link asmLabel       Label
hi link asmSallyUndoc  Special
hi link asmSettings    Statement
hi link asmString      String
hi link asmTodo        Debug
hi link binNumber      Number
hi link decNumber      Number
hi link hexNumber      Number

hi Comment cterm=italic gui=italic

let b:current_syntax = "64tass"

