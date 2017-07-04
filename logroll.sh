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

shopt -s nullglob
for logfile in $mtlogs/*.log # ***CAREFUL - these get deleted forcibly!
  do
    filename=${logfile##*/}
    SERVER=${filename%.log}
    if ps -p `cat /tmp/mtsa-$mtuser-pid-$SERVER` > /dev/null
      then
        echo "$SERVER is running. Skipping."
      else
        # Do not overwrite an existing tar.gz file!
        if [ -f "$outputfile" ]
        then
            echo "$outputfile already exists. Aborting."
        else
          outputfile="$mtlogs/$logdate-$SERVER.tar.gz"
          echo Creating a tar.gz of $SERVER and removing the log files...
          # This will only remove the files if the tar operation gave no errors
          tar -czf $outputfile $logfile && rm -f $logfile
          echo Done.
        fi
    fi
done

