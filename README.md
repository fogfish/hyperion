# Erlang Node Builder

The project is show case of Makefile build script (see https://github.com/fogfish/makefile) and it defines a template and builder script(s) to assemble Erlang/OTP node. Objectives are assemble self-contained tarball package, installable to remote nodes; enables environment with minimal memory footprint while providing all standard Erlang/OTP libraries. It also provides scripts to assemble docker images

## Build docker image

The boot2docker (https://github.com/boot2docker/boot2docker) is required.
Ready made image is available at https://hub.docker.com with identity fogfish/otp:R16B03-1

```
   cd rel/files/docker/R16B03-1
   docker build -t fogfish/otp:R16B03-1 .
```

The docker image is needed if _cross-platform_ build on Mac OS is required

## Build Hyperion node

```
   make
   make pkg
   make node pass=~/.ssh/id_rsa host=ec2-user@example.com
```

## Build Linux Hyperion node on Mac OS

```
   make
   make pkg PLAT=Linux
   node node PLAT=Linux pass=~/.ssh/id_rsa host=ec2-user@example.com
```
