## @author     Dmitry Kolesnikov, <dmkolesnikov@gmail.com>
## @copyright  (c) 2014 Dmitry Kolesnikov. All Rights Reserved
##
## @description
##   Erlang/OTP from scratch 
FROM centos
MAINTAINER Dmitry Kolesnikov <dmkolesnikov@gmail.com>

##
## install dependencies
RUN \
   yum -y install \
      tar  \
      git  \
      make

##
## install hyperion
ADD hyperion-1+aaec6af.x86_64.Linux.bundle /tmp/hyperion-1+latest.bundle

RUN \
   sh /tmp/hyperion-1+latest.bundle && \
   rm /tmp/hyperion-1+latest.bundle 

ENV PATH $PATH:/usr/local/hyperion/bin/

EXPOSE 4369
