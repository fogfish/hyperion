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
ADD hyperion-1+c330c51.x86_64.Linux.bundle /tmp/hyperion-1+latest.bundle

RUN \
   sh /tmp/hyperion-1+latest.bundle && \
   rm /tmp/hyperion-1+latest.bundle 

ENV PATH $PATH:/usr/local/hyperion/bin/

##
## fix 
# RUN chmod ugo+x /usr/local/hyperion/bin/hyperion-dock
ADD rel/files/hyperion-dock /usr/local/hyperion/bin/hyperion-dock

EXPOSE 4369
EXPOSE 32100

CMD /etc/init.d/hyperion-dock


