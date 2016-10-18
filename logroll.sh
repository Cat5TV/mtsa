#!/bin/bash
  source inc/systemconf.sh
  source config.sh

  # Specify dependencies
  declare -a depends=("tar")

  echo "Minetest Server Admin for Linux"
  echo "By Robbie Ferguson - https://minetest.tv"
  echo "----------------------------------------"
  echo "Log Rollover Utility $ver"
  echo "This can be run manually, but is perfect as part of your nightly backup script"
  echo ""
  
  source ./inc/check-depends.sh
  
logdate=`date --date='yesterday' +"%Y-%m-%d"`
outputfile="$mtlogs/$logdate.tar.gz"
logfiles="$mtlogs/*.log" # ***CAREFUL - these get deleted forcibly!

if pgrep "minetestserver" > /dev/null
  then
    echo "You may not run this script while minetestserver is running. Aborted."
    exit
  else
    # Do not overwrite an existing tar.gz file!
    if [ -f "$outputfile" ]
    then
        echo "$outputfile already exists. Aborting."
    else
      echo Creating a tar of current logs and removing the log files...
      # This will only remove the files if the tar operation gave no errors
      tar -czf $outputfile $logfiles && rm -f $logfiles
      echo Done.
    fi
fi
