# Hyperion 

> 
> "It was a dramatization of total chaos, a functional definition of confusion..."
> - Dan Simmons
>

**Hyperion** is a docker container to *build*, *ship* and *run* Erlang applications. 


## Inspiration

The raise of containers, server-less technologies and lambda functions requires and efficient packaging of application. However, the packaging of application involves writing, copy-pasting or generating a boilerplate code. This solution reduces amount of the boiler plate code and gives a tools to ship Erlang application inside the container.


## Key features

* Build Docker container from Erlang application, no needs to use relx and other boilerplate configuration
* Includes complete Erlang VM and bootstrap code to spawn Erlang application
* Uses Alpine distribution as base image
* Compatible with rebar3


## Getting started

The easiest way to start with Hyperion, is the Docker container. The latest version of the library is available at its master `branch` and it is available at DockerHub as runnable binary `fogfish/hyperion`. Please note that Docker installation is required to procedure. 


Copy `_build` of your application into Docker container, append `app.config`. 
Congratulations, your application is ready for deployment. 

```
FROM fogfish/hyperion

COPY _build /usr/local/share/hyperion/_build
COPY app.config /etc/hyperion/app.config
```

The application requires a configuration `app.config` similar to `sys.config` in relx. This configuration file gives a hint to bootstrap code what application to boot. Additionally, you can include configuration options for other applications.

```
[
{hyperion, [{boot, myapp}]}
].

```


Use [Erlang Workflow](https://github.com/fogfish/makefile) to package Erlang application with few shell commands

```
make 
make docker
```
 

## How To Contribute

The library is Apache 2.0 licensed and accepts contributions via GitHub pull requests:

* Fork the repository on GitHub
* Read build instructions
* Make a pull request


## Changelog

The library uses [semantic versions](http://semver.org) to identify stable releases. The first elements identifies release of Erlang/OTP, second one the version of library e.g. `20.2-1`.


## License

Copyright 2012 Dmitry Kolesnikov

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
