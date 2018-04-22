LIB8 = ../../lib/8
LIB6 = ../../lib/6

all: factorial-5 factorial-6 factorial-7 factorial-8 factorial-10      \
	helloworld-lib helloworld-nolib largest-age-3 largest-age-4    \
	maximum-7 maximum-8 maximum-9 maximum-10 maximum-11 maximum-12 \
	minimum-2 power-5 power-6 power-7 power-8 printf-example       \
	smallest-age-3 smallest-age-4 square-4 square-5 toupper-7      \
	write-records-5

factorial-5: $(LIB8)/factorial-5.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o factorial-5 \
		$(LIB8)/factorial-5.o
factorial-6: $(LIB8)/factorial-6.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o factorial-6 \
		$(LIB8)/factorial-6.o
factorial-7: $(LIB8)/factorial-7.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o factorial-7 \
		$(LIB8)/factorial-7.o
factorial-8: $(LIB8)/factorial-8.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o factorial-8 \
		$(LIB8)/factorial-8.o
factorial-10: $(LIB8)/factorial-10.o
	ld -dynamic-linker /lib/ld-linux.so.2 -L $(LIB8) -lc -lfactorial-9 \
		-o factorial-10 $(LIB8)/factorial-10.o
helloworld-lib: $(LIB8)/helloworld-lib.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o helloworld-lib \
		$(LIB8)/helloworld-lib.o
helloworld-nolib: $(LIB8)/helloworld-nolib.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o helloworld-nolib \
		$(LIB8)/helloworld-nolib.o
largest-age-3: $(LIB8)/largest-age-3.o
	ld -dynamic-linker /lib/ld-linux.so.2 -L $(LIB8) -lrecord -lc \
		-o largest-age-3 $(LIB8)/largest-age-3.o
largest-age-4: $(LIB8)/largest-age-4.o
	ld -dynamic-linker /lib/ld-linux.so.2 -L $(LIB8) -lrecord -lc \
		-o largest-age-4 $(LIB8)/largest-age-4.o
maximum-7: $(LIB8)/maximum-7.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o maximum-7 \
		$(LIB8)/maximum-7.o
maximum-8: $(LIB8)/maximum-8.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o maximum-8 \
		$(LIB8)/maximum-8.o
maximum-9: $(LIB8)/maximum-9.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o maximum-9 \
		$(LIB8)/maximum-9.o
maximum-10: $(LIB8)/maximum-10.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o maximum-10 \
		$(LIB8)/maximum-10.o
maximum-11: $(LIB8)/maximum-11.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o maximum-11 \
		$(LIB8)/maximum-11.o
maximum-12: $(LIB8)/maximum-12.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o maximum-12 \
		$(LIB8)/maximum-12.o
minimum-2: $(LIB8)/minimum-2.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o minimum-2 \
		$(LIB8)/minimum-2.o
power-5: $(LIB8)/power-5.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o power-5 $(LIB8)/power-5.o
power-6: $(LIB8)/power-6.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o power-6 $(LIB8)/power-6.o
power-7: $(LIB8)/power-7.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o power-7 $(LIB8)/power-7.o
power-8: $(LIB8)/power-8.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o power-8 $(LIB8)/power-8.o
printf-example: $(LIB8)/printf-example.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o printf-example \
		$(LIB8)/printf-example.o
smallest-age-3: $(LIB8)/smallest-age-3.o
	ld -dynamic-linker /lib/ld-linux.so.2 -L $(LIB8) -lrecord -lc \
		-o smallest-age-3 $(LIB8)/smallest-age-3.o
smallest-age-4: $(LIB8)/smallest-age-4.o
	ld -dynamic-linker /lib/ld-linux.so.2 -L $(LIB8) -lrecord -lc \
		-o smallest-age-4 $(LIB8)/smallest-age-4.o
square-4: $(LIB8)/square-4.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o square-4 $(LIB8)/square-4.o
square-5: $(LIB8)/square-5.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o square-5 $(LIB8)/square-5.o
toupper-7: $(LIB8)/toupper-7.o
	ld -dynamic-linker /lib/ld-linux.so.2 -lc -o toupper-7 \
		$(LIB6)/count-chars.o $(LIB6)/read-record.o $(LIB8)/toupper-7.o
write-records-5: $(LIB8)/write-records-5.o
	ld -dynamic-linker /lib/ld-linux.so.2 -L $(LIB8) -lrecord -lc \
		-o write-records-5 $(LIB8)/write-records-5.o
