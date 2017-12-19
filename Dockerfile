FROM quay.io/willtester/jumboimg
ENV PYTHONUNBUFFERED 1 
RUN apt-get update && apt-get install -y \ 
libmemcached-dev \ 
python-dev \ 
libffi-dev \ 
libxml2-dev \ 
libxslt1-dev \ 
libtool \ 
ncurses-dev \ 
nodejs 
RUN mkdir /code 
WORKDIR /code 
COPY requirements.txt /code/ 
RUN pip install -r requirements.txt

COPY . /code/ 
EXPOSE 8000


