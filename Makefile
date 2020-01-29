TASS_SRC_DIR = $(HOME)/src/tass64-code

all: syntax/64tass.vim

syntax/64tass.vim: 64tass.vim.in extract-keywords.sh gen_vim_syntax.sh
	sh gen_vim_syntax.sh $(TASS_SRC_DIR) > $@ || rm -rf $@

clean:
	rm -f syntax/64tass.vim
