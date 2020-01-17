FROM ubuntu:18.04

MAINTAINER Bastien Roussel, <bastien.roussel@msbytes.com>

RUN apt update \
    && apt upgrade -y \
    && apt -y install curl software-properties-common locales git \
    && add-apt-repository ppa:deadsnakes/ppa
    && useradd -d /home/container -m container

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

    # NodeJS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt -y install nodejs

    # PHP 7.2 (For web interface or other shit...)
RUN add-apt-repository -y ppa:ondrej/php \
    && apt update \
    && apt -y install php7.2 php7.2-cli php7.2-gd php7.2-mysql php7.2-pdo php7.2-mbstring php7.2-tokenizer php7.2-bcmath php7.2-xml php7.2-fpm php7.2-curl php7.2-zip

    # Last JDK
RUN apt -y install default-jdk

    # Python
RUN apt -y install python3.8 python3.8-dev python3.8-venv python3-pip git default-jre-headless \
    && build-essential \
    && curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash \
    && CONFIGURE_OPTS=--enable-optimizations pyenv install 3.8.1 -v \
    && pyenv global 3.8.1

    # C Sharp & .NET 
RUN apt -y install mono-runtime

    # Lua 5.3
RUN apt -y install lua5.3

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
