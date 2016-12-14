#!/bin/bash
# Run this in the world's folder, same location as auth.txt.
# It finds any users who don't actually exist in auth.txt, and gives you a simple script to purge them from the players/ folder
# Can automate running ./cleanplayers-destroy.sh after this executes, but by default it allows you to first review and edit before running it.

# 0 = no output, 1 = output
output=1

# 0 = do not auto-run, 1 = auto-run after completion
# Suggest you run it without auto-run first, review the script, and decide if you "trust" it before changing setting
$autorun=0

file=./cleanauth-destroy.sh
echo '#!/bin/bash' > $file
echo "cp ./auth.txt auth.bak" >> $file

for player in `cat auth.txt`; do
   playername=${player%%:*}
    if [[ -e "players/$playername" ]]; then
      if [[ $output = 1 ]]; then echo "$playername exists"; fi
    else
      if [[ $output = 1 ]]; then echo "$playername does not exist"; fi
      echo "rm 'players/$playername'" >> $file
    fi

done

echo "echo Done. There is a backup auth.bak file, just in case." >> $file
echo "rm $file" >> $file
chmod +x $file

if [[ $autorun = 1 ]]; then $file; else echo "Done. Please read $file and run it if you approve."; fi
