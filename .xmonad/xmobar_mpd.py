#!/usr/bin/env python
# -*- coding: utf-8 -*-

# IMPORTS
import sys
import pprint

from mpd import (MPDClient, CommandError)
from socket import error as SocketError

HOST = 'localhost'
PORT = '6600'
PASSWORD = False
##
CON_ID = {'host':HOST, 'port':PORT}
##

## Some functions
def mpdConnect(client, con_id):
    """
    Simple wrapper to connect MPD.
    """
    try:
        client.connect(**con_id)
    except SocketError:
        return False
    return True

def mpdAuth(client, secret):
    """
    Authenticate
    """
    try:
        client.password(secret)
    except CommandError:
        return False
    return True
##

def main():
    ## MPD object instance
    client = MPDClient()
    mpdConnect(client, CON_ID)
    #if mpdConnect(client, CON_ID):
        #print 'Got connected!'
    #else:
        #print 'fail to connect MPD server.'
        #sys.exit(1)

    # Auth if password is set non False
    #if PASSWORD:
        #if mpdAuth(client, PASSWORD):
            #print 'Pass auth!'
        #else:
            #print 'Error trying to pass auth.'
            #client.disconnect()
            #sys.exit(2)

    if client.status()['state'] == 'play':
        artist = client.currentsong().get('artist')
        title = client.currentsong().get('title')

        if artist is not None:
            if title is not None:
                print "%s - %s" % (artist, title)
            else:
                print artist
        else:
            print title
    else:
        print "no music"

    client.disconnect()
    sys.exit(0)

# Script starts here
if __name__ == "__main__":
    main()
