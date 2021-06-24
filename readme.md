## New Shotstand implemented with Golang

### Prerequisites

#### Chromium

Chromium Browser (normally this one is default)

#### Redis

Redis on localhost:6379  
https://habilisbest.com/install-redis-on-your-raspberrypi  
https://amalgjose.com/2020/08/11/how-to-install-redis-in-raspberry-pi/

### Build for mac

```bash
go build -o shotstand-mac-0.0.1
```

### Build for raspi

https://www.thepolyglotdeveloper.com/2017/04/cross-compiling-golang-applications-raspberry-pi/

```bash
env GOOS=linux GOARCH=arm GOARM=5 go build -o shotstand-raspi-0.0.1
```