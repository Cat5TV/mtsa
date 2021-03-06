# MTSA
Minetest Server Admin for Linux

Many of these tools can be used or adapted for other purposes. However the purpose of this repository is to provide a well-needed Server Admin system for Minetest.

### config.sh
#### Your server's configuration
Setup the variables for your server here. This file shares that information, such as location of your Minetest maps, with all the scripts.

### flushcache.sh
#### Disk Cache Safe Flush Utility
It's a good idea to run a lot of your minetestserver game in memory. Doing so extends the life of your media and improves performance. However, it could also lead to data loss if data is not saved to disk upon Minetest crashing or before a server reboot. flushcache.sh works with MTSA to safely move all cached data from memory to the physical disk.

### logroll.sh
#### Rollover daily log files

### loadserver.sh
#### An intelligent multi-user, multi-world minetestserver loader script

### build-minetest.sh
#### Automatically build the most recent version of Minetest optimized exclusively for servers

### stop-minetest.sh
#### Safely shutdown all minetestserver instances for this user
What better way to reduce the performance hit of constant map writes on your disk than to instead cache everything to memory. But the catch there is if the server crashes or you have to kill it forcibly, you'll lose the loaded chunks. No more! stop-minetest.sh from MTSA utilizes our flushcache.sh script and performs a safe shutdown of all loaded minetestserver instances based on their pid for the running user.

### cleanauth-interact.sh
#### Remove players from auth.txt that don't have interact
Run this in the world's folder, same location as auth.txt.
It finds any users who don't have interact (actually, who have the nointeract priv), and gives you a simple script to purge them from auth.txt

### cleanauth.sh
#### Removes players/ file if the player doesn't exist in auth.txt
Run this in the world's folder, same location as auth.txt.
It finds any users who don't actually exist in auth.txt, and gives you a simple script to purge them from auth.txt

### To Do
- write a bash script to create worlds, requesting seed (or generating randomly) and so-on
