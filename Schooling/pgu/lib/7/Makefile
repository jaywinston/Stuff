all: links add-year-7.o add-year-8.o error-exit.o heynow-2.o rmlinks

links:
	@[ -f linux.s ] || ln -v ../../src/6/linux.s 
	@[ -f record-def.s ] || ln -v ../../src/6/record-def.s 
	@[ -f record-def-2.s ] || ln -v ../../src/6/record-def-2.s
rmlinks:
	@[ ! -f linux.s ] || rm -v linux.s
	@[ ! -f record-def.s ] || rm -v record-def.s
	@[ ! -f record-def-2.s ] || rm -v record-def-2.s

add-year-7.o: ../../src/7/add-year-7.s
	as -o add-year-7.o ../../src/7/add-year-7.s
add-year-8.o: ../../src/7/add-year-8.s
	as -o add-year-8.o ../../src/7/add-year-8.s
error-exit.o: ../../src/7/error-exit.s
	as -o error-exit.o ../../src/7/error-exit.s
heynow-2.o: ../../src/7/heynow-2.s
	as -o heynow-2.o ../../src/7/heynow-2.s

