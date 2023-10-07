#!/bin/bash

WORKDIR=~/.config/dotfiles

rm ~/tmux.conf && ln -s $WORKDIR/tmux.conf ~/tmux.conf
rm ~/.config/starship.toml && ln -s $WORKDIR/starship.toml ~/.config/starship.toml
rm ~/.config/fish/config.fish && ln -s $WORKDIR/config.fish ~/.config/fish/config.fish

rm ~/.zshrc && ln -s $WORKDIR/zshrc ~/.zshrc
rm ~/.bashrc && ln -s $WORKDIR/bashrc ~/.bashrc

rm "$HOME/Library/Application Support/nushell/login.nu" 
ln -s $WORKDIR/login.nu "$HOME/Library/Application Support/nushell/login.nu"
