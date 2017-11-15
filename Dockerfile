FROM alpine

RUN mkdir lch

COPY . lch/
COPY requirements.txt lch/requirements.txt
COPY ./requirements/ lch/requirements/

ENTRYPOINT ["/docker-entrypoint.sh"]
