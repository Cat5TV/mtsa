#!/bin/bash
  source inc/systemconf.sh
  source config.sh

  # Specify dependencies
  declare -a depends=("tar")

  echo "Minetest Server Admin for Linux"
  echo "By Robbie Ferguson - https://minetest.tv"
  echo "----------------------------------------"
  echo "Build minetestserver from Source $ver"
  echo "Automatically build the most recent version of Minetest for servers"
  echo ""

if [[ $EUID -ne 0 ]]; then
  echo "ERROR: You must be a root" 2>&1
  exit 1
else
  BASEDIR=$(dirname "$0")
  
  source ./inc/check-depends.sh

  if [ "$(pidof minetestserver)" ] 
  then
    # Minetest is running
    $BASEDIR/stop-minetest.sh
  fi

	echo INSTALLING MINETEST
	apt-get -y install build-essential cmake git libirrlicht-dev libbz2-dev libgettextpo-dev libfreetype6-dev libpng12-dev libjpeg62-turbo-dev libxxf86vm-dev libgl1-mesa-dev libsqlite3-dev libogg-dev libvorbis-dev libopenal-dev libhiredis-dev libcurl3-dev unzip

# Keep two days worth just for FAST recovery in case of issue
  rm -rf $mtgame~~
  # 2 days ago
  mv $mtgame~ $mtgame~~
  # yesterday
  mv $mtgame $mtgame~

	# Required for removal of dependency on X
	cd /tmp
	mkdir $mtuser
	chown $mtuser:$mtuser $mtuser
	cd $mtuser
	mkdir irrlicht
	cd irrlicht
	wget http://downloads.sourceforge.net/irrlicht/irrlicht-1.8.3.zip
	unzip irrlicht-1.8.3.zip

	cd /tmp/$mtuser
	su $mtuser -c 'git clone https://github.com/minetest/minetest.git'
	cd minetest/

	cd games/
	su $mtuser -c 'git clone https://github.com/minetest/minetest_game.git'
	cd ../

	# Apply any patches you need


	###

	# Compile
	cmake . -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LEVELDB=1 -DENABLE_REDIS=1 -DBUILD_CLIENT=0 -DCMAKE_BUILD_TYPE=Release -DIRRLICHT_SOURCE_DIR=/tmp/$mtuser/irrlicht/irrlicht-1.8.3
	make -j$(grep -c processor /proc/cpuinfo)

	# Move to the correct location
	mv /tmp/$mtuser/minetest/ $mtgame

	# Keep your customizations in a folder and restore automatically with something like this:
	#cp -R /home/robbie/custom/games/* $mtgame/games/

	chown -R $mtuser:$mtuser $mtgame/

fi
