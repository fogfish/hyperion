##
##   Copyright (c) 2016, Dmitry Kolesnikov
##   All Rights Reserved.
##
##   Licensed under the Apache License, Version 2.0 (the "License");
##   you may not use this file except in compliance with the License.
##   You may obtain a copy of the License at
##
##       http://www.apache.org/licenses/LICENSE-2.0
##
##   Unless required by applicable law or agreed to in writing, software
##   distributed under the License is distributed on an "AS IS" BASIS,
##   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##   See the License for the specific language governing permissions and
##   limitations under the License.
##
## @description
##   The container is run-time environment for Erlang applications.
##   It is composed of
##    * Erlang/VM and full set of OTP libraries
##    * Erlang compiler and other development tools   
##    * Erlang node bootstrap application (hyperion)
##         
FROM centos
MAINTAINER Dmitry Kolesnikov <dmkolesnikov@gmail.com>

##
## config
ENV   PLAT  Linux
ENV   ARCH  x86_64  
ARG   APP=hyperion
ARG   VSN=

##
## install bootstrap application
COPY ${APP}-${VSN}+${ARCH}.${PLAT}.bundle ${APP}-${VSN}.bundle
RUN sh ${APP}-${VSN}.bundle

ENTRYPOINT /etc/init.d/hyperion foreground
