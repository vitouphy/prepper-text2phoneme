from phonemizer.backend import EspeakBackend
from phonemizer.punctuation import Punctuation
from phonemizer.separator import Separator

# remove all the punctuation from the text, considering only the specified
# punctuation marks
text = "hello world"
text = Punctuation(';:,.!"?()-').remove(text)

# initialize the espeak backend for English
backend = EspeakBackend('en-us')

# separate phones by a space and ignoring words boundaries
separator = Separator(phone=' ', word=None)

phonemes = backend.phonemize(text.split(), separator=separator, strip=True)

print(" ".join(phonemes))