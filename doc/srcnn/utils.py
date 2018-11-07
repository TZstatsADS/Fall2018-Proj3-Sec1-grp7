import os
import re

def eachFile(folder):
    allFile = os.listdir(folder)
    fileNames = []
    for file in allFile:
        fullPath = os.path.join(folder, file)
        fileNames.append(fullPath)

    return fileNames


def changeFileName(oldFileName, newFileName):
    try:
        os.rename(oldFileName, newFileName)
    except:
        print('an error occurred')


def deleteFile(filePath):
    if os.path.isfile(filePath):
        try:
            os.remove(filePath)
        except:
            print('remove error')


def deleteGif(folderPath):
    fileNames = eachFile(folderPath)
    for fileName in fileNames:
        a = re.findall('.gif', fileName)
        if(a != []):
            print(fileName)
            deleteFile(fileName)


if __name__ == '__main__':
    folderPath = 'C:/Users/ren_g/Documents/GitHub/Fall2018-Proj3-Sec1-grp7/data/train_set/HR'
    deleteGif(folderPath)