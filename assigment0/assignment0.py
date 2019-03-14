import os
import stat
import time

#to learn user name for home path
#user=os.popen("whoami").read()
#os.chdir('/home/'+user.strip())

#go to home directory
os.chdir(os.path.expanduser("~"))

#control and create a folder
if os.path.exists("os_lab_0") == 1 & os.path.isdir("os_lab_0") == 1:
    os.chdir('os_lab_0')
else:
    os.mkdir("os_lab_0")
    os.chdir('os_lab_0')

#create files
os.system("touch ex1.txt ex2.txt ex3.py")
#system is shorter for creating more files then mknod
#os.mknod("ex1.txt")
#os.mknod("ex2.txt")
#os.mknod("ex3.py")

#print all files last modified date
for i in os.listdir("."):

    #print(os.path.getmtime(i))
    fileStat = os.stat(i)
    modificationTime = time.ctime ( fileStat [ stat.ST_MTIME ] )
    print("Last modified time for " + i + " : ", modificationTime )

#find .txt files and print
for i in os.listdir("."):
    if os.path.splitext(i)[1] == ".txt" :
        print("I found a txt file! It is " + i)




