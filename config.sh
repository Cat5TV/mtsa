#!/bin/bash
# Config file. You'll need to edit this to suit your setup.

# Linux Username, must be hard set, eg., robbie
# This prevents conflicts in a multi-user Minetest hosting environment
# This needs to MATCH the Linux username, but cannot be created with
# `whoami` due to the script being run as root.
mtuser=robbie

# Minetest game folder, eg., /home/robbie/minetest
mtgame=/home/robbie/minetest

# Minetest mod folder, eg., /home/robbie/.minetest/mods
mtmod=/home/robbie/.minetest/mods

# Where to save your backups, eg., /home/robbie/backups
mtbackup=/home/robbie/backups

# Minetest hard drive, eg., /dev/sda
mtdev=/dev/sda

# Minetest log folder, eg., /home/robbie/logs
mtlogs=/home/robbie/logs

# Minetest world base folder, eg., for /home/robbie/maps/myworld this would be /home/robbie/maps
mtmaps=/home/robbie/maps

# Minetest configuration file folder, eg., /home/robbie/conf
mtconf=/home/robbie/conf
