all: add-year-7 add-year-8 heynow-2
.PHONY: all

add-year-7: ../../src/7/add-year-7.s
	as -o lib/7/add-year-7.o src/7/add-year-7.s
	ld -o add-year-7 lib/7/add-year-7.o
add-year-8: ../../src/7/add-year-8.s
	as -o lib/7/add-year-8.o src/7/add-year-8.s
	ld -o add-year-8 lib/7/add-year-8.o
heynow-2: ../../src/7/heynow-2.s
	as -o lib/7/heynow-2.o src/7/heynow-2.s
	ld -o heynow-2 lib/7/heynow-2.o

