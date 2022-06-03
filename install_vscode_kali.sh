#!/bin/bash


# update software sources
sudo apt update

# download vscode installer
wget https://az764295.vo.msecnd.net/stable/da15b6fd3ef856477bf6f4fb29ba1b7af717770d/code_1.67.1-1651841865_amd64.deb

# install vscode
sudo apt install ./code_1.67.1-1651841865_amd64.deb -y

# remove vscode installer
rm code_1.67.1-1651841865_amd64.deb
