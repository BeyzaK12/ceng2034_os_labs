#!/bin/bash

cont=$(pwd)

if [ $cont = / ]; then
	echo "
	  --- You are root! ---"
fi

echo "
The bash script is running in the chroot jail!
        Because it is in the chroot."
