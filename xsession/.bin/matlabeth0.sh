#!/bin/sh

modprobe dummy
ip l set dev dummy0 name eth0
ip l set dev eth0 address f0:de:f1:0e:92:7f
