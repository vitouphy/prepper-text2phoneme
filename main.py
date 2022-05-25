from src.text2phoneme import Text2Phoneme
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()
origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"text": "It's working"}

@app.get("/convert")
def convert_text2phoneme(text: str, breakdown: bool = True):
    result = Text2Phoneme().convert(text)

    response = {
        'phoneme': result['phoneme'],
        'text': text
    }
    if breakdown:
        response['breakdown'] = result['breakdown']
    return response
