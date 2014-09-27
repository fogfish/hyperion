## @author     Dmitry Kolesnikov, <dmkolesnikov@gmail.com>
## @copyright  (c) 2014 Dmitry Kolesnikov. All Rights Reserved
##
## @description
##   Erlang/OTP from scratch 
FROM centos:centos6
MAINTAINER Dmitry Kolesnikov <dmkolesnikov@gmail.com>

##
##
ENV VSN 17.3

##
## install dependencies
RUN \
   yum -y install \
      tar \
      gcc \
      git \
      glibc-devel \
      make \
      ncurses-devel \
      openssl-devel \
      openssl-static \
      autoconf

##
## download
RUN cd /tmp && \
   curl -O http://www.erlang.org/download/otp_src_${VSN}.tar.gz
RUN cd /tmp && \
   tar -zxvf otp_src_${VSN}.tar.gz

##
## configure
RUN cd /tmp/otp_src_${VSN} && \
   ./configure \
      --prefix=/usr/local/otp_${VSN} \
      --enable-threads \
      --enable-smp-support \
      --enable-kernel-poll \
      --enable-hipe \
      --enable-native-libs \
      --disable-dynamic-ssl-lib \
      --with-ssl=/usr \
      CFLAGS="-DOPENSSL_NO_EC=1"

##
## build
RUN cd /tmp/otp_src_${VSN} && \
   make && \
   make install && \
   ln -s /usr/local/otp_${VSN} /usr/local/otp

RUN rm -Rf /tmp/otp_src_${VSN}
RUN rm -f  /tmp/otp_src_${VSN}.tar.gz

ENV PATH $PATH:/usr/local/otp/bin

EXPOSE 4369
