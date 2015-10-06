with open("pantones_raw") as f: print "\n".join(" ".join(x.split()[-3:]) for x in f.read().splitlines())
