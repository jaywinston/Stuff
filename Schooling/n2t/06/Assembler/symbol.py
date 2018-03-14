import json
import re
from os.path import dirname, join

re_symbol = re.compile('[$:.\w]+')
digit = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') 
addr = 15

json_file = join(dirname(__file__), 'tables.json')
with open(json_file) as f:
    symtab = json.load(f)['symbol']


def not_valid(sym):
    return not re_symbol.fullmatch(sym) or sym.startswith(digit)


def next_addr():
    global addr
    addr += 1
    if addr < 16:
        raise ValueError('attempt to bind reserved memory to symbol\n'
                         'attempted value: {}'.format(addr))
    return addr


def install_label(name, defn):

    if not name.endswith(')'):
        return None

    label = name[1:-1]  # strip outer parens

    if not_valid(label):
        return None

    if label in symtab:
        return None

    symtab[label] = defn

    return symtab[label]


def install_symbol(name):

    if not_valid(name):
        return None

    symtab[name] = next_addr()

    return symtab[name]


def install(name, defn=None):

    if defn is None:
        return install_symbol(name)
    return install_label(name, defn)


def lookup(name):
    return symtab.get(name)

