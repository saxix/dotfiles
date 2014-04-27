#!/usr/bin/env python

import os
import sys

TARGET = "/data/VENV/testing/bin/python"

here = os.path.abspath(os.path.dirname(__file__))

for filename in os.listdir('/data/VENV/testing/bin/'):
    filepath = os.path.join('/data/VENV/testing/bin/', filename)
    if os.path.isfile(filepath):
        f = open(filepath, "r")
        line = f.read(2)
        if line == "#!":
            print ' ', filename, line
            content = f.readlines()
            if TARGET in content[0]:
                new_header = content[0].replace(TARGET, "#!/usr/bin/env python")
                content[0] = new_header
                with open(filepath, "w") as o:
                    o.write("".join(content))
        else:
            print '# ', filename, line
