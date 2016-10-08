import jedi
import json


def main():
    def names():
        print(temp, ice. banana)

        print(u"aaaaaaaa")

    session = Session(
        "/home/romaine/.atom/dev/packages/python-suite/lib/outline.py")
    dialogue(session)


class Session:

    def __init__(self, source_path):

        self.source_path = open(source_path).read()

    def names(self):
        namelist = jedi.defined_names(self.source_path)
        for name in namelist:
            yield {"name": name.name,
                   "type": name.type,
                   "line": name.line,
                   "pos": name.start_pos,
                   "doc": name.doc}


def dialogue(self):
    while 1:
        recv = str(input())
        recv = recv.split()
        if recv[0] == "names":
            print(json.dumps([name for name in self.names()]))


if __name__ == '__main__':
    main()
