#!/bin/bash
# Minetest Server Admin for Linux
# By Robbie Ferguson - https://minetest.tv
# ----------------------------------------
# Dependency Check

# Set depends array first. This is not meant to be called manually. This script is used in other scripts.

  # Check for, install, and verify dependencies
  if [ $(command -v yum) ]; then
    PACMAN="$(command -v yum) --y install "
  fi
  if [ $(command -v apt-get) ]; then
    PACMAN="$(command -v apt-get) --allow-unauthenticated --yes install "
  fi

    for i in "${depends[@]}"
      do
          echo Testing dependency \"$i\"...
          if [ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 0 ] && [ $(rpm -qa 2>/dev/null | grep -c $i) -eq 0 ]; then
              echo "Not installed. Installing $i..."
              $PACMAN $i
              if [ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 0 ] && [ $(rpm -qa 2>/dev/null | grep -c $i) -eq 0 ]; then
                echo "Installation of $i failed. Please install it manually and run this script again."
                exit 1;
              else
                echo "$i was successfully installed."
              fi
          else
            echo "$i is installed. Proceeding."
          fi
      done
