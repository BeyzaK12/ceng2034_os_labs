import os
import binascii
import time
import os.path
import shutil

start = time.time()

#magic numbers
jpg = "ffd8ffe0"
png = "89504e470d0a1a0a"
mp3 = "494433"

def makeDir(name):
    try:
        os.mkdir(name)
    finally:
        return

def prepare():
    makeDir("jpgFolder")
    makeDir("pngFolder")
    makeDir("mp3Folder")
    makeDir("txtFolder")

def main(st, end):
    folder = "files/"

    for i in range(st, end):

        file = "file" + str(i)

        if not os.path.exists(folder+file):
            continue

        with open(folder + file, "rb") as filex:

            header = filex.read(8)
            header = str(binascii.hexlify(header))[2:-1]

            if header.startswith(jpg):
                shutil.copy(folder + file, "jpgFolder/" + file)
            elif header.startswith(png):
                shutil.copy(folder + file, "pngFolder/" + file)
            elif header.startswith(mp3):
                shutil.copy(folder + file, "mp3Folder/" + file)
            else:
                shutil.copy(folder + file, "txtFolder/" + file)

prepare()
main(1,150)

print(str(time.time() - start) + " seconds for SINGLE threading")
