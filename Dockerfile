FROM python:3.6

ENV LADA_CONTAINER_HOME=/opt/lada

RUN mkdir $LADA_CONTAINER_HOME
RUN apt-get update && apt-get install -y binutils libproj-dev gdal-bin geoip-bin nginx

COPY . $LADA_CONTAINER_HOME
COPY requirements.txt $LADA_CONTAINER_HOME/requirements.txt
COPY ./requirements/ $LADA_CONTAINER_HOME/requirements/

ENTRYPOINT ["/docker-entrypoint.sh"]
