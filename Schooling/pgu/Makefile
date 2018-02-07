infile ?= $(wildcard *.s)
objfile = $(infile:.s=.o)
binfile = $(objfile:.o=)

all: 3 4 5 6 7 8
.PHONY: all

3:
	$(MAKE) -C bin/3
4:
	$(MAKE) -C bin/4
5:
	$(MAKE) -C bin/5
6:
	$(MAKE) -C bin/6
7:
	$(MAKE) -C lib/7
	$(MAKE) -C bin/7
8:
	$(MAKE) -C lib/8
	$(MAKE) -C bin/8

test:
	as $(infile) -o $(objfile)
	ld $(objfile) -o $(binfile)

obj: $(infile)
	as $(infile) -o $(objfile)
