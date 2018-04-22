class Symtab(dict):

    def __init__(self, *segments):
        self.index = {}
        for seg in segments:
            self.index[seg] = -1


    def _next_index(self, segment):
        self.index[segment] += 1
        return str(self.index[segment])


    def install(self, name, segment, type):
        self[name] = {
            'segment' : segment,
            'index'   : self._next_index(segment),
            'type'    : type
        }

