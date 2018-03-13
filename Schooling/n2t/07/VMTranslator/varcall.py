# todo: more abstract to handle 'funcs'
def _validate_object(obj, name):
    if obj is not None and not hasattr(obj, '__call__'):
        raise ValueError('{} must be callable or None'.format(name))
    return obj


class Varcall:


    def __init__(self, init, err, *funcs):
        self._init = None
        self._err = None
        self._funcs = None
        self.init = init
        self.err = err
        self.funcs = funcs


    @property
    def init(self):
        return self._init


    @init.setter
    def init(self, obj):
        self._init = _validate_object(obj, 'init')


    @property
    def err(self):
        return self._err


    @err.setter
    def err(self, obj):
        self._err = _validate_object(obj, 'err')


    @property
    def funcs(self):
        return self._funcs


    @funcs.setter
    def funcs(self, fs):
        if not isinstance(fs, (list, tuple)):
            raise ValueError('funcs must be a list or tuple')
        for f in fs:
            if not hasattr(f, '__call__'):
                raise ValueError('funcs must be a list or tuple'
                                 'of callable items')
        self._funcs = (None,) + tuple(fs)


    def run(self, *args):

        if self.init is not None:
            _args = self.init(*args)
        else:
            _args = args

        na = len(_args)

        if na > len(self.funcs) - 1:
            return self.err()
        return self.funcs[na](*_args)

