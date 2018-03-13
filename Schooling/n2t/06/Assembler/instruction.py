import json
import re
from os.path import dirname, join
from symbol import install, lookup

re_asm = re.compile('[01ADMEGJLNPQT=;!+&|-]{1,11}')

json_file = join(dirname(__file__), 'tables.json')
with open(json_file) as f:
    tables = json.load(f)

comptab = tables['comp']
desttab = tables['dest']
jumptab = tables['jump']
del tables


def int2Ahack(n):
    return '{:016b}\n'.format(n)


def a_cmd(asm):

    expr = asm[1:]  # strip '@'

    if expr.isdigit():
        hack = int(expr)
        
    elif expr.startswith('R'):  # could be a RAM register
        reg = expr[1:]  # strip 'R'
        if reg.isdigit():
            reg = int(reg)
            if 0 <= reg <= 15:
                hack = reg

    else:
        hack = lookup(expr) or install(expr)

    if hack is None:
        return None

    return int2Ahack(hack)


def c_cmd(asm):

    cmd = ''.join(asm.split())

    if not re_asm.fullmatch(cmd)  \
            or cmd.count('=') > 1 \
            or cmd.count(';') > 1:
        return None

    eq = cmd.index('=') if '=' in cmd else 0
    sc = cmd.index(';') if ';' in cmd else len(cmd)

    dest = cmd[:eq]
    comp = cmd[eq:sc].lstrip('=')
    jump = cmd[sc:].lstrip(';')

    hack = '111'

    # a field
    hack += '1' if 'M' in comp else '0'

    # comp field
    if comp not in comptab:
        return None
    hack += comptab[comp]

    # dest field
    if not dest in desttab:
        return None
    hack += desttab[dest]

    # jump field
    if jump not in jumptab:
        return None
    hack += jumptab[jump]

    hack += '\n'

    return hack


def asm2hack(asm):
    if asm.startswith('@'):
        return a_cmd(asm)
    else:
        return c_cmd(asm)

