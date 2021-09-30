FROM python:3.9-alpine 
# Based on Python 3.9 alpine image which is a lightweight base image for running Python apps. 
# I pinned it to specific versions to improve stability and consistency

LABEL maintainer="Noob Master 69"

ENV PYTHONUNBUFFERED 1
# set PYTHONUNBUFFERED to 1 so that Python outputs are sent straight to the container logs

COPY ./requirements.txt /requirements.txt
COPY ./src_blog /src_blog
# Copies the the app/ directory and requirements.txt to the image

WORKDIR /src_blog
# Sets /src_blog as our working directory when running commands from the Docker image


# RUN python -m venv /venv 
# RUN /venv/bin/pip install --upgrade pip
# RUN /venv/bin/pip install -r /requirements.txt
# RUN adduser --disabled-password --no-create-home django-user

# Then we have a RUN line which is broken into multiple lines. This helps keep our image layers small, 
# because Docker creates a new layer for each line, but by formatting it like this only one line is created.



RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /requirements.txt && \
    adduser --disabled-password --no-create-home noobMaster_69

ENV PATH="/venv/bin:$PATH"
# Adds our /venv virtual environment to the PATH 
# (which means we can use it without specifying the full /py/bin/python path each time)

USER noobMaster_69
# Switch from root user to user we created