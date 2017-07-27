#!/bin/bash

while true; do
    if [[ $(gajim-remote check_gajim_running) == 'True' ]]; then
        if [[ $(gajim-remote get_status) == 'offline' ]]; then
            if ping -c 1 -W 2 zfix.org &> /dev/null; then
                gajim-remote change_status online
            fi
        fi
    fi
    sleep 5s
done
