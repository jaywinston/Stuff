import json
import re
from misc import mk_path


def none():
    return None

#
# data
#

json_file = mk_path('tables.json')
with open(json_file) as f:
    tables = json.load(f)

cmdtab = tables['commands']
segtab = tables['segments']
_boot = tables['boot']
del f, tables

#
# parsing
#

re_symbol = re.compile('[:.\w]+')


def init_parse(line):

    return re.findall('\S+', line)


def parse1(cmd):
    if cmd not in cmdtab:
        return None
    return (cmd,)


def parse2(cmd, label):
    if cmd not in cmdtab or not re_symbol.fullmatch(label):
        return None
    return cmd, label


def valid(s):
    return s in segtab or re_symbol.fullmatch(s)


def parse3(cmd, a0, a1):
    if cmd not in cmdtab       \
            or not valid(a0)   \
            or not a1.isdigit():
        return None
    return cmd, a0, a1

PARSE_FUNCS = init_parse, none, parse1, parse2, parse3

#
# translation
#

_file = None
_func = None
tags = {'eq': 0, 'gt': 0, 'lt': 0, 'call': 0}


def set_static_segment(file):
    global _file
    _file = file


def next_tag(cmd):
    if cmd in tags:
        tags[cmd] += 1
    return tags.get(cmd)


def format(line, **kwargs):
    fline = line.format(**kwargs) + '\n'
    if not line.startswith('('):
        fline = '  ' + fline
    return fline


def tran1(cmd):

    tag = next_tag(cmd)
    asm = ''

    for l in cmdtab[cmd]:
        asm += format(l, tag=tag)

    return asm


def tran2(cmd, label):
    asm = ''
    for l in cmdtab[cmd]:
        asm += format(l, func=_func, label=label)
    return asm


def resolve_address(seg, n):

    segment = segtab[seg]

    if seg == 'constant':
        return format(segment, cval=n)

    if seg == 'static':
        return format(segment, file=_file, tag=n)

    if seg in "pointer temp":
        return format('@{addr}', addr=int(segment)+int(n))

    asm = format(segment)
    if n == '0':
        asm += format(segtab['deref'])
    else:
        for l in segtab['offset']:
            asm += format(l, off=n)

    return asm


def execute(cmd, seg):
    target = 'A' if seg == 'constant' else 'M'
    asm = ''
    for l in cmdtab[cmd]:
        asm += format(l, target=target)
    return asm


def mem_cmd(cmd, a0, a1):
    asm = resolve_address(a0, a1)
    asm += execute(cmd, a0)
    return asm


def function(cmd, func, n):
    
    global _func
    _func = func

    fcmd = cmdtab[cmd]
    asm = format(fcmd[0], func=func)

    if n != '0':
        asm += format(fcmd[1])
        asm += format(fcmd[2])
        for _ in range(int(n)):
            asm += format(fcmd[3])
            asm += format(fcmd[4])
        asm += format(fcmd[5])
        asm += format(fcmd[6])
        asm += format(fcmd[7])

    return asm


def func_cmd(cmd, func, n):

    if cmd == 'function':
        return function(cmd, func, n)

    tag = next_tag(cmd)
    asm = ''
    for l in cmdtab[cmd]:
        asm += format(l, tag=tag, n=n, func=func)
    return asm


def tran3(cmd, a0, a1):
    if cmd in "push pop":
        return mem_cmd(cmd, a0, a1)
    return func_cmd(cmd, a0, a1)

TRAN_FUNCS = None, none, tran1, tran2, tran3


def boot():
    global _func
    _func = 'Sys.init'
    asm = ''
    for l in _boot:
        asm += format(l)
    asm += func_cmd('call', 'Sys.init', 0)
    return asm

