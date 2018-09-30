FROM python:3.6-alpine

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY Pipfile /usr/src/app

RUN apk update --no-cache \
  && apk add --virtual build-tools gcc python3-dev musl-dev \
  && apk add postgresql-dev \
  && pip install pipenv \
  && pipenv lock --pre \
  && pipenv install --system --deploy \
  && apk del build-tools

COPY . /usr/src/app/
