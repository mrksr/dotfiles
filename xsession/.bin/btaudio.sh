#!/bin/bash

BLUEZCARD=`pactl list cards short | egrep -o bluez.*[[:space:]]`
echo $BLUEZCARD
pactl set-card-profile $BLUEZCARD a2dp_sink
pactl set-card-profile $BLUEZCARD off
pactl set-card-profile $BLUEZCARD a2dp_sink
