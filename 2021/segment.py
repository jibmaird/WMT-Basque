#import nltk
#nltk.download()

from nltk.tokenize import sent_tokenize

data_d = "/Users/david/Projects/WMT-Basque/2021/Gaceta/txt2"

import glob, os
import itertools

os.chdir(data_d)
doc = 1

for file in glob.glob("*en.txt"):
    fp = open(data_d + "/" + file)
    text = fp.read()
    text = text.replace("Conclusions."," ")
    text = text.replace("Introduction."," ")
    text = text.replace("\n"," ")
    
    E = sent_tokenize(text)

    file2 = file.replace("en.txt","eu.txt")

    fp2 = open(data_d + "/" + file2)
    text = fp2.read()
    text = text.replace("Materiala eta metodoak."," ")
    text = text.replace("Konklusioak."," ")
    text = text.replace("Sarrera."," ")
    text = text.replace("Emaitzak."," ")
    text = text.replace("\- ","")
    
    text = text.replace("\n"," ")
    
    B = sent_tokenize(text)


    sent = 1
    for (s1,s2) in itertools.zip_longest(E,B):
        if s1 and s2:
            print("doc"+str(doc)+"\t"+str(sent)+"\t"+s1+"\t"+s2+"\t"+file2)
        elif s1:
            print("doc"+str(doc)+"\t"+str(sent)+"\t"+s1)
        else:
            print("doc"+str(doc)+"\t"+str(sent)+"\t"+"\t"+s2)
        sent = sent + 1

    doc = doc + 1
