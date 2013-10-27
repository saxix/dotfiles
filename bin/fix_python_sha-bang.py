#!/usr/bin/env python

import os
import sys
TARGET="/data/VENV/testing/bin/python"

here = os.path.abspath(os.path.dirname(__file__))

for filename in os.listdir(here):
	filepath = os.path.join(here, filename)
	f = open(filepath, "r")
	line = f.read(2)
	print filename, line
	if line == "#!":	
		content = f.readlines()
		if 	TARGET in content[0]:
			print filename, content[0]
			new_header = content[0].replace(TARGET, "#!/usr/bin/env python")
			content[0] = new_header
			with open(filepath, "w") as o:
				o.write("".join(content))
	
