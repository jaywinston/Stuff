from lexer import init_lex, next_token

classtab = ('keyword', 'symbol', 'integerConstant',
            'stringConstant', 'identifier')


def write_terminal():
    global token
    _fo.write('<{0}>{1}</{0}>\n'.format(classtab[token[1]], token[0]))
    token = next_token()


def compile_expressionList():
    global token


def compile_term():
    global token


def compile_expression():
    global token


def compile_returnStatement():
    global token

    # 'return'
    write_terminal()

    # DUMMY
    while token[0] != ';':
        write_terminal()

    # ';'
    write_terminal()


def compile_doStatement():
    global token

    # 'do'
    write_terminal()

    # subroutineName or className|varName
    if token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    # '.'?
    if token[0] == '.':
        write_terminal()
        # subroutineName
        if token[1] != 4:
            raise Exception(token[0])
        write_terminal()

    # '('
    if token[0] != '(':
        raise Exception(token[0])
    write_terminal()

    # DUMMY
    while token[0] != ')':
        write_terminal()

    # ')'
    write_terminal()

    # ';'
    write_terminal()


def compile_whileStatement():
    global token

    # 'while'
    write_terminal()

    # '('
    if token[0] != '(':
        raise Exception(token[0])
    write_terminal()

    # DUMMY
    while token[0] != ')':
        write_terminal()

    # ')'
    if token[0] != ')':
        raise Exception(token[0])
    write_terminal()

    # '{'
    if token[0] != '{':
        raise Exception(token[0])
    write_terminal()

    compile_statements()

    # '}'
    if token[0] != '}':
        raise Exception(token[0])
    write_terminal()


def compile_ifStatement():
    global token

    # 'if'
    write_terminal()

    # '('
    if token[0] != '(':
        raise Exception(token[0])
    write_terminal()

    # DUMMY
    while token[0] != ')':
        write_terminal()

    # ')'
    if token[0] != ')':
        raise Exception(token[0])
    write_terminal()

    # '{'
    if token[0] != '{':
        raise Exception(token[0])
    write_terminal()

    compile_statements()

    # '}'
    if token[0] != '}':
        raise Exception(token[0])
    write_terminal()

    if token[0] == 'else':

        # 'else'
        write_terminal()

        # '{'
        if token[0] != '{':
            raise Exception(token[0])
        write_terminal()

        compile_statements()

        # '}'
        if token[0] != '}':
            raise Exception(token[0])
        write_terminal()


def compile_letStatement():
    global token

    # 'let'
    write_terminal()

    # varName
    if token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    # '['
    if token[0] == '[':
        write_terminal()

        # DUMMY
        while token[0] != ']':
            write_terminal()

        # ']'
        write_terminal()

    # '='
    if token[0] != '=':
        raise Exception(token[0])
    write_terminal()

    # DUMMY
    while token[0] != ';':
        write_terminal()

    # ';'
    write_terminal()


def compile_statements():
    global token

    while token[0] != '}':
        eval('compile_' + token[0] + 'Statement()')


def compile_varDec():
    global token

    # 'var'
    write_terminal()

    # type
    if token[0] != 'int'              \
            and token[0] != 'char'    \
            and token[0] != 'boolean' \
            and token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    # varName
    if token[1] != 4:
        raise Exception(token[0])
    write_terminal()
 
    # ','
    if token[0] == ',':
        write_terminal()
    
        while token[0] != ';':

            # varName
            if token[1] != 4:
                raise Exception(token[0])
            write_terminal()
 
            # ','
            if token[0] == ',':
                write_terminal()

    # ';'
    write_terminal()


def compile_subroutineBody():
    global token

    while token[0] != '}':
        if token[0] == 'var':
            compile_varDec()
        elif token[0] == 'let'         \
                or token[0] == 'if'    \
                or token[0] == 'while' \
                or token[0] == 'do'    \
                or token[0] == 'return':
            compile_statements()
        else:
            raise Exception(token[0])


def compile_parameterList():
    global token

    while token[0] != ')':
 
        # type
        if token[0] != 'int'              \
                and token[0] != 'char'    \
                and token[0] != 'boolean' \
                and token[1] != 4:
            raise Exception(token[0])
        write_terminal()
    
        # varName
        if token[1] != 4:
            raise Exception(token[0])
        write_terminal()
 
        # ','
        if token[0] == ',':
            write_terminal()
 

def compile_subroutineDec():
    global token

    # constructor function method
    write_terminal()

    # type
    if token[0] != 'int'              \
            and token[0] != 'char'    \
            and token[0] != 'boolean' \
            and token[0] != 'void'    \
            and token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    # subroutineName
    if token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    # '('
    if token[0] != '(':
        raise Exception(token[0])
    write_terminal()

    # parameterList
    if token[0] != ')'                \
            and token[0] != 'int'     \
            and token[0] != 'char'    \
            and token[0] != 'boolean' \
            and token[1] != 4:
        raise Exception(token[0])
    compile_parameterList()

    if token[0] != ')':
        raise Exception(token[0])
    write_terminal()  # ')'

    # subroutineBody
    if token[0] != '{':
        raise Exception(token[0])
    write_terminal()  # '{'

    if token[0] != '}' and token[1] != 0:  # must be a keyword or empty body
        raise Exception(token[0])          # compile_subroutineBody will
    compile_subroutineBody()               # decide if it's an acceptable kw.
    
    write_terminal()  # '}'


def compile_classVarDec():
    global token

    # storage class
    write_terminal()

    # type
    if token[0] != 'int'              \
            and token[0] != 'char'    \
            and token[0] != 'boolean' \
            and token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    # identifier
    if token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    while token[0] != ';':
        if token is None or (token[0] != ',' and token[1] != 4):
            raise Exception(token[0])
        write_terminal()  # ','
        write_terminal()  # identifier

    write_terminal()  # ';'


def compile_class():

    if token[0] != 'class':
        raise Exception(token[0])

    _fo.write('<tokens>\n')

    write_terminal()

    if token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    if token[0] != '{':
        raise Exception(token[0])
    write_terminal()

    while token[0] != '}':
        if token is None:
            raise Exception(token[0])
        if token[0] == 'static' or token[0] == 'field':
            compile_classVarDec()
        elif token[0] == 'constructor'    \
                or token[0] == 'function' \
                or token[0] == 'method':
            compile_subroutineDec()
        else:
            raise Exception(token[0])

    write_terminal()  # '}'

    _fo.write('</tokens>\n')


def compile(fi, fo):
    global _fo, token
    _fo = fo
    init_lex(fi.read())
    token = next_token()
    compile_class()

