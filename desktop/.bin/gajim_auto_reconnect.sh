#!/bin/bash

while [[ true ]]; do
    if [[ $(gajim-remote get_status) == 'offline' ]]; then
        gajim-remote change_status online
    fi
    sleep 5s
done
