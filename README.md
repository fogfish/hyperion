# Hyperion 

> 
> "It was a dramatization of total chaos, a functional definition of confusion..."
> - Dan Simmons
>

The application shows the [Erlang workflow](https://github.com/fogfish/makefile) in actions.


**spawn** backing services (mock environment)

```bash
make mock-up
```

**compile** and **test** application

```bash
make
```

**run** application

```bash
make run
```

make **release**

```bash
make release
```

make distribution **package**

```bash
make dist
```

make distribution **package** for Linux platform

```bash
make dist PLAT=Linux
```

**run** release

```bash
make console
```

**run** release within docker containers

```bash
make node-up
```

**build** docker image

```
make docker
```

**clean** everything

```
make distclean
```
