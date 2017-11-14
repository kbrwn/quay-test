FROM python:3.6

RUN mkdir lch

COPY . lch
COPY requirements.txt lch/requirements.txt
COPY ./requirements/ lch/requirements/

ENTRYPOINT ["/docker-entrypoint.sh"]
