#!/usr/bin/env python

import requests

base = 'http://www.poigps.com'

url = lambda path: "%s%s" % (base, path)

s = requests.Session()
res = s.get(url('/'))
res = s.get(url('/modules.php?name=Downloads'))
res = s.get(url('/modules.php?name=Downloads&d_op=getit&lid=140'))
res = s.get(url('/modules.php?name=Downloads&d_op=getit&lid=141&opi=ds&submit=SCARICA+IL+FILE'), stream=True)
with open('autovelox.zip', 'wb') as f:
    for chunk in res    .iter_content(chunk_size=1024):
        if chunk: # filter out keep-alive new chunks
            f.write(chunk)
            f.flush()

# URL='http://www.poigps.com/modules.php?name=Downloads&d_op=getit&lid=140&opi=ds&submit=SCARICA+IL+FILE'
#
# pushd /tmp
# curl -L $URL -o /tmp/poi.zip
#
