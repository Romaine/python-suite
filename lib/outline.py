import jedi
import json


def main():
    dialogue()


class Session:

    sessions = {}

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


def dialogue():
    sessions = Session.sessions
    while 1:
        recv = input()
        if not recv:
            continue
            print(json.dumps(["continuing"]))
        else:
            recv = json.loads(recv)
            if "command"in recv:
                if recv["command"] == "names":
                    if "path" in recv:
                        if recv["path"] not in sessions:
                            sessions[recv["path"]] = Session(recv["path"])
                        if "source" in recv:
                            sessions[recv["path"]].source_path = recv["source"]
                            print(
                                json.dumps({recv["path"]: [name for name in sessions[recv["path"]].names()]}))


if __name__ == '__main__':
    main()
