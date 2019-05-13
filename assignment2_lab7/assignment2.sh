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

echo ""
echo "Can I add a new entry for the GRUB? (yes or no)"
read answer

case $answer in

	yes | YES | Y | y)

	sudo echo "
	menuentry 'Ubuntu Mini ' {

	set isofile="~/ubuntum.iso"

	loopback loop (hd0,msdos1)$isofile

	linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=$isofile noprompt noeject

	initrd (loop)/casper/initrd.lz

	}">>/etc/grub.d/40_custom

	echo "I added a new entry for the GRUB"
	;;

	*)
	echo "Okey, see you!"
	exit
	;;

esac


if [ ! ~/ubuntum.iso ]; then

	echo ""
	echo "To complete the task, I want to download the ISO file; Ubuntu 18.04 'Bionic Beaver' (64MB)"
	echo "Do you give me the permission? (yes or no)"
	read ANSWER
	
	case $ANSWER in
	
		yes | YES | Y | y)
	
			echo "Your system is 64 bits or 32 bits?"
				read sys
	
				case $sys in
	
					64)
						wget -O ~/ubuntum.iso "archive.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/current/images/netboot/mini.iso"
						;;
					32)
						wget -O ~/ubuntum.iso "archive.ubuntu.com/ubuntu/dists/bionic/main/installer-i386/current/images/netboot/mini.iso"
						;;
					*)
						echo "You had to write 64 or 32"
						echo "I will update GRUB and exit"
						sudo update-grub
						exit
						;;
				esac
		;;
	
		*)
			echo "I can not continue. Try again if you change your decision."
			echo "I will update GRUB and exit"
			sudo update-grub
			exit
			;;
	esac
fi

sudo update-grub






