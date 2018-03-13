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
del f, tables

#
# parsing
#


def init_parse(line):

    return re.findall('\S+', line)


def parse1(cmd):
    if cmd not in cmdtab:
        return None
    return (cmd,)


def parse2(cmd, label):
    if cmd not in cmdtab:
        return None
    return 'parse2'


def parse3(cmd, a0, a1):
    if cmd not in cmdtab        \
            or a0 not in segtab \
            or not a1.isdigit():
        return None
    return cmd, a0, a1

PARSE_FUNCS = init_parse, none, parse1, parse2, parse3

#
# translation
#

_fname = None
tags = {'eq': 0, 'gt': 0, 'lt': 0}


def set_static_segment(file):
    global _fname
    _fname = file



def next_tag(cmd):
    if cmd in tags:
        tags[cmd] += 1
    return tags.get(cmd)


def format(line, **kwargs):
    fline = line.format(**kwargs) + '\n'
    if not line.startswith('('):
        fline = '\t' + fline
    return fline


def tran1(cmd):

    tag = next_tag(cmd)
    asm = ''

    for l in cmdtab[cmd]:
        asm += format(l, tag=tag)

    return asm


def tran2(cmd, arg):
    return 'tran2'


def resolve(seg, n):

    segment = segtab[seg]

    if seg == 'constant':
        return format(segment, cval=n)

    asm = format(segment, file=_fname, tag=n)

    if n != '0' and segment != 'static':
        target = 'A' if seg in "pointer temp" else 'M'
        for l in segtab['offset']:
            asm += format(l, target=target, off=n)

    return asm


def execute(cmd, seg):
    target = 'A' if seg == 'constant' else 'M'
    asm = ''
    for l in cmdtab[cmd]:
        asm += format(l, target=target)
    return asm


def tran3(cmd, a0, a1):
    asm = resolve(a0, a1)
    asm += execute(cmd, a0)
    return asm

TRAN_FUNCS = None, none, tran1, tran2, tran3

