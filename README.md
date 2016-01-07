# Hyperion 

> 
> "It was a dramatization of total chaos, a functional definition of confusion..."
> - Dan Simmons
>

This application is a drop-in replacement of Erlang run-time environment. It addresses multiple issue of Erlang applications development: 

1. Build, Ship and Run application as docker containers 
1. Provides out-of-box Erlang node
1. Delivers cross-platform run-time environment

The application uses [Erlang/OTP release tool](http://www.erlang.org/doc/man/reltool.html) to package Erlang VM, compiler, development tools and OTP libraries into single deliverable -- tarball package. The package is augmented with bootstrap application `hyperion` that allows to customize Erlang node boot procedure. The release specification is defined in [rel/reltool.config](rel/reltool.config).


## Build, Ship and Run Container

The packaging and deployment of Erlang applications is straightforward process. 
The [release tool](http://www.erlang.org/doc/man/reltool.html) gives required functionality to
developers. It package and deliver Erlang runtime along with application code to *vanilla* Linux
environments. However, the process of release assembly requires release configuration. 
The release configuration is convenient if you build self-contained service but it brings 
an overhead if you deliver library, small application or proof-of-concept.

The application builds a base docker container `fogfish/hyperion` from [Dockerfile](rel/files/Dockerfile). The container spawn Erlang/OTP node once it is started, it also spawn all applications and its dependencies located in `/usr/local/share/hyperion/`.  

The tiny container configuration for any Erlang application is shown below. It assumes classical directory structure for each application. See [application design principles](http://www.erlang.org/doc/design_principles/applications.html), [application design tutorial](http://learnyousomeerlang.com/building-otp-applications) or [example application](examples/echo).


```
FROM fogfish/hyperion
 
COPY . /usr/local/share/hyperion/echo
```

The `hyperion` container is available on [docker hub](https://hub.docker.com/r/fogfish/hyperion/).
Use docker tools to build, ship and run your containers!


## Erlang node

Secondary purpose of the project is a reference application of [Makefile](https://github.com/fogfish/makefile). It defines a template and builder script(s) to assemble Erlang/OTP node as self-contained tarball package, installable to any *vanilla* Linux environment.

The build process requires [Erlang/OTP development environment](http://www.erlang.org/download.html)
and [docker toolbox](https://www.docker.com/docker-toolbox).


### build release

The build process delivers tarball (`*.tgz`) and installable package (`*.bundle`) for your platform.
An optional argument `PLAT=Linux` allows you to build Linux release using Mac OS and docker tools. 

```
make
make pkg [PLAT=Linux]
```


## Cross-platform run-time environment

tbd

