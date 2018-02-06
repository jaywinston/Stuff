all: includes compare-strings.o count-chars.o exit-on-err.o read-record.o \
	read-record-2.o write-newline.o write-record.o write-record-2.o \
	rmincludes
.PHONY: all includes rmincludes

includes:
	@[ -f linux.s ] || ln -v ../../src/6/linux.s 
	@[ -f record-def.s ] || ln -v ../../src/6/record-def.s 
	@[ -f record-def-2.s ] || ln -v ../../src/6/record-def-2.s
rmincludes:
	@[ ! -f linux.s ] || rm -v linux.s
	@[ ! -f record-def.s ] || rm -v record-def.s
	@[ ! -f record-def-2.s ] || rm -v record-def-2.s

compare-strings.o: ../../src/6/compare-strings.s
	as -o compare-strings.o ../../src/6/compare-strings.s
count-chars.o: ../../src/6/count-chars.s
	as -o count-chars.o ../../src/6/count-chars.s
exit-on-err.o: ../../src/6/exit-on-err.s
	as -o exit-on-err.o ../../src/6/exit-on-err.s
read-record.o: ../../src/6/read-record.s
	as -o read-record.o ../../src/6/read-record.s
read-record-2.o: ../../src/6/read-record-2.s
	as -o read-record-2.o ../../src/6/read-record-2.s
write-newline.o: ../../src/6/write-newline.s
	as -o write-newline.o ../../src/6/write-newline.s
write-record.o: ../../src/6/write-record.s
	as -o write-record.o ../../src/6/write-record.s
write-record-2.o: ../../src/6/write-record-2.s
	as -o write-record-2.o ../../src/6/write-record-2.s


