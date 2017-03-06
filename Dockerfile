FROM golang:1.7
MAINTAINER Christian Renz <crenz@web42.com>


RUN apt-get update && apt-get install -y --no-install-recommends \
		cmake \
        libssl-dev \
        libsasl2-2 libsasl2-dev libsasl2-modules-db \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /temp

RUN wget https://github.com/apache/qpid-proton/archive/0.17.0.tar.gz
RUN tar xzf 0.17.0.tar.gz && rm 0.17.0.tar.gz

WORKDIR /temp/qpid-proton-0.17.0/build

RUN cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DSYSINSTALL_BINDINGS=ON -DBUILD_PERL=OFF -DBUILD_PHP=OFF -DBUILD_PYTHON=OFF -DBUILD_RUBY=OFF
RUN make install

RUN go get -t -v qpid.apache.org/electron

RUN rm -rf /temp
