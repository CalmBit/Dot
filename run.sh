#!/bin/bash


run_server_development() {
    printf "\x1b[36mStarting Dot Server \x1b[1;31m(DEVELOPMENT MODE)\x1b[0;37m\n"
    rvmsudo rails s --binding=104.236.224.216 -p 80
}

run_server_production() {
    printf "\x1b[36mStarting Dot Server \x1b[1;32m(PRODUCTION MODE)\x1b[0;37m\n"
    rvmsudo thin start -a 104.236.224.216 -p 443 -e production --ssl --ssl-key-file /etc/letsencrypt/live/dot.calmbit.com/privkey.pem --ssl-cert-file /etc/letsencrypt/live/dot.calmbit.com/fullchain.pem
}

run_git_maint() {
    echo "Performing basic git maintenance..."
    git pull origin master
    echo "Running bundler..."
    rvmsudo bundle install
}

if [ "$1" == "--pull" ] || [ "$2" == "--pull" ]; then
    run_git_maint
fi

if [ "$1" == "--production" ] || [ "$2" == "--production" ]; then
    run_server_production
else
    run_server_development
fi
