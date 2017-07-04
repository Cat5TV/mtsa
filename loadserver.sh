#!/bin/bash

# No changes beyond this point

  source inc/systemconf.sh
  source config.sh

  echo "Minetest Server Admin for Linux"
  echo "By Robbie Ferguson - https://minetest.tv"
  echo "----------------------------------------"
  echo "minetestserver Loader Utility $ver"
  echo "For Minetest Hosting Environments"
  echo ""

if [[ $EUID -ne 0 ]]; then
  echo "ERROR: This script must be run as root" 2>&1
  echo "Recommendation: Add script to crontab with @reboot" 2>&1
  exit 1
else
  export SERVER=$1

  me=`basename "$0"`
  USAGE="Usage: ./$me WORLDNAME"
  if [ -z "$SERVER" ]; then echo $USAGE; exit; fi
  while :
  do
    # Sleep a bit longer than the map save to disk
    sleep 45
    $PWD/flushcache.sh $mtdev
    sleep 5
    if [ ! -f /tmp/mtsa-$mtuser-lock ]; then
      su $mtuser -c '
        start_time=`date +%s`
        "'$mtgame'"/bin/minetestserver --config "'$mtconf'"/"'$SERVER'".conf --logfile "'$mtlogs'"/"'$SERVER'".log --map-dir "'$mtmaps'"/"'$SERVER'" &
        minepid=$!
        echo $minepid > /tmp/mtsa-"'$mtuser'"-pid-"'$SERVER'"
        wait $minepid
        # Clearing player list in logs
          CLEARED="Minetest Stopped. List of players: "
          echo $CLEARED >> "'$mtlogs'"/"'$SERVER'".log
        end_time=`date +%s`
        echo Server was up for `expr $end_time - $start_time` seconds.
        rm mtsa-"'$mtuser'"-pid-$SERVER
	# Create Log and Email it
	echo $SERVER server crashed > /tmp/mtsa-"'$mtuser'"-crash-$SERVER.log
        echo Server was up for `expr $end_time - $start_time` seconds. >> /tmp/mtsa-"'$mtuser'"-crash-"'$SERVER'".log
	tail -n 200 "'$mtlogs'"/testing.log >> /tmp/mtsa-"'$mtuser'"-crash-$SERVER.log
        sleep 5
      '
    fi
  done
fi
