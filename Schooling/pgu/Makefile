infile ?= $(wildcard *.s)
objfile = $(infile:.s=.o)
binfile = $(objfile:.o=)

all: bin/3/exit bin/3/exit-2 bin/3/exit-3 bin/3/maximum                       \
	bin/3/maximum-2 bin/3/maximum-3 bin/3/maximum-4 bin/3/minimum         \
	bin/4/factorial bin/4/factorial-2 bin/4/factorial-3 bin/4/factorial-4 \
	bin/4/maximum-5 bin/4/maximum-6 bin/4/power bin/4/power-2             \
	bin/4/power-3 bin/4/power-4 bin/4/square-2 bin/4/square-3             \
	bin/5/heynow bin/5/toupper bin/5/toupper-2 bin/5/toupper-3            \
	bin/5/toupper-4 bin/5/toupper-5 bin/5/toupper-6 bin/6/add-year        \
	bin/6/add-year-2 bin/6/add-year-3 bin/6/add-year-4 bin/6/add-year-5   \
	bin/6/add-year-6 bin/6/largest-age bin/6/largest-age-2                \
	bin/6/read-records bin/6/read-records-2 bin/6/read-records-3          \
	bin/6/read-records-4 bin/6/record-input bin/6/record-loop             \
	bin/6/record-loop-2 bin/6/return-records bin/6/smallest-age           \
	bin/6/smallest-age-2 bin/6/write-records bin/6/write-records-2        \
	bin/6/write-records-3 bin/6/write-records-4 bin/7/add-year-7          \
	bin/7/add-year-8 bin/7/heynow-2 bin/8/factorial-5 bin/8/factorial-6   \
	bin/8/factorial-7 bin/8/factorial-8 bin/8/factorial-10                \
	bin/8/helloworld-lib bin/8/helloworld-nolib bin/8/largest-age-3       \
	bin/8/largest-age-4 bin/8/maximum-7 bin/8/maximum-8 bin/8/maximum-9   \
	bin/8/maximum-10 bin/8/maximum-11 bin/8/maximum-12 bin/8/minimum-2    \
	bin/8/power-5 bin/8/power-6 bin/8/power-7 bin/8/power-8               \
	bin/8/printf-example bin/8/smallest-age-3 bin/8/smallest-age-4        \
	bin/8/square-4 bin/8/square-5 bin/8/toupper-7 bin/8/write-records-5
.PHONY: all

bin/3/exit: src/3/exit.s
	as -o lib/3/exit.o src/3/exit.s
	ld -o bin/3/exit lib/3/exit.o
bin/3/exit-2: src/3/exit-2.s
	as -o lib/3/exit-2.o src/3/exit-2.s
	ld -o bin/3/exit-2 lib/3/exit-2.o
bin/3/exit-3: src/3/exit-3.s
	as -o lib/3/exit-3.o src/3/exit-3.s
	ld -o bin/3/exit-3 lib/3/exit-3.o
bin/3/maximum: src/3/maximum.s
	as -o lib/3/maximum.o src/3/maximum.s
	ld -o bin/3/maximum lib/3/maximum.o
bin/3/maximum-2: src/3/maximum-2.s
	as -o lib/3/maximum-2.o src/3/maximum-2.s
	ld -o bin/3/maximum-2 lib/3/maximum-2.o
bin/3/maximum-3: src/3/maximum-3.s
	as -o lib/3/maximum-3.o src/3/maximum-3.s
	ld -o bin/3/maximum-3 lib/3/maximum-3.o
bin/3/maximum-4: src/3/maximum-4.s
	as -o lib/3/maximum-4.o src/3/maximum-4.s
	ld -o bin/3/maximum-4 lib/3/maximum-4.o
bin/3/minimum: src/3/minimum.s
	as -o lib/3/minimum.o src/3/minimum.s
	ld -o bin/3/minimum lib/3/minimum.o
bin/4/factorial: src/4/factorial.s
	as -o lib/4/factorial.o src/4/factorial.s
	ld -o bin/4/factorial lib/4/factorial.o
bin/4/factorial-2: src/4/factorial-2.s
	as -o lib/4/factorial-2.o src/4/factorial-2.s
	ld -o bin/4/factorial-2 lib/4/factorial-2.o
bin/4/factorial-3: src/4/factorial-3.s
	as -o lib/4/factorial-3.o src/4/factorial-3.s
	ld -o bin/4/factorial-3 lib/4/factorial-3.o
bin/4/factorial-4: src/4/factorial-4.s
	as -o lib/4/factorial-4.o src/4/factorial-4.s
	ld -o bin/4/factorial-4 lib/4/factorial-4.o
bin/4/maximum-5: src/4/maximum-5.s
	as -o lib/4/maximum-5.o src/4/maximum-5.s
	ld -o bin/4/maximum-5 lib/4/maximum-5.o
bin/4/maximum-6: src/4/maximum-6.s
	as -o lib/4/maximum-6.o src/4/maximum-6.s
	ld -o bin/4/maximum-6 lib/4/maximum-6.o
bin/4/power: src/4/power.s
	as -o lib/4/power.o src/4/power.s
	ld -o bin/4/power lib/4/power.o
bin/4/power-2: src/4/power-2.s
	as -o lib/4/power-2.o src/4/power-2.s
	ld -o bin/4/power-2 lib/4/power-2.o
bin/4/power-3: src/4/power-3.s
	as -o lib/4/power-3.o src/4/power-3.s
	ld -o bin/4/power-3 lib/4/power-3.o
bin/4/power-4: src/4/power-4.s
	as -o lib/4/power-4.o src/4/power-4.s
	ld -o bin/4/power-4 lib/4/power-4.o
bin/4/square-2: src/4/square-2.s
	as -o lib/4/square-2.o src/4/square-2.s
	ld -o bin/4/square-2 lib/4/square-2.o
bin/4/square-3: src/4/square-3.s
	as -o lib/4/square-3.o src/4/square-3.s
	ld -o bin/4/square-3 lib/4/square-3.o
bin/5/heynow: src/5/heynow.s
	as -o lib/5/heynow.o src/5/heynow.s
	ld -o bin/5/heynow lib/5/heynow.o
bin/5/toupper: src/5/toupper.s
	as -o lib/5/toupper.o src/5/toupper.s
	ld -o bin/5/toupper lib/5/toupper.o
bin/5/toupper-2: src/5/toupper-2.s
	as -o lib/5/toupper-2.o src/5/toupper-2.s
	ld -o bin/5/toupper-2 lib/5/toupper-2.o
bin/5/toupper-3: src/5/toupper-3.s
	as -o lib/5/toupper-3.o src/5/toupper-3.s
	ld -o bin/5/toupper-3 lib/5/toupper-3.o
bin/5/toupper-4: src/5/toupper-4.s
	as -o lib/5/toupper-4.o src/5/toupper-4.s
	ld -o bin/5/toupper-4 lib/5/toupper-4.o
bin/5/toupper-5: src/5/toupper-5.s
	as -o lib/5/toupper-5.o src/5/toupper-5.s
	ld -o bin/5/toupper-5 lib/5/toupper-5.o
bin/5/toupper-6: src/5/toupper-6.s
	as -o lib/5/toupper-6.o src/5/toupper-6.s
	ld -o bin/5/toupper-6 lib/5/toupper-6.o
bin/6/add-year: src/6/add-year.s
	ln src/6/linux.s
	ln src/6/record-def.s
	as -o lib/6/add-year.o src/6/add-year.s
	ld -o bin/6/add-year lib/6/add-year.o
bin/6/add-year-2: src/6/add-year-2.s
	as -o lib/6/add-year-2.o src/6/add-year-2.s
	ld -o bin/6/add-year-2 lib/6/add-year-2.o
bin/6/add-year-3: src/6/add-year-3.s
	as -o lib/6/add-year-3.o src/6/add-year-3.s
	ld -o bin/6/add-year-3 lib/6/add-year-3.o
bin/6/add-year-4: src/6/add-year-4.s
	as -o lib/6/add-year-4.o src/6/add-year-4.s
	ld -o bin/6/add-year-4 lib/6/add-year-4.o
bin/6/add-year-5: src/6/add-year-5.s
	as -o lib/6/add-year-5.o src/6/add-year-5.s
	ld -o bin/6/add-year-5 lib/6/add-year-5.o
bin/6/add-year-6: src/6/add-year-6.s
	as -o lib/6/add-year-6.o src/6/add-year-6.s
	ld -o bin/6/add-year-6 lib/6/add-year-6.o
bin/6/largest-age: src/6/largest-age.s
	as -o lib/6/largest-age.o src/6/largest-age.s
	ld -o bin/6/largest-age lib/6/largest-age.o
bin/6/largest-age-2: src/6/largest-age-2.s
	as -o lib/6/largest-age-2.o src/6/largest-age-2.s
	ld -o bin/6/largest-age-2 lib/6/largest-age-2.o
bin/6/read-records: src/6/read-records.s
	as -o lib/6/read-records.o src/6/read-records.s
	ld -o bin/6/read-records lib/6/read-records.o
bin/6/read-records-2: src/6/read-records-2.s
	as -o lib/6/read-records-2.o src/6/read-records-2.s
	ld -o bin/6/read-records-2 lib/6/read-records-2.o
bin/6/read-records-3: src/6/read-records-3.s
	as -o lib/6/read-records-3.o src/6/read-records-3.s
	ld -o bin/6/read-records-3 lib/6/read-records-3.o
bin/6/read-records-4: src/6/read-records-4.s
	as -o lib/6/read-records-4.o src/6/read-records-4.s
	ld -o bin/6/read-records-4 lib/6/read-records-4.o
bin/6/record-input: src/6/record-input.s
	as -o lib/6/record-input.o src/6/record-input.s
	ld -o bin/6/record-input lib/6/record-input.o
bin/6/record-loop: src/6/record-loop.s
	as -o lib/6/record-loop.o src/6/record-loop.s
	ld -o bin/6/record-loop lib/6/record-loop.o
bin/6/record-loop-2: src/6/record-loop-2.s
	as -o lib/6/record-loop-2.o src/6/record-loop-2.s
	ld -o bin/6/record-loop-2 lib/6/record-loop-2.o
bin/6/return-records: src/6/return-records.s
	as -o lib/6/return-records.o src/6/return-records.s
	ld -o bin/6/return-records lib/6/return-records.o
bin/6/smallest-age: src/6/smallest-age.s
	as -o lib/6/smallest-age.o src/6/smallest-age.s
	ld -o bin/6/smallest-age lib/6/smallest-age.o
bin/6/smallest-age-2: src/6/smallest-age-2.s
	as -o lib/6/smallest-age-2.o src/6/smallest-age-2.s
	ld -o bin/6/smallest-age-2 lib/6/smallest-age-2.o
bin/6/write-records: src/6/write-records.s
	as -o lib/6/write-records.o src/6/write-records.s
	ld -o bin/6/write-records lib/6/write-records.o
bin/6/write-records-2: src/6/write-records-2.s
	as -o lib/6/write-records-2.o src/6/write-records-2.s
	ld -o bin/6/write-records-2 lib/6/write-records-2.o
bin/6/write-records-3: src/6/write-records-3.s
	as -o lib/6/write-records-3.o src/6/write-records-3.s
	ld -o bin/6/write-records-3 lib/6/write-records-3.o
bin/6/write-records-4: src/6/write-records-4.s
	as -o lib/6/write-records-4.o src/6/write-records-4.s
	ld -o bin/6/write-records-4 lib/6/write-records-4.o
bin/7/add-year-7: src/7/add-year-7.s
	as -o lib/7/add-year-7.o src/7/add-year-7.s
	ld -o bin/7/add-year-7 lib/7/add-year-7.o
bin/7/add-year-8: src/7/add-year-8.s
	as -o lib/7/add-year-8.o src/7/add-year-8.s
	ld -o bin/7/add-year-8 lib/7/add-year-8.o
bin/7/heynow-2: src/7/heynow-2.s
	as -o lib/7/heynow-2.o src/7/heynow-2.s
	ld -o bin/7/heynow-2 lib/7/heynow-2.o
bin/8/factorial-5: src/8/factorial-5.s
	as -o lib/8/factorial-5.o src/8/factorial-5.s
	ld -o bin/8/factorial-5 lib/8/factorial-5.o
bin/8/factorial-6: src/8/factorial-6.s
	as -o lib/8/factorial-6.o src/8/factorial-6.s
	ld -o bin/8/factorial-6 lib/8/factorial-6.o
bin/8/factorial-7: src/8/factorial-7.s
	as -o lib/8/factorial-7.o src/8/factorial-7.s
	ld -o bin/8/factorial-7 lib/8/factorial-7.o
bin/8/factorial-8: src/8/factorial-8.s
	as -o lib/8/factorial-8.o src/8/factorial-8.s
	ld -o bin/8/factorial-8 lib/8/factorial-8.o
bin/8/factorial-10: src/8/factorial-10.s
	as -o lib/8/factorial-10.o src/8/factorial-10.s
	ld -o bin/8/factorial-10 lib/8/factorial-10.o
bin/8/helloworld-lib: src/8/helloworld-lib.s
	as -o lib/8/helloworld-lib.o src/8/helloworld-lib.s
	ld -o bin/8/helloworld-lib lib/8/helloworld-lib.o
bin/8/helloworld-nolib: src/8/helloworld-nolib.s
	as -o lib/8/helloworld-nolib.o src/8/helloworld-nolib.s
	ld -o bin/8/helloworld-nolib lib/8/helloworld-nolib.o
bin/8/largest-age-3: src/8/largest-age-3.s
	as -o lib/8/largest-age-3.o src/8/largest-age-3.s
	ld -o bin/8/largest-age-3 lib/8/largest-age-3.o
bin/8/largest-age-4: src/8/largest-age-4.s
	as -o lib/8/largest-age-4.o src/8/largest-age-4.s
	ld -o bin/8/largest-age-4 lib/8/largest-age-4.o
bin/8/maximum-7: src/8/maximum-7.s
	as -o lib/8/maximum-7.o src/8/maximum-7.s
	ld -o bin/8/maximum-7 lib/8/maximum-7.o
bin/8/maximum-8: src/8/maximum-8.s
	as -o lib/8/maximum-8.o src/8/maximum-8.s
	ld -o bin/8/maximum-8 lib/8/maximum-8.o
bin/8/maximum-9: src/8/maximum-9.s
	as -o lib/8/maximum-9.o src/8/maximum-9.s
	ld -o bin/8/maximum-9 lib/8/maximum-9.o
bin/8/maximum-10: src/8/maximum-10.s
	as -o lib/8/maximum-10.o src/8/maximum-10.s
	ld -o bin/8/maximum-10 lib/8/maximum-10.o
bin/8/maximum-11: src/8/maximum-11.s
	as -o lib/8/maximum-11.o src/8/maximum-11.s
	ld -o bin/8/maximum-11 lib/8/maximum-11.o
bin/8/maximum-12: src/8/maximum-12.s
	as -o lib/8/maximum-12.o src/8/maximum-12.s
	ld -o bin/8/maximum-12 lib/8/maximum-12.o
bin/8/minimum-2: src/8/minimum-2.s
	as -o lib/8/minimum-2.o src/8/minimum-2.s
	ld -o bin/8/minimum-2 lib/8/minimum-2.o
bin/8/power-5: src/8/power-5.s
	as -o lib/8/power-5.o src/8/power-5.s
	ld -o bin/8/power-5 lib/8/power-5.o
bin/8/power-6: src/8/power-6.s
	as -o lib/8/power-6.o src/8/power-6.s
	ld -o bin/8/power-6 lib/8/power-6.o
bin/8/power-7: src/8/power-7.s
	as -o lib/8/power-7.o src/8/power-7.s
	ld -o bin/8/power-7 lib/8/power-7.o
bin/8/power-8: src/8/power-8.s
	as -o lib/8/power-8.o src/8/power-8.s
	ld -o bin/8/power-8 lib/8/power-8.o
bin/8/printf-example: src/8/printf-example.s
	as -o lib/8/printf-example.o src/8/printf-example.s
	ld -o bin/8/printf-example lib/8/printf-example.o
bin/8/smallest-age-3: src/8/smallest-age-3.s
	as -o lib/8/smallest-age-3.o src/8/smallest-age-3.s
	ld -o bin/8/smallest-age-3 lib/8/smallest-age-3.o
bin/8/smallest-age-4: src/8/smallest-age-4.s
	as -o lib/8/smallest-age-4.o src/8/smallest-age-4.s
	ld -o bin/8/smallest-age-4 lib/8/smallest-age-4.o
bin/8/square-4: src/8/square-4.s
	as -o lib/8/square-4.o src/8/square-4.s
	ld -o bin/8/square-4 lib/8/square-4.o
bin/8/square-5: src/8/square-5.s
	as -o lib/8/square-5.o src/8/square-5.s
	ld -o bin/8/square-5 lib/8/square-5.o
bin/8/toupper-7: src/8/toupper-7.s
	as -o lib/8/toupper-7.o src/8/toupper-7.s
	ld -o bin/8/toupper-7 lib/8/toupper-7.o
bin/8/write-records-5: src/8/write-records-5.s
	as -o lib/8/write-records-5.o src/8/write-records-5.s
	ld -o bin/8/write-records-5 lib/8/write-records-5.o

test:
	as $(infile) -o $(objfile)
	ld $(objfile) -o $(binfile)

obj: $(infile)
	as $(infile) -o $(objfile)
