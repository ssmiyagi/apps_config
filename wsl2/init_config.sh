#!/bin/bash

#change default shell.use fish
chsh -s /usr/bin/fish
mkdir -p ~/.config/fish
rm ~/.config/fish/config.fish
rm ~/.config/fish/fishfile
SCRIPT_DIR=$(cd $(dirname $0); pwd)
ln -s ${SCRIPT_DIR}/../fisher/config/config.fish ~/.config/fish/config.fish
ln -s ${SCRIPT_DIR}/../fisher/config/fishfile ~/.config/fish/fishfile

#install fisher
mkdir -p ~/.config/fish/functions
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish -c fisher
