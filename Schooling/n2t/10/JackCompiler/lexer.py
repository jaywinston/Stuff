import re

symbols = r'{}()[\].,;+\-*/&|<>=~'
re_delim = re.compile('([{symbols}\s])'.format(symbols=symbols))
re_kw = re.compile('(class|constructor|function|method|field|static|var|int'
                   '|char|boolean|void|true|false|null|this|let|do|if|else|'
                   'while|return)')
re_sym = re.compile('([{symbols}])'.format(symbols=symbols))
re_ident = re.compile('[$:.\w]+')
digit = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')
nl = 1


_buff = None
def _getch():
    global _buff
    if _buff is not None:
        c = _buff
        _buff = None
    else:
        if len(instream) > 0:
            c = instream.pop()
        else:
            c = None
    return c


def _ungetch(c):
    global _buff
    _buff = c


def _decomment(c):

    global nl

    state = 0

    if c == '/':
        state = 1

    if state == 1:
        temp = _getch()
        if temp == '/':
            while c != '\n':
                c = _getch()
        elif temp == '*':
            state = 2
            c = _getch()
            while state == 2:
                while c != '*':
                    c = _getch()
                    if c == '\n':
                        nl += 1
                c = _getch()
                if c == '/':
                    state = 0
                    c = _getch()
        else:
            _ungetch(temp)

    return c


def _isdelim(c):
    return bool(re_delim.fullmatch(c))


def _classify(word):

#    if word == '\n':
#        return 'NEWLINE'

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
            msg = 'on line {}\nindentifier cannot'
            msg += 'start with a digit: {}'
            raise Exception(msg.format(nl, word))
        return word, 4

    if word.isspace():
        return False

    raise Exception('unrecognized token: ' + word)



def _next_token():

    global nl

    word = c = _decomment(_getch())

    if c is None:
        return None

    if c == '\n':
        nl += 1

    if c == '"':
        c = _getch()
        word += c
        while c != '"':
            c = _getch()
            word += c
        word += c
            
    if not _isdelim(c):
       while not _isdelim(c):
           c = _getch()
           if not _isdelim(c):
               word += c
       _ungetch(c)

    return _classify(word)


def init_lex(s):
    global instream
    instream = list(reversed(s))


def next_token():
    token = _next_token()
    while token is False:
        token = _next_token()
    return token

