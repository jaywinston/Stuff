import re
from os.path import basename
from sys import argv, exit

re_delim = re.compile('\W')
re_ident = re.compile('[$:.\w]+')
re_kw = re.compile('class|constructor|function|method|field|static|var|int'
                   '|char|boolean|void|true|false|null|this|let|do|if|else'
                   '|while|return')
re_sym = re.compile('[{}()[\].,;+\-*/&|<>=~]')
digit = '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'


def abort(*msgs):
    print(basename(argv[0]) +
          ': error in file {} line {} character {}'.format(_fname, nl, nc))
    for msg in msgs:
        print(basename(argv[0]) + ':', msg)
    exit(1)  # todo: control for exit status


_buff = None
def _ungetch(c):
    global _buff
    _buff = c


def _getch():
    global _buff, ci, nc, nl
    if _buff is not None:
        c = _buff
        _buff = None
    else:
        if ci < len(instream):
            c = instream[ci]
            ci += 1
            nc += 1
        else:
            c = None
    if c == '\n':
        nl += 1
        nc = 0
    return c


state = 0
def _decomment(c):

    global state

    if state == 0 and c == '/':
        state = 1

    if state == 1:
        temp = _getch()
        if temp == '/':
            while c is not None and c != '\n':
                c = _getch()
            state = 0
        elif temp == '*':
            c = _getch()
            state = 2
        else:
            _ungetch(temp)
            state = 0

    while state == 2:
        while c is not None and c != '*':
            if c == '\n':
                return c
            c = _getch()
        if c is None:
            abort('EOF in comment block')
        c = _getch()
        if c == '/':
            c = _getch()
            state = 0

    return c


def _isdelim(c):
    return bool(re_delim.fullmatch(c))


def _classify(word):

    if word == '\n':
        return 'NEWLINE'

    if re_kw.fullmatch(word):
        return word, 0

    if re_sym.fullmatch(word):
        return word, 1

    if word.isdigit():
        return word, 2

    if word.startswith('"') and word.endswith('"'):
        return word.strip('"'), 3

    if re_ident.fullmatch(word):
        if word.startswith(digit):
            abort('indentifier cannot start with a digit: ' + word)
        return word, 4

    if word.isspace():
        return False

    abort('unrecognized token: ' + word)


def _next_token():

    word = c = _decomment(_getch())

    if c is None:
        return None

    if c == '"':
        c = _getch()
        while c is not None and c != '"':
            word += c
            c = _getch()
        if c is None:
            abort('EOF in string literal')
        word += c
            
    if not _isdelim(c):
       c = _getch()
       while c is not None and not _isdelim(c):
           word += c
           c = _getch()
       _ungetch(c)

    return _classify(word)


def lex(fname):
    global ci, nc, nl
    global _fname, instream
    try:
        with open(fname, 'U') as fi:
            ci = nc = 0
            nl = 1
            _fname = fname
            instream = fi.read()
            tokens = []
            token = _next_token()
            while token is not None:
                while token is False:
                    token = _next_token()
                tokens.append(token)
                token = _next_token()
            tokens.append(token)
    except IOError:
        abort('io error in file ' + fname)

    return tokens

