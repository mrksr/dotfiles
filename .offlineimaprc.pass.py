#!/usr/bin/env python
#*-* coding: utf-8 *-*

import locale
from subprocess import Popen, PIPE

encoding = locale.getdefaultlocale()[1]

def get_password(user, server):
    (out, err) = Popen(["secret-tool", "lookup", "user", user, "server", server], stdout=PIPE).communicate()
    return out.decode(encoding).strip()
