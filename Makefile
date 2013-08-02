##
##
.PHONY: deps test rel

APP  = hyperion

REL  = $(shell cat rel/reltool.config | sed -n 's/{target_dir,.*\"\(.*\)\"}./\1/p')
VSN  = $(shell echo ${REL} | sed -n 's/.*-\(.*\)/\1/p')
ARCH = $(shell uname -m)
PLAT = $(shell uname -s)
TAR  = ${REL}.${ARCH}-${PLAT}.tgz

all: rebar deps compile

compile:
	./rebar compile

deps:
	./rebar get-deps

clean:
	./rebar clean
	rm -rf test.*-temp-data
	rm -f  *.${ARCH}-${PLAT}.tgz

distclean: clean 
	./rebar delete-deps

test: all
	./rebar skip_deps=true eunit

docs:
	./rebar skip_deps=true doc

run:
	erl -name ${APP}@127.0.0.1 -setcookie nocookie -pa deps/*/ebin -pa apps/*/ebin

rebar:
	curl -O https://raw.github.com/wiki/basho/rebar/rebar
	chmod ugo+x rebar

##
## release
##
rel: all
	./rebar generate ; \
	cd rel ; tar -zcf ../${TAR} ${REL}/; cd -

node:	clean	all
	N=`basename ${id} .config`; \
	F=`pwd`; \
	./rebar generate target_dir=$$N-${VSN} overlay_vars=$$F/${id} ; \
	cd rel ; tar -zcf ../$$N-${VSN}.${ARCH}-${PLAT}.tgz $$N-${VSN}/; cd -

##
## node
##
start: 
	./rel/${REL}/bin/${APP} start

stop:
	./rel/${REL}/bin/${APP} stop

console: 
	./rel/${REL}/bin/${APP} console

attach:
	./rel/${REL}/bin/${APP} attach


