# Erlang Vanilla Node

The project defines a vanilla configuration for Erlang OTP node, allowing 
to build a distributable release package (tarball) containing chosen OTP release.

## Customize

* Use `rebar.config` and `deps.config` to include external application to node
* Use reltool.config to configure the release (node content)
* Use vars.config to overlay node configuration
* Use sys.config to manage default application properties

## Build

```
	make
	make rel
``` 

## Deploy

TODO: deployment script
```
	scp hyperion-$ARCH.tgz myuser@mynode:
	ssh myuser@mynode

	cd /usr/local
	tar -xvf hyperion-$ARCH.tgz
	/usr/local/hyperion/bin/hyperion {start|stop}
```


