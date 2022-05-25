from phonemizer.backend import EspeakBackend
from phonemizer.punctuation import Punctuation
from phonemizer.separator import Separator

class Text2Phoneme(object):
    _instance = None
    _backend = None
    _separator = None 
    _punctuation = None 

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(Text2Phoneme, cls).__new__(cls)
        return cls._instance

    def __init__(self):
        self._backend = EspeakBackend('en-us')
        self._separator = Separator(phone=' ', word=None)
        self._punctuation = Punctuation(';:,.!"?()-')

    def convert(self, text: str):
        phonemes = self._backend.phonemize(text.split(), separator=self._separator, strip=True)
        phonemes = [ "".join(phoneme.split()) for phoneme in phonemes ]
        result = " ".join(phonemes) 
        breakdown = list(zip(text.split(), phonemes))

        return {
            "phoneme": result,
            "breakdown": breakdown
        }






