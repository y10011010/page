FROM alpine:latest

RUN apk add git pass abook gnupg make calcurse

WORKDIR /work

ARG git_user
ARG git_email

ENV GIT_USER $git_user
ENV GIT_EMAIL $git_email

RUN git config --global user.email $GIT_EMAIL
RUN git config --global user.user $GIT_USER
CMD bash

