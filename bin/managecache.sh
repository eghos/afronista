#!/usr/bin/env bash
# Script to manage cache on the cron boxes

if [ $# -lt 1 ]
then
    echo "You need to enter at least one argument, disablecache OR clearandenablecache"
    exit 1
fi

case "$1" in
    'disablecache')
    for i in $(ls -1A src/cf/ | grep cron | cut -d "." -f1 | tr '[:lower:]' '[:upper:]');
    do
        ../multitool/multitool tunnel -c 'sudo /usr/local/bin/cook disablecache' -t $i;
    done
    ;;
    'clearandenablecache')
    for i in $(ls -1A src/cf/ | grep cron | cut -d "." -f1 | tr '[:lower:]' '[:upper:]');
    do
        ../multitool/multitool tunnel -c 'sudo /usr/local/bin/cook clearandenablecache' -t $i;
    done
    ;;
esac
