# FROM python:3.9-slim-buster as builder 

# RUN apt-get -y update
# RUN apt-get -y install espeak-ng

# # ==================

# FROM public.ecr.aws/lambda/python:3.9

# COPY --from=builder /usr/bin/espeak-ng /usr/bin/espeak-ng
# COPY --from=builder /usr/bin/speak-ng /usr/bin/speak-ng

# COPY ./requirements_lambda.txt ./requirements.txt
# RUN pip install --no-cache-dir --upgrade -r ./requirements.txt

# COPY ./src ${LAMBDA_TASK_ROOT}/src
# COPY ./app.py ${LAMBDA_TASK_ROOT}

# CMD ["app.handler"]






# FROM python:3.9-slim-buster

# ENV PATH=/var/lang/bin:/usr/local/bin:/usr/bin/:/bin:/opt/bin:/var/task
# ENV LAMBDA_TASK_ROOT=/var/task

# WORKDIR /var/task

# RUN apt-get -y update
# RUN apt-get -y install espeak-ng

# COPY ./requirements_lambda.txt ./requirements.txt
# RUN pip install --no-cache-dir --upgrade -r ./requirements.txt

# COPY ./src ${LAMBDA_TASK_ROOT}/src
# COPY ./app.py ${LAMBDA_TASK_ROOT}

# COPY ./lambda-entrypoint.sh ${LAMBDA_TASK_ROOT}
# COPY bootstrap /var/runtime/bootstrap

# ENTRYPOINT ["lambda-entrypoint.sh"]
# CMD ["app.handler"]




# FROM amazon/aws-lambda-provided:latest

# RUN yum -y upgrade 
# RUN yum -y install espeak-ng

# COPY bootstrap /var/runtime/bootstrap
# RUN chmod 755 /var/runtime/bootstrap

# COPY ./requirements_lambda.txt ./requirements.txt
# RUN pip install --no-cache-dir --upgrade -r ./requirements.txt

# COPY ./src ${LAMBDA_TASK_ROOT}/src
# COPY ./app.py ${LAMBDA_TASK_ROOT}

# CMD [ "app.handler" ]







# # Define function directory
# ARG FUNCTION_DIR="/function"

# FROM python:buster as build-image

# # Install aws-lambda-cpp build dependencies
# RUN apt-get update && \
#   apt-get install -y \
#   g++ \
#   make \
#   cmake \
#   unzip \
#   libcurl4-openssl-dev

# # Include global arg in this stage of the build
# ARG FUNCTION_DIR
# # Create function directory
# RUN mkdir -p ${FUNCTION_DIR}

# # Copy function code
# # COPY app/* ${FUNCTION_DIR}
# COPY . ${FUNCTION_DIR}

# # Install the runtime interface client
# RUN pip install \
#         --target ${FUNCTION_DIR} \
#         awslambdaric

# # Multi-stage build: grab a fresh copy of the base image
# FROM python:buster

# RUN apt-get -y update
# RUN apt-get -y install espeak-ng

# # Include global arg in this stage of the build
# ARG FUNCTION_DIR
# # Set working directory to function root directory
# WORKDIR ${FUNCTION_DIR}

# # Copy in the build image dependencies
# COPY --from=build-image ${FUNCTION_DIR} ${FUNCTION_DIR}
# RUN pip install --no-cache-dir --upgrade -r ${FUNCTION_DIR}/requirements_lambda.txt

# ENTRYPOINT [ "/usr/local/bin/python", "-m", "awslambdaric" ]
# CMD [ "app.handler" ]
        





# ARG FUNCTION_DIR="/function"

# FROM python:3.9-slim-buster

# ARG FUNCTION_DIR
# RUN mkdir -p ${FUNCTION_DIR}

# COPY . ${FUNCTION_DIR}

# # Install the runtime interface client
# RUN pip install \
#         --target ${FUNCTION_DIR} \
#         awslambdaric

# RUN apt-get -y update
# RUN apt-get -y install espeak-ng

# # Set working directory to function root directory
# WORKDIR ${FUNCTION_DIR}

# RUN pip install --no-cache-dir --upgrade -r ${FUNCTION_DIR}/requirements_lambda.txt

# ENTRYPOINT [ "/usr/local/bin/python", "-m", "awslambdaric" ]
# CMD [ "app.handler" ]




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

ENTRYPOINT [ "/usr/local/bin/python", "-m", "awslambdaric" ]
CMD [ "app.handler" ]