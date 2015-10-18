#!/bin/bash

if [ "$1" == "--production" ]; then
    echo "Starting Dot Server (PRODUCTION MODE)"
    rails s --binding=104.236.224.216 -p 80 -e production
else
    echo "Starting Dot Server (DEVELOPMENT MODE)"
    rails s --binding=104.236.224.216 -p 80
fi
