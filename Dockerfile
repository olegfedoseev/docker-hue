FROM ubuntu:trusty

RUN apt-get update -y && \
    apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && \
    apt-get update -y && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer

RUN apt-get update -y && apt-get install --fix-missing -q -y \
    git ant gcc g++ make maven python-dev python-setuptools \
    libkrb5-dev \
    libmysqlclient-dev \
    libssl-dev \
    libsasl2-dev \
    libsasl2-modules-gssapi-mit \
    libsqlite3-dev \
    libtidy-0.99-0 \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
    libldap2-dev \
    libgmp3-dev \
    libz-dev && \
    git clone https://github.com/cloudera/hue.git /hue && cd /hue && make apps && \
    apt-get remove -y ant gcc g++ make maven python-setuptools python-dev && \
    apt-get autoremove -y && rm -rf /hue/.git /var/cache/*

EXPOSE 8888
VOLUME /hue/desktop/

CMD ["/hue/build/env/bin/hue", "runserver_plus", "0.0.0.0:8888"]

