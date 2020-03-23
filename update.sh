#!/bin/bash

ssh -t root@192.168.248.175 'cd /usr/share/nginx && ./update.sh && exec bash'
