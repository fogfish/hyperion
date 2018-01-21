FROM fogfish/hyperion

##
## config build
ARG VSN=

##
## deploy application (with source code)
COPY . /usr/local/share/hyperion/
COPY app.config /etc/hyperion/app.config

##
##
EXPOSE 8888
