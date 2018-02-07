all: includes compare-strings.o count-chars.o exit-on-err.o read-record.o    \
	read-record-2.o write-newline.o write-record.o write-record-2.o      \
	add-year.o add-year-2.o add-year-3.o add-year-4.o add-year-5.o       \
	add-year-6.o largest-age.o largest-age-2.o read-records.o            \
	read-records-2.o read-records-3.o read-records-4.o record-input.o    \
	record-loop.o record-loop-2.o return-records.o smallest-age.o        \
	smallest-age-2.o write-records.o write-records-2.o write-records-3.o \
	write-records-4.o                                                    \
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
add-year.o: ../../src/6/add-year.s
	as -o add-year.o ../../src/6/add-year.s
add-year-2.o: ../../src/6/add-year-2.s
	as -o add-year-2.o ../../src/6/add-year-2.s
add-year-3.o: ../../src/6/add-year-3.s
	as -o add-year-3.o ../../src/6/add-year-3.s
add-year-4.o: ../../src/6/add-year-4.s
	as -o add-year-4.o ../../src/6/add-year-4.s
add-year-5.o: ../../src/6/add-year-5.s
	as -o add-year-5.o ../../src/6/add-year-5.s
add-year-6.o: ../../src/6/add-year-6.s
	as -o add-year-6.o ../../src/6/add-year-6.s
largest-age.o: ../../src/6/largest-age.s
	as -o largest-age.o ../../src/6/largest-age.s
largest-age-2.o: ../../src/6/largest-age-2.s
	as -o largest-age-2.o ../../src/6/largest-age-2.s
read-records.o: ../../src/6/read-records.s
	as -o read-records.o ../../src/6/read-records.s
read-records-2.o: ../../src/6/read-records-2.s
	as -o read-records-2.o ../../src/6/read-records-2.s
read-records-3.o: ../../src/6/read-records-3.s
	as -o read-records-3.o ../../src/6/read-records-3.s
read-records-4.o: ../../src/6/read-records-4.s
	as -o read-records-4.o ../../src/6/read-records-4.s
record-input.o: ../../src/6/record-input.s
	as -o record-input.o ../../src/6/record-input.s
record-loop.o: ../../src/6/record-loop.s
	as -o record-loop.o ../../src/6/record-loop.s
record-loop-2.o: ../../src/6/record-loop-2.s
	as -o record-loop-2.o ../../src/6/record-loop-2.s
return-records.o: ../../src/6/return-records.s
	as -o return-records.o ../../src/6/return-records.s
smallest-age.o: ../../src/6/smallest-age.s
	as -o smallest-age.o ../../src/6/smallest-age.s
smallest-age-2.o: ../../src/6/smallest-age-2.s
	as -o smallest-age-2.o ../../src/6/smallest-age-2.s
write-records.o: ../../src/6/write-records.s
	as -o write-records.o ../../src/6/write-records.s
write-records-2.o: ../../src/6/write-records-2.s
	as -o write-records-2.o ../../src/6/write-records-2.s
write-records-3.o: ../../src/6/write-records-3.s
	as -o write-records-3.o ../../src/6/write-records-3.s
write-records-4.o: ../../src/6/write-records-4.s
	as -o write-records-4.o ../../src/6/write-records-4.s

