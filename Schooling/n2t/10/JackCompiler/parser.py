from lexer import init_lex, next_token

classtab = ('keyword', 'symbol', 'integerConstant',
            'stringConstant', 'identifier')


_xmltab = {'<': '&lt;', '>': '&gt;', '"': '&quot;', '&': '&amp;'}
def write_terminal():
    global token
    t = _xmltab.get(token[0]) or token[0]
    _fo.write('<{0}>{1}</{0}>\n'.format(classtab[token[1]], t))
    token = next_token()


def compile_expressionList():
    while token is not None and token[0] != ')':
        compile_expression()
        if token[0] == ',':
            write_terminal()

    if token is None:
        raise Exception('unexpected EOF')


def compile_term():

    # unaryOp
    if token[0] == '-' or token[0] == '~':
        write_terminal()
        compile_term()

    elif token[0] == '(':
        write_terminal()
        compile_expression()
        write_terminal()  # ')'

    # integerConstant stringConstant keywordConstant
    # varName className subroutineName
    elif token[0] != ';':
        write_terminal()

    ### postfix compound term ###

    if token[0] == '[':
        write_terminal()
        compile_expression()
        write_terminal()  # ']'

    elif token[0] == '(':
        write_terminal()
        compile_expressionList()
        write_terminal()

    elif token[0] == '.':
        write_terminal()
        write_terminal()         # subroutineName
        write_terminal()         # '('
        compile_expressionList()
        write_terminal()         # ')'


def compile_expression():

    compile_term()

    if token[0] in '+-*/&|<>=':
        write_terminal()
        compile_term()


def compile_returnStatement():

    # 'return'
    write_terminal()

    compile_expression()

    if token[0] != ';':
        raise Exception(token[0])
    write_terminal()


def compile_doStatement():

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

    if token[0] != '(':
        raise Exception(token[0])
    write_terminal()  # '('
    compile_expressionList()
    write_terminal()  # ')'

    if token[0] != ';':
        raise Exception(token[0])
    write_terminal()


def compile_whileStatement():

    # 'while'
    write_terminal()

    if token[0] != '(':
        raise Exception(token[0])
    write_terminal()

    compile_expression()

    if token[0] != ')':
        raise Exception(token[0])
    write_terminal()

    if token[0] != '{':
        raise Exception(token[0])
    write_terminal()

    compile_statements()

    if token[0] != '}':
        raise Exception(token[0])
    write_terminal()


def compile_ifStatement():

    # 'if'
    write_terminal()

    if token[0] != '(':
        raise Exception(token[0])
    write_terminal()

    compile_expression()

    if token[0] != ')':
        raise Exception(token[0])
    write_terminal()

    if token[0] != '{':
        raise Exception(token[0])
    write_terminal()

    compile_statements()

    if token[0] != '}':
        raise Exception(token[0])
    write_terminal()

    if token[0] == 'else':

        write_terminal()

        if token[0] != '{':
            raise Exception(token[0])
        write_terminal()

        compile_statements()

        if token[0] != '}':
            raise Exception(token[0])
        write_terminal()


def compile_letStatement():

    # 'let'
    write_terminal()

    if token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    if token[0] == '[':
        write_terminal()
        compile_expression()
        write_terminal()  # ']'

    if token[0] != '=':
        raise Exception(token[0])
    write_terminal()

    compile_expression()

    if token[0] != ';':
        raise Exception(token[0])
    write_terminal()


def compile_statements():
    while token is not None and token[0] != '}':
        eval('compile_' + token[0] + 'Statement()')

    if token is None:
        raise Exception('unexpected EOF')


def compile_varDec():

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
 
    if token[0] == ',':
        write_terminal()
    
        while token is not None and token[0] != ';':

            # varName
            if token[1] != 4:
                raise Exception(token[0])
            write_terminal()
 
            # ','
            if token[0] == ',':
                write_terminal()

        if token is None:
            raise Exception('unexpected EOF')

    if token[0] != ';':
        raise Exception(token[0])
    write_terminal()


def compile_subroutineBody():

    while token is not None and token[0] != '}':

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

    if token is None:
        raise Exception('unexpected EOF')


def compile_parameterList():

    while token is not None and token[0] != ')':
 
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
 
        if token[0] == ',':
            write_terminal()

    if token is None:
        raise Exception('unexpected EOF')
 

def compile_subroutineDec():

    # 'constructor' 'function' 'method'
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
    write_terminal()

    # subroutineBody
    if token[0] != '{':
        raise Exception(token[0])
    write_terminal()

    # compile_subroutineBody will decide if it's an acceptable kw.
    if token[0] != '}' and token[1] != 0:
        raise Exception(token[0])
    compile_subroutineBody()
    
    write_terminal()  # '}'


def compile_classVarDec():

    # 'static' 'field'
    write_terminal()

    # type
    if token[0] != 'int'              \
            and token[0] != 'char'    \
            and token[0] != 'boolean' \
            and token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    if token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    while token is not None and token[0] != ';':
        if token[0] != ',' and token[1] != 4:
            raise Exception(token[0])
        write_terminal()  # ','
        write_terminal()  # identifier

    if token is None:
        raise Exception('unexpected EOF')

    write_terminal()  # ';'


def compile_class():

    if token[0] != 'class':
        raise Exception(token[0])

    _fo.write('<tokens>\n')

    write_terminal()  # 'class'

    if token[1] != 4:
        raise Exception(token[0])
    write_terminal()

    if token[0] != '{':
        raise Exception(token[0])
    write_terminal()

    while token is not None and token[0] != '}':

        if token[0] == 'static' or token[0] == 'field':
            compile_classVarDec()

        elif token[0] == 'constructor'    \
                or token[0] == 'function' \
                or token[0] == 'method':
            compile_subroutineDec()

        else:
            raise Exception(token[0])

    if token is None:
        raise Exception('unexpected EOF')

    write_terminal()  # '}'

    _fo.write('</tokens>\n')


def compile(fi, fo):
    init_lex(fi.read())
    global _fo, token
    _fo = fo
    token = next_token()
    compile_class()

