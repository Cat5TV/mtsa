#!/bin/bash
  source inc/systemconf.sh
  source config.sh

  echo "Minetest Server Admin for Linux"
  echo "By Robbie Ferguson - https://minetest.tv"
  echo "----------------------------------------"
  echo "Safely Stop minetestserver $ver"
  echo ""
  
if [[ $EUID -ne 0 ]]; then
  echo "ERROR: You must be a root" 2>&1
  exit 1
else
  echo Safely stopping Minetest servers...
  touch /tmp/mtsa-$mtuser-lock
  $BASEDIR/flushcache.sh $mtdev
  # Game still running: Sleep long enough for map changes to be saved to cache
  sleep 45
  # Flush the cache
  $BASEDIR/flushcache.sh $mtdev
  echo Shutting down servers...
  kill `find /tmp/mtsa-$mtuser-pid* -type f -exec cat {} \;`

  printf "Preparing to flush memory cache... "
  sleep 5
  $BASEDIR/flushcache.sh $mtdev

  # Clearing player list in logs - do not change this line
  CLEARED="MTSA - Minetest Stopped. List of players: "
  su $mtuser -c 'echo $CLEARED >> `find $mtlogs/*.log -type f -exec cat {} \;`'
  
  echo "ready"
  sleep 15
  $BASEDIR/flushcache.sh $mtdev
  sleep 1
  echo 'Done.'
fi
