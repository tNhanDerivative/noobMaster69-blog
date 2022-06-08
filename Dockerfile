FROM python:3.9-alpine 
# Based on Python 3.9 alpine image which is a lightweight base image for running Python apps. 
# I pinned it to specific versions to improve stability and consistency

LABEL maintainer="Noob Master 69"

# set PYTHONUNBUFFERED to 1 so that Python outputs are sent straight to the container logs
ENV PYTHONUNBUFFERED 1

# Sets /blogApp as our working directory when running commands from the Docker image
RUN mkdir /blogApp
COPY ./src_blog /blogApp
WORKDIR /blogApp

COPY ./requirements.txt ./requirements.txt
# These ar package are required in Alpine to install uWSGI server
RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers


# Adds our /venv/in virtual environment to the PATH 
# (which means we can use it without specifying the full /py/bin/python path each time)
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"
RUN pip install -r /requirements.txt && \
    apk del .tmp


COPY ./scripts /scripts
ENV PATH="/scripts:$PATH"


# create folder for static file => add user => change user of vol file from root to user
RUN mkdir -p /vol/web/media && \
    mkdir -p /vol/web/static && \
    adduser -D user && \
    chown -R user:user /vol && \
    chmod -R 755 /vol && \
    chmod +x /scripts/

USER user

EXPOSE 8000


CMD ["entrypoint.sh"]   

 






# Then we have a RUN line which is broken into multiple lines. This helps keep our image layers small, 
# because Docker creates a new layer for each line, but by formatting it like this only one line is created.



# RUN python -m venv /venv && \
#     /venv/bin/pip install --upgrade pip && \
#     apk add --update --no-cache postgresql-client && \
#     apk add --update --no-cache --virtual .tmp-deps \
#         build-base postgresql-dev musl-dev linux-headers && \
#     /venv/bin/pip install -r /requirements.txt && \
#     apk del .tmp-deps && \
#     adduser --disabled-password --no-create-home blogApp && \
#     mkdir -p /vol/web/staticfiles && \
#     mkdir -p /vol/web/mediafiles && \
#     chown -R blogApp:blogApp /vol && \
#     chmod -R 755 /vol && \
#     chmod -R +x /scripts
    


