#!/bin/bash
# Run this in the world's folder, same location as auth.txt.
# It finds any users who don't have interact (actually, who have the nointeract priv), and gives you a simple script to purge them from auth.txt
# Can automate running ./cleanplayers-destroy.sh after this executes, but by default it allows you to first review and edit before running it.
# The Minetest Server must NOT be running when you use this particular script since it makes changes to your auth.txt file.

# Enter an array of your exeptions (people to ignore). Case sensitive.
exceptions=(
  'RobbieF',
  'TenPlus1',
)

# 0 = no output, 1 = output
output=1

# 0 = do not auto-run, 1 = auto-run after completion
# Suggest you run it without auto-run first, review the script, and decide if you "trust" it before changing setting
autorun=0

file=cleanauth-interact-destroy.sh
echo '#!/bin/bash' > $file
echo "cp ./auth.txt auth.bak" >> $file

for player in `cat auth.txt`; do
   playername=${player%%:*}
   playerdata=${player#*:}
   if [[ $playerdata == *"nointeract"* ]]; then
     if [[ $output = 1 ]]; then printf "$playername does not haeve interact "; fi
     if [[ "${exceptions[@]}" =~ "${playername}" ]]; then
       if [[ $output = 1 ]]; then echo "but is in the exceptions list."; fi
     else
       if [[ $output = 1 ]]; then echo "and is not in the exceptions list."; fi
       echo "sed -i '/^$playername:/d' ./auth.txt" >> $file
     fi
   else
     if [[ $output = 1 ]]; then echo "$playername has interact."; fi
   fi

done

echo "echo Done. There is a backup auth.bak file, just in case." >> $file
echo "rm $file" >> $file
chmod +x $file
echo Done. Please read $file and run it if you approve.

if [[ $autorun = 1 ]]; then $file; else echo "Done. Please read $file and run it if you approve."; fi
