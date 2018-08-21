##
## Copyright (C) 2012 Dmitry Kolesnikov
##
## This Dockerfile may be modified and distributed under the terms
## of the MIT license.  See the LICENSE file for details.
## https://github.com/fogfish/makefile
##
## 
FROM fogfish/erlang-alpine-rt:20.3

COPY _build/default/rel /rel
COPY rel/app.config /etc/hyperion/app.config

ENTRYPOINT spawn-erlang-node hyperion
