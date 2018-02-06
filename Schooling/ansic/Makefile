infile = $(wildcard *.c)
binfile.c.c = $(infile:.c=)

all: 1 2

.PHONY: all

1:
	$(MAKE) -C bin/1
2:
	$(MAKE) -C bin/2

test:
	gcc $(infile) -o $(binfile)
