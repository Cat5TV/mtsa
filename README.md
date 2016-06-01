# MTSA
Minetest Server Admin for Linux

Many of these tools can be used or adapted for other purposes. However the purpose of this repository is to provide a well-needed Server Admin system for Minetest.

### flushcache.sh
#### Disk Cache Safe Flush Utility
It's a good idea to run a lot of your minetestserver game in memory. Doing so extends the life of your media and improves performance. However, it could also lead to data loss if data is not saved to disk upon Minetest crashing or before a server reboot. flushcache.sh works with MTSA to safely move all cached data from memory to the physical disk.
