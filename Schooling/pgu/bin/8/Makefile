LIBDIR = ../../lib/8
LIB6 = ../../lib/6

all: factorial-5 factorial-6 factorial-7 factorial-8 factorial-10      \
	helloworld-lib helloworld-nolib largest-age-3 largest-age-4    \
	maximum-7 maximum-8 maximum-9 maximum-10 maximum-11 maximum-12 \
	minimum-2 power-5 power-6 power-7 power-8 printf-example       \
	smallest-age-3 smallest-age-4 square-4 square-5 toupper-7      \
	write-records-5

factorial-5: $(LIBDIR)/factorial-5.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o factorial-5 \
		$(LIBDIR)/factorial-5.o
factorial-6: $(LIBDIR)/factorial-6.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o factorial-6 \
		$(LIBDIR)/factorial-6.o
factorial-7: $(LIBDIR)/factorial-7.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o factorial-7 \
		$(LIBDIR)/factorial-7.o
factorial-8: $(LIBDIR)/factorial-8.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o factorial-8 \
		$(LIBDIR)/factorial-8.o
factorial-10: $(LIBDIR)/factorial-10.o
	ld -dynamic-linker /lib/ld-linux.so -L $(LIBDIR) -lc -lfactorial-9 \
		-o factorial-10 $(LIBDIR)/factorial-10.o
helloworld-lib: $(LIBDIR)/helloworld-lib.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o helloworld-lib $(LIBDIR)/helloworld-lib.o
helloworld-nolib: $(LIBDIR)/helloworld-nolib.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o helloworld-nolib $(LIBDIR)/helloworld-nolib.o
largest-age-3: $(LIBDIR)/largest-age-3.o
	ld -dynamic-linker /lib/ld-linux.so -L $(LIBDIR) -lrecord -lc -o largest-age-3 $(LIBDIR)/largest-age-3.o
largest-age-4: $(LIBDIR)/largest-age-4.o
	ld -dynamic-linker /lib/ld-linux.so -L $(LIBDIR) -lrecord -lc -o largest-age-4 $(LIBDIR)/largest-age-4.o
maximum-7: $(LIBDIR)/maximum-7.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o maximum-7 $(LIBDIR)/maximum-7.o
maximum-8: $(LIBDIR)/maximum-8.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o maximum-8 $(LIBDIR)/maximum-8.o
maximum-9: $(LIBDIR)/maximum-9.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o maximum-9 $(LIBDIR)/maximum-9.o
maximum-10: $(LIBDIR)/maximum-10.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o maximum-10 $(LIBDIR)/maximum-10.o
maximum-11: $(LIBDIR)/maximum-11.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o maximum-11 $(LIBDIR)/maximum-11.o
maximum-12: $(LIBDIR)/maximum-12.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o maximum-12 $(LIBDIR)/maximum-12.o
minimum-2: $(LIBDIR)/minimum-2.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o minimum-2 $(LIBDIR)/minimum-2.o
power-5: $(LIBDIR)/power-5.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o power-5 $(LIBDIR)/power-5.o
power-6: $(LIBDIR)/power-6.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o power-6 $(LIBDIR)/power-6.o
power-7: $(LIBDIR)/power-7.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o power-7 $(LIBDIR)/power-7.o
power-8: $(LIBDIR)/power-8.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o power-8 $(LIBDIR)/power-8.o
printf-example: $(LIBDIR)/printf-example.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o printf-example $(LIBDIR)/printf-example.o
smallest-age-3: $(LIBDIR)/smallest-age-3.o
	ld -dynamic-linker /lib/ld-linux.so -L $(LIBDIR) -lrecord -lc -o smallest-age-3 $(LIBDIR)/smallest-age-3.o
smallest-age-4: $(LIBDIR)/smallest-age-4.o
	ld -dynamic-linker /lib/ld-linux.so -L $(LIBDIR) -lrecord -lc -o smallest-age-4 $(LIBDIR)/smallest-age-4.o
square-4: $(LIBDIR)/square-4.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o square-4 $(LIBDIR)/square-4.o
square-5: $(LIBDIR)/square-5.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o square-5 $(LIBDIR)/square-5.o
toupper-7: $(LIBDIR)/toupper-7.o
	ld -dynamic-linker /lib/ld-linux.so -lc -o toupper-7 $(LIB6)/count-chars.o $(LIB6)/read-record.o $(LIBDIR)/toupper-7.o
write-records-5: $(LIBDIR)/write-records-5.o
	ld -dynamic-linker /lib/ld-linux.so -L $(LIBDIR) -lrecord -lc -o write-records-5 $(LIBDIR)/write-records-5.o
