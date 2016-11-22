#!/bin/bash
# Run this in the world's folder, same location as auth.txt.
# It finds any users who don't actually exist, and gives you a simple script to purge them from auth.txt
# Can automate running ./cleanplayers-destroy.sh after this executes, but by default it allows you to first review and edit before running it.

file=./cleanplayers-destroy.sh
echo '#!/bin/bash' > $file
echo "cp ./auth.txt auth.bak" >> $file
while IFS=':' read -ra PLAYER; do
  for i in "${PLAYER}"; do
    if [[ -e "players/$i" ]]; then
      echo "$i exists";
    else
      echo "$i does not exist";
      echo "sed -i '/^$i:/d' ./auth.txt" >> $file
    fi
  done
done <<< `cat auth.txt`
echo "echo Done. There is a backup auth.bak file, just in case." >> $file
echo "rm $file" >> $file
chmod +x $file
echo Done. Please read $file and run it if you approve.
