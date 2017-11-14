FROM python:3.6

ENV LADA_CONTAINER_HOME=/opt/lada

RUN mkdir $LADA_CONTAINER_HOME

COPY . $LADA_CONTAINER_HOME
COPY ./requirements/ $LADA_CONTAINER_HOME/requirements/

ENTRYPOINT ["/docker-entrypoint.sh"]
