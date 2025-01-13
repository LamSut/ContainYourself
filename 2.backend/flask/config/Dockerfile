FROM python:3.12-slim

ADD . /flask_app
WORKDIR /flask_app

# install virtualenv and set up a virtual environment
RUN python3 -m venv venv
RUN ./venv/bin/pip install --upgrade pip
RUN ./venv/bin/pip install -r requirements.txt

# use the virtual environment to run your application
ENTRYPOINT ["./venv/bin/python"]
CMD ["flask_docker.py"]

## Debian ##
# FROM ubuntu:latest
# MAINTAINER Tuan Thai "tuanthai@example.com"
# RUN apt update -y
# RUN apt install -y python3-pip python3-dev build-essential
# ADD . /flask_app
# WORKDIR /flask_app
# RUN pip3 install -r requirements.txt
# ENTRYPOINT ["python3"]
# CMD ["flask_docker.py"]


