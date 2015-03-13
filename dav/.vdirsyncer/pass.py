#!/usr/bin/env python
#*-* coding: utf-8 *-*

import locale
from subprocess import Popen, PIPE

encoding = locale.getdefaultlocale()[1]

def get_password(user, server):
    (out, err) = Popen(["secret-tool", "lookup", "service", "radicale",  "user", user, "server", server], stdout=PIPE).communicate()
    return out.decode(encoding).strip()

if __name__ == "__main__":
    import sys
    user, server = sys.argv[1], sys.argv[2]
    print(get_password(user, server))
