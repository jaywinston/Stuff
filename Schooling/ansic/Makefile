infile = $(wildcard *.c)
binfile = $(infile:.c=)

all: bin/1/check_syntax bin/1/count_chars-1 bin/1/count_chars-2               \
	bin/1/count_dwo bin/1/count_lines bin/1/count_stn bin/1/              \
	bin/1/count_words bin/1/detab bin/1/entab bin/1/escapes               \
	bin/1/fahrenheit bin/1/fahrenheit-2 bin/1/fahrenheit-3 bin/1/         \
	bin/1/fahrenheit-4 bin/1/fahrenheit-5 bin/1/fahrenheit-6              \
	bin/1/fahrenheit-7 bin/1/fold bin/1/hello bin/1/ bin/1/histogram-1    \
	bin/1/histogram-2 bin/1/io-1 bin/1/io-2 bin/1/io-3 bin/1/io-4         \
	bin/1/power bin/1/power-2 bin/1/ bin/1/print_80_chars bin/1/print_EOF \
	bin/1/print_longest_line bin/1/print_longest_line-2 bin/1/            \
	bin/1/print_longest_line-3 bin/1/print_word_per_line                  \
	bin/1/remove_comments bin/1/ bin/1/remove_trailing_btn                \
	bin/1/replace_tbs bin/1/reverse_input bin/2/ranges

.PHONY: all

bin/1/check_syntax: src/1/check_syntax.c
	gcc -o bin/1/check_syntax src/1/check_syntax.c
bin/1/count_chars-1: src/1/count_chars-1.c
	gcc -o bin/1/count_chars-1 src/1/count_chars-1.c
bin/1/count_chars-2: src/1/count_chars-2.c
	gcc -o bin/1/count_chars-2 src/1/count_chars-2.c
bin/1/count_dwo: src/1/count_dwo.c
	gcc -o bin/1/count_dwo src/1/count_dwo.c
bin/1/count_lines: src/1/count_lines.c
	gcc -o bin/1/count_lines src/1/count_lines.c
bin/1/count_stn: src/1/count_stn.c
	gcc -o bin/1/count_stn src/1/count_stn.c
bin/1/count_words: src/1/count_words.c
	gcc -o bin/1/count_words src/1/count_words.c
bin/1/detab: src/1/detab.c
	gcc -o bin/1/detab src/1/detab.c
bin/1/entab: src/1/entab.c
	gcc -o bin/1/entab src/1/entab.c
bin/1/escapes: src/1/escapes.c
	gcc -o bin/1/escapes src/1/escapes.c
bin/1/fahrenheit: src/1/fahrenheit.c
	gcc -o bin/1/fahrenheit src/1/fahrenheit.c
bin/1/fahrenheit-2: src/1/fahrenheit-2.c
	gcc -o bin/1/fahrenheit-2 src/1/fahrenheit-2.c
bin/1/fahrenheit-3: src/1/fahrenheit-3.c
	gcc -o bin/1/fahrenheit-3 src/1/fahrenheit-3.c
bin/1/fahrenheit-4: src/1/fahrenheit-4.c
	gcc -o bin/1/fahrenheit-4 src/1/fahrenheit-4.c
bin/1/fahrenheit-5: src/1/fahrenheit-5.c
	gcc -o bin/1/fahrenheit-5 src/1/fahrenheit-5.c
bin/1/fahrenheit-6: src/1/fahrenheit-6.c
	gcc -o bin/1/fahrenheit-6 src/1/fahrenheit-6.c
bin/1/fahrenheit-7: src/1/fahrenheit-7.c
	gcc -o bin/1/fahrenheit-7 src/1/fahrenheit-7.c
bin/1/fold: src/1/fold.c
	gcc -o bin/1/fold src/1/fold.c
bin/1/hello: src/1/hello.c
	gcc -o bin/1/hello src/1/hello.c
bin/1/histogram-1: src/1/histogram-1.c
	gcc -o bin/1/histogram-1 src/1/histogram-1.c
bin/1/histogram-2: src/1/histogram-2.c
	gcc -o bin/1/histogram-2 src/1/histogram-2.c
bin/1/io-1: src/1/io-1.c
	gcc -o bin/1/io-1 src/1/io-1.c
bin/1/io-2: src/1/io-2.c
	gcc -o bin/1/io-2 src/1/io-2.c
bin/1/io-3: src/1/io-3.c
	gcc -o bin/1/io-3 src/1/io-3.c
bin/1/io-4: src/1/io-4.c
	gcc -o bin/1/io-4 src/1/io-4.c
bin/1/power: src/1/power.c
	gcc -o bin/1/power src/1/power.c
bin/1/power-2: src/1/power-2.c
	gcc -o bin/1/power-2 src/1/power-2.c
bin/1/print_80_chars: src/1/print_80_chars.c
	gcc -o bin/1/print_80_chars src/1/print_80_chars.c
bin/1/print_EOF: src/1/print_EOF.c
	gcc -o bin/1/print_EOF src/1/print_EOF.c
bin/1/print_longest_line: src/1/print_longest_line.c
	gcc -o bin/1/print_longest_line src/1/print_longest_line.c
bin/1/print_longest_line-2: src/1/print_longest_line-2.c
	gcc -o bin/1/print_longest_line-2 src/1/print_longest_line-2.c
bin/1/print_longest_line-3: src/1/print_longest_line-3.c
	gcc -o bin/1/print_longest_line-3 src/1/print_longest_line-3.c
bin/1/print_word_per_line: src/1/print_word_per_line.c
	gcc -o bin/1/print_word_per_line src/1/print_word_per_line.c
bin/1/remove_comments: src/1/remove_comments.c
	gcc -o bin/1/remove_comments src/1/remove_comments.c
bin/1/remove_trailing_btn: src/1/remove_trailing_btn.c
	gcc -o bin/1/remove_trailing_btn src/1/remove_trailing_btn.c
bin/1/replace_tbs: src/1/replace_tbs.c
	gcc -o bin/1/replace_tbs src/1/replace_tbs.c
bin/1/reverse_input: src/1/reverse_input.c
	gcc -o bin/1/reverse_input src/1/reverse_input.c
bin/2/ranges: src/2/ranges.c
	gcc -o bin/2/ranges src/2/ranges.c

test:
	gcc $(infile) -o $(binfile)
