FROM amd64/ubuntu:22.04

ARG DUCKDB_VERSION

# steps copied from github.com/duckdb/duckdb/tree/master/.github/actions/ubuntu_16_setup/action.yml
RUN apt-get update -y -qq
RUN apt-get install -y -qq software-properties-common
RUN add-apt-repository ppa:git-core/ppa
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get update -y -qq

RUN apt-get install -y -qq ninja-build make wget curl zip unzip libz-dev openssh-client
RUN apt-get install -y -qq libssl-dev openjdk-8-jdk maven unixodbc-dev libcurl4-gnutls-dev
RUN apt-get install -y -qq libexpat1-dev gettext build-essential checkinstall libffi-dev
RUN apt-get install -y gcc-multilib g++-multilib libc6-dev-i386 lib32readline6-dev
RUN apt-get install -y zlib1g-dev

RUN apt-get install -y python3.7

RUN wget https://github.com/git/git/archive/refs/tags/v2.18.5.tar.gz && \
    tar xvf v2.18.5.tar.gz && \
    cd git-2.18.5 && \
    make && \
    make prefix=/usr install && \
    git --version

RUN wget -O cmake.sh https://github.com/Kitware/CMake/releases/download/v3.24.0/cmake-3.24.0-linux-x86_64.sh && \
    sh ./cmake.sh --prefix=/usr/ --skip-license

RUN wget https://github.com/duckdb/duckdb/releases/download/${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip && \
    unzip duckdb_cli-linux-amd64.zip -d /usr/local/bin && \
    rm duckdb_cli-linux-amd64.zip

CMD [ "duckdb", "--version"]