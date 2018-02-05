infile ?= $(wildcard *.s)
objfile = $(infile:.s=.o)
binfile = $(objfile:.o=)

all: \
bin/3/exit \
bin/3/exit-2 \
bin/3/exit-3 \
bin/3/maximum \
bin/3/maximum-2 \
bin/3/maximum-3 \
bin/3/maximum-4 \
bin/3/minimum \
bin/4/factorial \
bin/4/factorial-2 \
bin/4/factorial-3 \
bin/4/factorial-4 \
bin/4/maximum-5 \
bin/4/maximum-6 \
bin/4/power \
bin/4/power-2 \
bin/4/power-3 \
bin/4/power-4 \
bin/4/square \
bin/4/square-2 \
bin/4/square-3 \
bin/5/heynow \
bin/5/toupper \
bin/5/toupper-2 \
bin/5/toupper-3 \
bin/5/toupper-4 \
bin/5/toupper-5 \
bin/5/toupper-6 \
bin/6/add-year \
bin/6/add-year-2 \
bin/6/add-year-3 \
bin/6/add-year-4 \
bin/6/add-year-5 \
bin/6/add-year-6 \
bin/6/compare-strings \
bin/6/count-chars \
bin/6/exit-on-err \
bin/6/largest-age \
bin/6/largest-age-2 \
bin/6/linux \
bin/6/read-record \
bin/6/read-records \
bin/6/read-records-2 \
bin/6/read-records-3 \
bin/6/read-records-4 \
bin/6/read-record-2 \
bin/6/record-def \
bin/6/record-def-2 \
bin/6/record-input \
bin/6/record-loop \
bin/6/record-loop-2 \
bin/6/return-records \
bin/6/smallest-age \
bin/6/smallest-age-2 \
bin/6/write-newline \
bin/6/write-record \
bin/6/write-records \
bin/6/write-records-2 \
bin/6/write-records-3 \
bin/6/write-records-4 \
bin/6/write-record-2 \
bin/7/add-year-7 \
bin/7/add-year-8 \
bin/7/error-exit \
bin/7/heynow-2 \
bin/8/factorial-5 \
bin/8/factorial-6 \
bin/8/factorial-7 \
bin/8/factorial-8 \
bin/8/factorial-9 \
bin/8/factorial-10 \
bin/8/helloworld-lib \
bin/8/helloworld-nolib \
bin/8/largest-age-3 \
bin/8/largest-age-4 \
bin/8/maximum-7 \
bin/8/maximum-8 \
bin/8/maximum-9 \
bin/8/maximum-10 \
bin/8/maximum-11 \
bin/8/maximum-12 \
bin/8/minimum-2 \
bin/8/power-5 \
bin/8/power-6 \
bin/8/power-7 \
bin/8/power-8 \
bin/8/printf-example \
bin/8/smallest-age-3 \
bin/8/smallest-age-4 \
bin/8/square-4 \
bin/8/square-5 \
bin/8/toupper-7 \
bin/8/write-records-5

.PHONY: all

test:
	as $(infile) -o $(objfile)
	ld $(objfile) -o $(binfile)

obj: $(infile)
	as $(infile) -o $(objfile)

