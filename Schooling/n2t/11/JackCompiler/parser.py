from sys import argv, exit
from os.path import basename
from symtab import Symtab

uoptab = {'-': 'neg', '~': '  not'}

optab = {
    '+'  : 'add',
    '-'  : 'sub',
    '*'  : 'call' '\t' 'Math.multiply 2',
    '/'  : 'call' '\t' 'Math.divide 2',
    '&'  : 'and',
    '|'  : 'or',
    '<'  : 'lt',
    '>'  : 'gt',
    '='  : 'eq',
    '>=' : 'ge',
    '<=' : 'le'
}

kw_consttab = {
    'true'  : 'push' '\t' 'constant 0' '\n' 'not',
    'false' : 'push' '\t' 'constant 0',
    'null'  : 'push' '\t' 'constant 0',
    'this'  : 'push' '\t' 'pointer 0'
}


def abort(*msgs):
    PROG = basename(argv[0])
    if token is not False:
        fname = _fname[:-3] + '.jack'
        print(PROG + ': error in file {} on line {}'.format(fname, nl))
    for msg in msgs:
        print(PROG + ':', msg)
    if token is not False and token is not None:
        print(PROG + ':', 'unexpected token:', token[0])
    exit(1)


def next_token():
    return _tokens.pop()


tknbuf = []
def buffer(tkn):
    tknbuf.append(tkn)


def advance(buffered=False):

    def _advance(src_f, *a):
        global nl, token
        token = src_f(*a)
        while token == 'NEWLINE':
            nl += 1
            token = src_f(*a)

    if buffered:
        _advance(tknbuf.pop, 0)
    else:
        _advance(next_token)


tagtab = {'if': 0, 'while': 0}
def next_tag():
    tagtab[token[0]] += 1
    return str(tagtab[token[0]])


def lookup(name):
    return lcl_symtab.get(name) or globl_symtab.get(name)


def fwrite(*args):
    s = ''
    for arg in args:
        s += arg
    _fo.write(s)


def compile_expression_list(buffered=False):

    narg = 0

    while token is not None and token[0] != ')':
        narg += 1
        compile_expression(buffered)
        if token[0] != ',' and token[0] != ')':
            abort('in expression list')
        if token[0] == ',':
            advance(buffered)

    if token is None:
        abort('unexpected EOF in expression list')

    return narg


def compile_subroutine_call(ident, buffered=False):

    if token[0] == '(':
        routine = _class + '.' + ident
        advance(buffered)
        fwrite('push' '\t' 'pointer 0' '\n')
        narg = 1 + compile_expression_list(buffered)
        advance(buffered)  # ')'
        fwrite('call' '\t', routine, ' ', str(narg), '\n')

    elif token[0] == '.':
        obj = lookup(ident)
        if obj is not None:
            fwrite('push' '\t', obj['segment'], ' ', obj['index'], '\n')
            routine = obj['type']
            narg = 1
        else:
            routine = ident
            narg = 0
        routine += '.'
        advance(buffered)
        if token[1] != 4:  # subroutineName
            abort('expected identifier')
        routine += token[0]
        advance(buffered)
        if token[0] != '(':
            abort("expected '('")
        advance(buffered)
        narg += compile_expression_list(buffered)
        advance(buffered)  # ')'
        fwrite('call' '\t', routine, ' ', str(narg), '\n')

    else:
        abort('in subroutine call')


def compile_term(buffered=False):

    ident = None

    # keywordConstant
    if token[1] == 0:
        kwconst = kw_consttab.get(token[0])
        if kwconst is None:
            abort('unexpected keyword')
        fwrite(kwconst, '\n')
        advance(buffered)

    # symbol
    elif token[1] == 1:
        # unaryOp term
        if token[0] == '-' or token[0] == '~':
            uop = uoptab[token[0]]
            advance(buffered)
            compile_term(buffered)
            fwrite(uop, '\n')

        # '(' expression ')'
        elif token[0] == '(':
            advance(buffered)
            compile_expression(buffered)
            advance(buffered)  # ')'

        elif token[0] != ';':
            abort('unexpected symbol')

    # integerConstant
    elif token[1] == 2:
        fwrite('push' '\t' 'constant ', token[0], '\n')
        advance(buffered)

    # stringConstant
    elif token[1] == 3:
        fwrite('push' '\t' 'constant ', str(len(token[0])), '\n'
               'call' '\t' 'String.new 1' '\n')
        for c in token[0]:
            fwrite('push' '\t' 'constant ', str(ord(c)), '\n'
                   'call' '\t' 'String.appendChar 2' '\n')
        advance(buffered)

    # varName className subroutineName
    elif token[1] == 4:
        ident = token[0]
        advance(buffered)

    ### postfix compound term ###

    if ident is not None:

        if token[0] == '[':
            obj = lookup(ident)
            if obj is None:
                abort('undeclared identifier')
            fwrite('push' '\t', obj['segment'], ' ', obj['index'], '\n')
            advance(buffered)
            compile_expression(buffered)
            if token[0] != ']':
                abort("expected ']'")
            advance(buffered)
            fwrite('add' '\n'
                   'pop' '\t' 'pointer 1' '\n'
                   'push' '\t' 'that 0' '\n')

        elif token[0] == '(' or token[0] == '.':
            compile_subroutine_call(ident, buffered)

        else:
            obj = lookup(ident)
            if obj is None:
                abort('undeclared identifier')
            fwrite('push' '\t', obj['segment'], ' ', obj['index'], '\n')


def compile_expression(buffered=False):

    compile_term(buffered)

    if token[0] in '+-*/&|<>=':
        op = token[0]
        advance(buffered)
        if token[0] == '=':
            op += '='
            advance(buffered)
        compile_term(buffered)
        fwrite(optab[op], '\n')


def compile_return_statement():

    # 'return'
    advance()

    if token[0] == ';':
        fwrite('push' '\t' 'constant 0' '\n')
    else:
        compile_expression()

    if token[0] != ';':
        abort("expected ';'")
    advance()

    fwrite('return' '\n')


def compile_do_statement():

    # 'do'
    advance()

    # subroutineName or className|varName
    if token[1] != 4:
        abort('expected identifier')
    ident = token[0]
    advance()

    compile_subroutine_call(ident)

    if token[0] != ';':
        abort("expected ';'")
    advance()

    fwrite('pop' '\t' 'pointer 1' '\n')  # ignore return value
                                         # that is only used in an expression.

def compile_while_statement():

    tag = next_tag()

    # 'while'
    advance()

    fwrite('label WHILE', tag, '\n')

    if token[0] != '(':
        abort('expected expression')
    advance()

    compile_expression()

    fwrite('if-goto' '\t' 'WHILE', tag, 'DO' '\n'
           'goto' '\t' 'WHILE', tag, 'END' '\n'
           'label WHILE', tag, 'DO' '\n')

    if token[0] != ')':
        abort("expected ')'")
    advance()

    if token[0] != '{':
        abort("expected '{'")
    advance()

    compile_statements()

    if token[0] != '}':
        abort("expected '}'")
    advance()

    fwrite('goto' '\t' 'WHILE', tag, '\n'
           'label WHILE', tag, 'END' '\n')


def compile_if_statement():

    tag = next_tag()

    # 'if'
    advance()

    if token[0] != '(':
        abort('expected expression')
    advance()

    compile_expression()

    if token[0] != ')':
        abort("expected ')'")
    advance()

    fwrite('if-goto' '\t' 'IF', tag, 'YES' '\n'
           'goto' '\t' 'IF', tag, 'NOT' '\n'
           'label IF', tag, 'YES' '\n')

    if token[0] != '{':
        abort("expected '{'")
    advance()

    compile_statements()

    if token[0] != '}':
        abort("expected '}'")
    advance()

    if token[0] == 'else':
        fwrite('goto' '\t' 'IF', tag, 'END' '\n'
               'label IF', tag, 'NOT' '\n')

        advance()

        if token[0] != '{':
            abort("expected '{'")
        advance()

        compile_statements()

        if token[0] != '}':
            abort("expected '}'")
        advance()

        fwrite('label IF', tag, 'END' '\n')
    else:
        fwrite('label IF', tag, 'NOT' '\n')


def compile_let_statement():

    # 'let'
    advance()

    array = False

    if token[1] != 4:
        abort('expected identifier')
    ident = token[0]
    advance()

    if token[0] == '[':
        # buffer tokens of array index expression
        array = True
        brackets = 1
        advance()  # don't buffer first '[' (but do buffer last ']')
        while token is not None and brackets > 0:
            buffer(token)
            if token[0] == '[':
                brackets += 1
            elif token[0] == ']':
                brackets -= 1
            advance()

        if token is None:
            abort('EOF in expression')

    if token[0] != '=':
        abort("expected '='")
    advance()

    compile_expression()

    if array:
        buffer(token)  # ';'

    obj = lookup(ident)
    if obj is None:
        abort('undeclared identifier')

    if array:
        advance(buffered=True)  # ';'
        fwrite('push' '\t', obj['segment'], ' ', obj['index'], '\n')
        compile_expression(buffered=True)
        advance(buffered=True)  # ']'
        fwrite('add' '\n'
               'pop' '\t' 'pointer 1' '\n')
        dest = 'that 0'
    else:
        dest = obj['segment'] + ' ' + obj['index']

    fwrite('pop' '\t', dest, '\n')

    if token[0] != ';':
        abort("expected ';'")
    advance()


stat_ftab = {
    'let'    : compile_let_statement,
    'if'     : compile_if_statement,
    'while'  : compile_while_statement,
    'do'     : compile_do_statement,
    'return' : compile_return_statement
}
def compile_statements():
    while token is not None and token[0] != '}':
        compile_statement = stat_ftab.get(token[0])
        if compile_statement is None:
            abort('expected statement')
        compile_statement()

    if token is None:
        abort('EOF in statements')


def compile_var_dec():

    # 'var'
    advance()

    nvar = 0

    # type
    if token[0] != 'int'              \
            and token[0] != 'char'    \
            and token[0] != 'boolean' \
            and token[1] != 4:
        abort('expected type')
    type = token[0]
    advance()

    # varName
    if token[1] != 4:
        abort('expected identifier')
    lcl_symtab.install(token[0], 'local', type)
    nvar += 1
    advance()
 
    if token[0] == ',':
        advance()
        while token is not None and token[0] != ';':
            if token[1] != 4:  # varName
                abort('expected identifier')
            lcl_symtab.install(token[0], 'local', type)
            nvar += 1
            advance()
            if token[0] == ',':
                advance()

        if token is None:
            abort('EOF in variable declaration')

    if token[0] != ';':
        abort("expected ';'")
    advance()

    return nvar


def compile_subroutine_body(srtype, nfield):

    nvar = 0

    while token is not None and token[0] == 'var':
        nvar += compile_var_dec()

    if token is None:
        abort('EOF in variable declarations')

    fwrite(str(nvar), '\n')  # nlocals

    if srtype == 'constructor':
        fwrite('push' '\t' 'constant ', nfield, '\n'
               'call' '\t' 'Memory.alloc 1' '\n'
               'pop' '\t' 'pointer 0' '\n')

    if srtype == 'method':
        fwrite('push' '\t' 'argument 0' '\n',
               'pop' '\t' 'pointer 0' '\n')

    compile_statements()


def compile_parameter_list(srtype):

    if srtype == 'method':
        lcl_symtab.install('this', 'argument', _class)

    while token is not None and token[0] != ')':
 
        # type
        if token[0] != 'int'              \
                and token[0] != 'char'    \
                and token[0] != 'boolean' \
                and token[1] != 4:
            abort('expected type')
        type = token[0]
        advance()
    
        # varName
        if token[1] != 4:
            abort('expected identifier')
        lcl_symtab.install(token[0], 'argument', type)
        advance()
 
        if token[0] == ',':
            advance()

    if token is None:
        abort('EOF in parameters declaration')
 
    if token[0] != ')':
        abort('in parameters declaration')
 

def compile_subroutine_dec(nfield):

    global lcl_symtab
    lcl_symtab = Symtab('local', 'argument')

    # 'constructor' 'function' 'method'
    srtype = token[0]
    advance()

    # type
    if token[0] != 'int'              \
            and token[0] != 'char'    \
            and token[0] != 'boolean' \
            and token[0] != 'void'    \
            and token[1] != 4:
        abort('expected type')
    advance()

    # subroutineName
    if token[1] != 4:
        abort('expected identifier')
    fwrite('function ', _class, '.', token[0], ' ')  # nlocals comes later
    advance()

    if token[0] != '(':
        abort('expected parameter list')
    advance()

    compile_parameter_list(srtype)

    advance()  # ')'

    # subroutineBody
    if token[0] != '{':
        abort("expected '{'")
    advance()

    # compile_subroutine_body will decide if it's an acceptable kw.
    if token[0] != '}' and token[1] != 0:
        abort('expected subroutine body')
    compile_subroutine_body(srtype, nfield)
    
    advance()  # '}'


def compile_class_var_dec():

    # 'static' 'field'
    segment = 'static' if token[0] == 'static' else 'this'
    advance()

    # type
    if token[0] != 'int'              \
            and token[0] != 'char'    \
            and token[0] != 'boolean' \
            and token[1] != 4:
        abort('expected type')
    type = token[0]
    advance()

    if token[1] != 4:
        abort('expected identifier')
    globl_symtab.install(token[0], segment, type)
    advance()

    nfield = 1

    while token is not None and token[0] != ';':
        if token[0] != ',':
            abort('in class variable declaration')
        advance()
        if token[1] != 4:
            abort('expected identifier')
        globl_symtab.install(token[0], segment, type)
        advance()
        nfield += 1

    if token is None:
        abort('EOF in class variable declaration')

    advance()  # ';'

    return nfield


def compile_class():

    global _class

    if token[0] != 'class':
        abort("expected keyword 'class'")
    advance()

    if token[1] != 4:
        abort('expected identifier')
    _class = token[0]
    advance()

    if token[0] != '{':
        abort("expected '{'")
    advance()

    nfield = 0

    while token is not None and (token[0] == 'static' or token[0] == 'field'):
        nfield += compile_class_var_dec()

    if token is None:
        abort('EOF in class definition')

    while token is not None and token[0] != '}':
        if token[0] != 'constructor'       \
                and token[0] != 'function' \
                and token[0] != 'method':
            abort('expected subroutine declaration')

        compile_subroutine_dec(str(nfield))

    if token is None:
        abort('EOF in class definition')

    advance()  # '}'


def compile(fname, tokens):
    global _fname, _fo, _tokens, globl_symtab, nl
    token = False
    try:
        with open(fname, 'w') as fo:
            _fname = fname
            _fo = fo
            _tokens = tokens
            _tokens.reverse()
            globl_symtab = Symtab('static', 'this')
            nl = 1
            advance()
            compile_class()
    except IOError:
        abort('io error in file ' + fname)

