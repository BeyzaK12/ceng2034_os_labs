#!/bin/bash

loc=$(pwd)	#it will use later for copying x1.sh file


#this bash script can run multiple times in the same location
if [ ! -f ~/myRoot/bin/bash ] || [ ! -d ~/myRoot/lib ] || [ ! -d ~/myRoot/lib64 ] ; then

	#create the jail directories
	mkdir ~/myRoot
	cd ~/myRoot
	mkdir bin lib lib64

	#clone the original system
	cp /bin/bash ~/myRoot/bin

	var=$(ldd /bin/bash)
	cp $var ~/myRoot/lib
	clear
	mv ~/myRoot/lib/ld-linux-x86-64.so.2 ~/myRoot/lib64

fi

#copy the bash script for running in the chroot jail
cp $loc/x1.sh ~/myRoot


#chroot
<<<<<<< HEAD
sudo chroot ~/myRoot /bin/bash ./x1.sh
=======
>>>>>>> d11fed8c6aa9e226eb90335fa8fc3a0cf9514fa2
sudo chroot ~/myRoot /bin/bash







<<<<<<< HEAD
=======

>>>>>>> d11fed8c6aa9e226eb90335fa8fc3a0cf9514fa2
