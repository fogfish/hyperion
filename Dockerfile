## @author     Dmitry Kolesnikov, <dmkolesnikov@gmail.com>
## @copyright  (c) 2014 Dmitry Kolesnikov. All Rights Reserved
##
## @description
##   Erlang/OTP from scratch 
FROM centos
MAINTAINER Dmitry Kolesnikov <dmkolesnikov@gmail.com>

ENV   ARCH  x86_64
ENV   PLAT  Linux

##
## install dependencies
RUN \
   yum -y install \
      tar  \
      git  \
      make

##
## install hyperion
COPY hyperion-current.${ARCH}.${PLAT}.bundle.bundle /tmp/hyperion.bundle

RUN \
   sh /tmp/hyperion.bundle && \
   rm /tmp/hyperion.bundle 

ENV PATH $PATH:/usr/local/hyperion/bin/


EXPOSE 4369
EXPOSE 32100

CMD sh /usr/local/hyperion/hyperion.docker


