# Reference: https://docs.aws.amazon.com/lambda/latest/dg/images-create.html#images-create-from-base
FROM python:3.9-slim-buster

RUN apt-get -y update
RUN apt-get -y install espeak-ng

ARG FUNCTION_DIR="/function"
RUN mkdir -p ${FUNCTION_DIR}
COPY . ${FUNCTION_DIR}

# Set working directory to function root directory
WORKDIR ${FUNCTION_DIR}

# Install the runtime interface client
RUN pip install --target ${FUNCTION_DIR} awslambdaric 
RUN pip install --no-cache-dir --upgrade -r ${FUNCTION_DIR}/requirements_lambda.txt

# The most important line
ENTRYPOINT [ "/usr/local/bin/python", "-m", "awslambdaric" ]

CMD [ "app.handler" ]