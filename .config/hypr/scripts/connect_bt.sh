#!/bin/zsh

# edifier w800bt plus mac address
HEADPHONE_MAC="0C:AE:BD:C1:19:76"

# connect
bluetoothctl connect $HEADPHONE_MAC
