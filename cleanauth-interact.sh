#!/bin/bash
# Run this in the world's folder, same location as auth.txt.
# It finds any users who don't have interact (actually, who have the nointeract priv), and gives you a simple script to purge them from auth.txt
# Can automate running ./cleanplayers-destroy.sh after this executes, but by default it allows you to first review and edit before running it.

# Enter an array of your exeptions (people to ignore). Case sensitive.
exceptions=(
  'RobbieF',
  'TenPlus1',
)


file=./cleanauth-interact-destroy.sh
echo '#!/bin/bash' > $file
echo "cp ./auth.txt auth.bak" >> $file

for player in `cat auth.txt`; do
   playername=${player%%:*}
   playerdata=${player#*:}
   if [[ $playerdata == *"nointeract"* ]]; then
     printf "$playername does not have interact ";
     if [[ "${exceptions[@]}" =~ "${playername}" ]]; then
       echo "but is in the exceptions list."
     else
       echo "and is not in the exceptions list."
       echo "sed -i '/^$playername:/d' ./auth.txt" >> $file
     fi
   else
     echo "$playername has interact.";
   fi

done
exit
echo "echo Done. There is a backup auth.bak file, just in case." >> $file
echo "rm $file" >> $file
chmod +x $file
echo Done. Please read $file and run it if you approve.

# Uncomment this if you want it to run automatically:
# $file
