all: add-year-7 add-year-8 heynow-2
.PHONY: all

add-year-7: ../../lib/7/add-year-7.o
	ld -o add-year-7 \
		../../lib/6/count-chars.o ../../lib/6/write-newline.o \
		../../lib/6/read-record.o ../../lib/6/write-record.o \
		../../lib/7/error-exit.o \
		../../lib/7/add-year-7.o
add-year-8: ../../lib/7/add-year-8.o
	ld -o add-year-8 \
		../../lib/6/read-record.o ../../lib/6/write-record.o \
		../../lib/7/add-year-8.o
heynow-2: ../../lib/7/heynow-2.o
	ld -o heynow-2 ../../lib/6/exit-on-err.o ../../lib/7/heynow-2.o



