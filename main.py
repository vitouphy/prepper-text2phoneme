from typing import Union
from fastapi import FastAPI
from phonemizer.backend import EspeakBackend
from phonemizer.punctuation import Punctuation
from phonemizer.separator import Separator

# Initialize fastapi server
app = FastAPI()
# initialize the espeak backend for English
backend = EspeakBackend('en-us')
# separate phones by a space and ignoring words boundaries
separator = Separator(phone=' ', word=None)

@app.get("/")
def read_root():
    return {"text": "It's working"}

@app.get("/convert")
def convert_text2phoneme(text: str):
    text = Punctuation(';:,.!"?()-').remove(text)
    phonemes = backend.phonemize(text.split(), separator=separator, strip=True)
    phonemes = ["".join(phoneme.split()) for phoneme in phonemes]
    result = " ".join(phonemes) 
        
    return {
        "text": result,
        "source_text": text
    }
