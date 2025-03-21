#!/bin/zsh

# spotify in workspace 4
spotify-launcher &
sleep 2
hyprsome move 4
playerctl -p spotify open spotify:playlist:0wJmCqlQFg0wi6qBr3eCXO

# firefox in workspace 3
firefox &
sleep 2
hyprsome move 3

# vesktop in workspace 2
vesktop &
sleep 3
hyprsome move 2

# main terminal
alacritty -e zsh -c "sleep 2; neofetch; zsh" &
sleep 1

# unimatrix
alacritty -e zsh -c "unimatrix -c blue" &
sleep 1

# cava
alacritty -e cava &
sleep 1



