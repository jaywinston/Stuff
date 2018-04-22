SRC6 = ../../src/6
SRC8 = ../../src/8

all: links \
	factorial-5.o factorial-6.o factorial-7.o factorial-8.o               \
	factorial-10.o helloworld-lib.o helloworld-nolib.o largest-age-3.o    \
	largest-age-4.o maximum-7.o maximum-8.o maximum-9.o maximum-10.o      \
	maximum-11.o maximum-12.o minimum-2.o power-5.o power-6.o power-7.o   \
	power-8.o printf-example.o smallest-age-3.o smallest-age-4.o          \
	square-4.o square-5.o toupper-7.o write-records-5.o libfactorial-9.so \
	librecord.so                                                          \
	rmlinks

links:
	@[ -f linux.s ] || ln $(SRC6)/linux.s 
	@[ -f record-def.s ] || ln $(SRC6)/record-def.s 
rmlinks:
	@[ -f linux.s ] && rm linux.s
	@[ -f record-def.s ] && rm record-def.s

helloworld-nolib.o: $(SRC8)/helloworld-nolib.s
	as -o helloworld-nolib.o $(SRC8)/helloworld-nolib.s
helloworld-lib.o: $(SRC8)/helloworld-lib.s
	as -o helloworld-lib.o $(SRC8)/helloworld-lib.s
printf-example.o: $(SRC8)/printf-example.s
	as -o printf-example.o $(SRC8)/printf-example.s
librecord.so: ../../lib/6/write-record.o ../../lib/6/read-record.o
	ld -shared -o librecord.so \
		../../lib/6/write-record.o \
		../../lib/6/read-record.o
write-records-5.o: $(SRC8)/write-records-5.s
	as -o write-records-5.o $(SRC8)/write-records-5.s
factorial-5.o: $(SRC8)/factorial-5.s
	as -o factorial-5.o $(SRC8)/factorial-5.s
factorial-6.o: $(SRC8)/factorial-6.s
	as -o factorial-6.o $(SRC8)/factorial-6.s
factorial-7.o: $(SRC8)/factorial-7.s
	as -o factorial-7.o $(SRC8)/factorial-7.s
factorial-8.o: $(SRC8)/factorial-8.s
	as -o factorial-8.o $(SRC8)/factorial-8.s
factorial-10.o: $(SRC8)/factorial-10.s
	as -o factorial-10.o $(SRC8)/factorial-10.s
largest-age-3.o: $(SRC8)/largest-age-3.s
	as -o largest-age-3.o $(SRC8)/largest-age-3.s
largest-age-4.o: $(SRC8)/largest-age-4.s
	as -o largest-age-4.o $(SRC8)/largest-age-4.s
maximum-7.o: $(SRC8)/maximum-7.s
	as -o maximum-7.o $(SRC8)/maximum-7.s
maximum-8.o: $(SRC8)/maximum-8.s
	as -o maximum-8.o $(SRC8)/maximum-8.s
maximum-9.o: $(SRC8)/maximum-9.s
	as -o maximum-9.o $(SRC8)/maximum-9.s
maximum-10.o: $(SRC8)/maximum-10.s
	as -o maximum-10.o $(SRC8)/maximum-10.s
maximum-11.o: $(SRC8)/maximum-11.s
	as -o maximum-11.o $(SRC8)/maximum-11.s
maximum-12.o: $(SRC8)/maximum-12.s
	as -o maximum-12.o $(SRC8)/maximum-12.s
minimum-2.o: $(SRC8)/minimum-2.s
	as -o minimum-2.o $(SRC8)/minimum-2.s
power-5.o: $(SRC8)/power-5.s
	as -o power-5.o $(SRC8)/power-5.s
power-6.o: $(SRC8)/power-6.s
	as -o power-6.o $(SRC8)/power-6.s
power-7.o: $(SRC8)/power-7.s
	as -o power-7.o $(SRC8)/power-7.s
power-8.o: $(SRC8)/power-8.s
	as -o power-8.o $(SRC8)/power-8.s
smallest-age-3.o: $(SRC8)/smallest-age-3.s
	as -o smallest-age-3.o $(SRC8)/smallest-age-3.s
smallest-age-4.o: $(SRC8)/smallest-age-4.s
	as -o smallest-age-4.o $(SRC8)/smallest-age-4.s
square-4.o: $(SRC8)/square-4.s
	as -o square-4.o $(SRC8)/square-4.s
square-5.o: $(SRC8)/square-5.s
	as -o square-5.o $(SRC8)/square-5.s
factorial-9.o: $(SRC8)/factorial-9.s
	as -o factorial-9.o $(SRC8)/factorial-9.s
libfactorial-9.so: factorial-9.o 
	ld -shared -o libfactorial-9.so factorial-9.o
toupper-7.o: $(SRC8)/toupper-7.s
	as -o toupper-7.o $(SRC8)/toupper-7.s
