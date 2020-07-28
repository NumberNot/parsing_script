#!/bin/bash

source ./config.cfg
usage() { echo "$0 usage:" && grep " .)\ #" $0; exit 0; }
#[ $# -eq 0 ] && usage

while getopts :hl:s: option; do 
  case "${option}" in
    l) # path to LOGFILE.
      SLOG=${OPTARG}
      ;;
    s) # STRING to search.
      SSTRING=${OPTARG}
      ;;
    h) # this HELP.
    usage
    exit 0
    ;;
  esac
done

#journalctl --file $SLOG -u sv-bcnd@*.service -f | grep $SSTRING | awk -F'[][]' '{print $2}' #return PID only
#journalctl --file $SLOG -u sv-bcnd@*.service -f | grep --line-buffered $SSTRING | grep -o -P '(?<=\[).*(?=\])' #return PID only
journalctl --file $SLOG -u sv-bcnd@*.service -f | grep --line-buffered $SSTRING | awk -F'[[ ]' '{print "pkill -9 " $5}' #return only name of a process