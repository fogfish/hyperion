# Erlang Node Builder

The project defines builder script(s) to assemble Erlang/OTP node.

## Objectives

* assemble self-contained tarball package, installable to remote nodes
* enable environment with minimal memory footprint while providing all standard Erlang/OTP libraries. 
* ensure node customization

## Customize

* add 3rd-party Erlang libraries via `rebar.config` and `deps.config`
* manage node content and boot sequence via `reltool.config` 
* overlay default configuration with `vars.config`
* define application envrionment and system variables at `sys.config`

## Build

### Build standard node configuration

produces `hyperion-${VSN}.${ARCH}-${PLAT}.tgz`

```
	make
	make rel
``` 

### Overlay node specific configuration

produces `mynode-${VSN}.${ARCH}-${PLAT}.tgz`

```
   make
   make node id=mynode.config
```

## Deploy

```
	scp hyperion-${VSN}.${ARCH}-${PLAT}.tgz myuser@mynode:
	ssh myuser@mynode

	cd /usr/local
	sudo tar -xvf hyperion-${VSN}.${ARCH}-${PLAT}.tgz
	/usr/local/hyperion/bin/hyperion {start|stop|attach}
```


