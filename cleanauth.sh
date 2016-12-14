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
echo "cp -R ./players ./players-bak/" >> $file

# Generate a list of players who exist in auth.txt
players=()
for player in `cat auth.txt`; do
   players+=("\t${player%%:*}\t") # Adding tabs so Blah doesn't show positive for player BlahBlah
done

# Loop through the player files and see if the player file exists in the array. If not, plan to delete the player file
cd players
for playerfile in "./"; do
  echo "Processing $playerfile file..."
  if [[ ! "\t${players[@]}\t" =~ "\t${playerfile}\t" ]]; then
    echo "rm ./players/$playerfile" >> $file
  fi
done
cd ..


echo "echo Done. There is a backup players.bak folder, just in case." >> $file
echo "rm $file" >> $file
chmod +x $file

if [[ $autorun = 1 ]]; then $file; else echo "Done. Please read $file and run it if you approve."; fi
