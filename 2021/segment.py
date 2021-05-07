from nltk.tokenize import sent_tokenize

fp = open("/Users/david/Projects/WMT-Basque/2021/Gaceta/686-1016-1-SM-en.txt")
text = fp.read()
print(sent_tokenize(text))
