FROM python:3.6

ENV PYTHONUNBUFFERED 1
ENV LADA_CONTAINER_HOME=/opt/lada
ENV LADA_STATIC=static

RUN mkdir $LADA_CONTAINER_HOME
RUN apt-get update && apt-get install -y binutils libproj-dev gdal-bin geoip-bin nginx

COPY . $LADA_CONTAINER_HOME
COPY requirements.txt $LADA_CONTAINER_HOME/requirements.txt
COPY ./requirements/ $LADA_CONTAINER_HOME/requirements/

RUN pip3 install --no-cache-dir -r $LADA_CONTAINER_HOME/requirements.txt

COPY ./docker-entrypoint.sh /

EXPOSE 8000
COPY ./config/nginx/lada_django.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/lada_django.conf /etc/nginx/sites-enabled
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

WORKDIR $LADA_CONTAINER_HOME

ENTRYPOINT ["/docker-entrypoint.sh"]
