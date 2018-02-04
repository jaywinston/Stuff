infile ?= $(wildcard *.s)
objfile = $(infile:.s=.o)
binfile = $(objfile:.o=)

all:
	as $(infile) -o $(objfile)
	ld $(objfile) -o $(binfile)

obj: $(infile)
	as $(infile) -o $(objfile)

