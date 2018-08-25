# Docker image of Firefox (32bit) with Oracle java support

## Build image
```
docker build -t gagara/ff32-java:1.0 .
```

## Create (and run) container
[http://stackoverflow.com/a/29893375](http://stackoverflow.com/a/29893375)
```
docker run -ti -v /tmp/.X11-unix:/tmp/.X11-unix -v /run/user/$UID/pulse/native:/run/pulse/native -v $HOME/.config/pulse/cookie:/run/pulse/cookie -e DISPLAY=$DISPLAY -e PULSE_SERVER=unix:/run/pulse/native -e PULSE_COOKIE=/run/pulse/cookie --name=ff32-java gagara/ff32-java:1.0 /usr/bin/firefox 
```

## Stop container
```
docker stop ff32-java
```

## Start container
```
docker start ff32-java
```
