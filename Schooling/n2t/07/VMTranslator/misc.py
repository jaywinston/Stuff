from os import listdir
from os.path import basename, dirname, isdir, isfile, join
from sys import argv, exit

PROG = basename(argv[0])

def abort(nl=None, line=None, *args):
    print(PROG + ': error', end='')
    nl is not None and print(' on line', nl)
    print('\t> '+line.rstrip() if line else ': program argument')
    for l in args:
        print(l)
    exit(1)


# This is a bit of a misnomer.
def decomment(line):
    '''remove comments and external white space'''
    return line.split("//")[0].strip()


def mk_path(file, dir=None):
    if dir is None:
        dir = dirname(argv[0])
    return join(dir, basename(file))


def process_arg():

    arg = argv[1]

    if isfile(arg):
        if not arg.endswith('.vm'):
            abort(0,0, 'unrecognized file format', "expected 'vm' extension")
        infiles = [ arg ]
        fname = arg[:-3]

    elif isdir(arg):
        infiles = listdir(arg)
        fname = arg

    return infiles, fname

