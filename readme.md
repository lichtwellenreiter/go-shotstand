### New Shotstand implemented with Golang

#### Build for mac
```bash
go build -o shotstand-mac-0.0.1
```

#### Build for raspi
```bash
env GOOS=linux GOARCH=arm GOARM=5 go build -o shotstand-raspi-0.0.1
```