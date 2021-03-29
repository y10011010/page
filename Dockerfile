FROM alpine:latest

RUN apk add git pass abook gnupg make gettext calcurse restic

WORKDIR /work

ARG git_user
ARG git_email
ARG passphrase
ARG restic_repository
ARG restic_password_command

ENV GIT_USER $git_user
ENV GIT_EMAIL $git_email
ENV PASSPHRASE $passphrase
ENV RESTIC_REPOSITORY $restic_repository
ENV RESTIC_PASSWORD_COMMAND $restic_password_command

RUN git config --global user.email $GIT_EMAIL
RUN git config --global user.user $GIT_USER

ENTRYPOINT ./start

