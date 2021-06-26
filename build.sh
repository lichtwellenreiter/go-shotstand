#!/bin/bash

#RaspberryPi
env GOOS=linux GOARCH=arm GOARM=5 go build -o shotstand-raspi

#macOS
env GOOS=darwin GOARCH=amd64 go build -o shotstand-mac

#Windows
env GOOS=windows GOARCH=386 go build -o shotstand-win

#Android
env GOOS=android GOARCH=arm go build -o shotstand-android