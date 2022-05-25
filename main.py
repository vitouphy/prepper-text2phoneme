from src.text2phoneme import Text2Phoneme
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"text": "It's working"}

@app.get("/convert")
def convert_text2phoneme(text: str):
    result = Text2Phoneme().convert(text)
    return {
        "text": result,
        "source_text": text
    }
