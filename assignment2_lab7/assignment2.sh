#!/bin/bash

#Read your MBR and write it into a file

if [ -b /dev/hda ]; then
	key='hda'
else
	key='sda'
fi

sudo echo "Your MBR:"
sudo hd -n 512 /dev/$key
echo ""

if [ ! -f ~/myMBR.txt ]; then

	sudo hd -n 512 /dev/$key &> ~/myMBR.txt
	echo "Your MBR has been written to myMBR.txt in the home directory."

elif [ ! -f ~/myMBRx.txt ]; then
	
	echo "There is a file by name myMBR.txt in your home directory."
	sudo hd -n 512 /dev/$key &> ~/myMBRx.txt
	echo "Your MBR has been written to myMBRx.txt in the home directory."

else

	echo "There are files by names 'myMBR.txt' and 'myMBRx.txt'."
	echo "If your MBR is not in one of them, change the name of one or delete the file."
	exit

fi


#Enter a new entry in GRUB with an iso under your home directory

if [ ! ~/alpine.iso ]; then

	echo ""
	echo "For next step, I want to download the ISO file; Alpine Standard x86"
	echo "Do you give me the permission? (yes or no)"
	read ANSWER
	
	case $ANSWER in
	
		yes | YES | Y | y)
	
			echo "Your system is 64 bits or 32 bits?"
				read sys
	
				case $sys in
	
					64)
						wget -O ~/alpine.iso "dl-cdn.alpinelinux.org/alpine/v3.9/releases/x86_64/alpine-standard-3.9.4-x86_64.iso"
						;;
					32)
						wget -O ~/alpine.iso "dl-cdn.alpinelinux.org/alpine/v3.9/releases/x86/alpine-standard-3.9.4-x86.iso"
						;;
					*)
						echo "You had to write 64 or 32."
						exit
						;;
				esac
		;;
	
		*)
			echo "I can not continue. Try again if you change your decision."
			exit
			;;
	esac
fi

