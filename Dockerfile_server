FROM python:3.9-slim-buster

WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
COPY . /app

RUN apt-get -y update
RUN apt-get -y install espeak-ng
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
