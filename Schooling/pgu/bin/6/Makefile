all: lib add-year add-year-2 add-year-3 add-year-4 add-year-5 add-year-6     \
	largest-age largest-age-2 read-records read-records-2 read-records-3 \
	read-records-4 record-input record-loop record-loop-2 return-records \
	smallest-age smallest-age-2 write-records write-records-2            \
	write-records-3 write-records-4 

.PHONY: all lib

lib:
	$(MAKE) -C ../../lib/6

add-year: ../../src/6/add-year.s
	ld -o add-year ../../lib/6/write-record.o ../../lib/6/read-record.o \
		../../lib/6/add-year.o
add-year-2: ../../src/6/add-year-2.s
	ld -o add-year-2 ../../lib/6/write-record.o ../../lib/6/read-record.o \
		../../lib/6/add-year-2.o
add-year-3: ../../src/6/add-year-3.s
	ld -o add-year-3 ../../lib/6/write-record.o ../../lib/6/read-record.o \
		../../lib/6/add-year-3.o
add-year-4: ../../src/6/add-year-4.s
	ld -o add-year-4 ../../lib/6/write-record.o ../../lib/6/read-record.o \
		../../lib/6/add-year-4.o
add-year-5: ../../src/6/add-year-5.s
	ld -o add-year-5 ../../lib/6/write-record.o ../../lib/6/read-record.o \
		../../lib/6/add-year-5.o
add-year-6: ../../src/6/add-year-6.s
	ld -o add-year-6 ../../lib/6/write-record.o ../../lib/6/read-record.o \
		../../lib/6/exit-on-err.o ../../lib/6/add-year-6.o
largest-age: ../../src/6/largest-age.s
	ld -o largest-age ../../lib/6/read-record.o ../../lib/6/largest-age.o
largest-age-2: ../../src/6/largest-age-2.s
	ld -o largest-age-2 ../../lib/6/read-record.o \
		../../lib/6/largest-age-2.o
read-records: ../../src/6/read-records.s
	ld -o read-records ../../lib/6/read-record.o \
		../../lib/6/count-chars.o ../../lib/6/write-newline.o \
		../../lib/6/read-records.o
read-records-2: ../../src/6/read-records-2.s
	ld -o read-records-2 ../../lib/6/read-record.o \
		../../lib/6/count-chars.o ../../lib/6/write-newline.o \
		../../lib/6/read-records-2.o
read-records-3: ../../src/6/read-records-3.s
	ld -o read-records-3 ../../lib/6/read-record.o \
		../../lib/6/count-chars.o ../../lib/6/write-newline.o \
		../../lib/6/read-records-3.o
read-records-4: ../../src/6/read-records-4.s
	ld -o read-records-4 ../../lib/6/read-record.o \
		../../lib/6/count-chars.o ../../lib/6/write-newline.o \
		../../lib/6/read-records-4.o
record-input: ../../src/6/record-input.s
	ld -o record-input ../../lib/6/exit-on-err.o ../../lib/6/record-input.o
record-loop: ../../src/6/record-loop.s
	ld -o record-loop ../../lib/6/record-loop.o
record-loop-2: ../../src/6/record-loop-2.s
	ld -o record-loop-2 ../../lib/6/record-loop-2.o
return-records: ../../src/6/return-records.s
	ld -o return-records ../../lib/6/read-record.o \
		../../lib/6/compare-strings.o ../../lib/6/exit-on-err.o \
		../../lib/6/return-records.o
smallest-age: ../../src/6/smallest-age.s
	ld -o smallest-age ../../lib/6/read-record.o ../../lib/6/smallest-age.o
smallest-age-2: ../../src/6/smallest-age-2.s
	ld -o smallest-age-2 ../../lib/6/read-record.o \
		../../lib/6/smallest-age-2.o
write-records: ../../src/6/write-records.s
	ld -o write-records ../../lib/6/write-record.o \
		../../lib/6/write-records.o
write-records-2: ../../src/6/write-records-2.s
	ld -o write-records-2 ../../lib/6/write-record.o \
		../../lib/6/write-records-2.o
write-records-3: ../../src/6/write-records-3.s
	ld -o write-records-3 ../../lib/6/write-record.o \
		 ../../lib/6/write-records-3.o
write-records-4: ../../src/6/write-records-4.s
	ld -o write-records-4 ../../lib/6/write-record.o \
		../../lib/6/write-records-4.o
