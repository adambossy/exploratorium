with open("rgb") as f: print ",\n".join("(" + ", ".join(x.split()) + ")" for x in f.read().splitlines())
