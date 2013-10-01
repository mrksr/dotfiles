#!/bin/sh

vol=$(amixer get Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "M" } else { print $2 }}' | head -n 1)
echo $vol%
