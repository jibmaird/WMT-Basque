import sys
from nltk.tokenize import sent_tokenize, word_tokenize

reference = sys.argv[1]
candidate = sys.argv[2]

ref_tokens = word_tokenize(reference)
cand_tokens = word_tokenize(candidate)

#reference = [['this', 'is', 'a', 'test'], ['this', 'is' 'test']]
#candidate = ['this', 'is', 'another', 'test']
score = sentence_bleu(reference, candidate)
print(score)
