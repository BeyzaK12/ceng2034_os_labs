import os
import binascii
import time
import os.path
import shutil
import threading

start = time.time()

# magic numbers
jpg = "ffd8ffe0"
png = "89504e470d0a1a0a"
mp3 = "494433"

def makeDir(name):
    try:
        os.mkdir(name)
    finally:
        return

def prepare():
    makeDir("jpgFolderM")
    makeDir("pngFolderM")
    makeDir("mp3FolderM")
    makeDir("txtFolderM")


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
tr1 = threading.Thread(target=main, args=(1, 50))
tr2 = threading.Thread(target=main, args=(50, 100))
tr3 = threading.Thread(target=main, args=(100, 150))

tr1.start()
tr2.start()
tr3.start()

tr1.join()
tr2.join()
tr3.join()


print(str(time.time() - start) + " seconds for MULTIthreading")
