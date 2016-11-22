FROM ubuntu:16.04
MAINTAINER Hyunuk Kim <nnhope@hotmail.com>

# basic install
RUN apt-get update
RUN apt-get install -y \
	build-essential \
	autoconf \
	libncurses5-dev \
	unixodbc-dev \
	libssh-dev \
	wget

# build erlang
RUN mkdir -p ~/src/erlang
RUN cd ~/src/erlang && wget http://www.erlang.org/download/otp_src_17.1.tar.gz
RUN cd ~/src/erlang && tar -xvzf otp_src_17.1.tar.gz
RUN cd ~/src/erlang && chmod -R 777 otp_src_17.1
RUN cd ~/src/erlang/otp_src_17.1 && ./configure
RUN cd ~/src/erlang/otp_src_17.1 && make
RUN cd ~/src/erlang/otp_src_17.1 && make install


# build ejabberd
RUN apt-get install -y \
	libyaml-dev \
	libexpat1 \
	libexpat1-dev \
	sqlite3 \
	libsqlite3-dev \
	libpam0g-dev \
	git

RUN cd ~/src/ && git clone git://github.com/processone/ejabberd.git
RUN cd ~/src/ejabberd && ./autogen.sh
RUN cd ~/src/ejabberd && ./configure --enable-all
RUN cd ~/src/ejabberd && make install

EXPOSE 5222 
EXPOSE 5223
EXPOSE 5280

