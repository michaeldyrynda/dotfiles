#!/bin/bash

INSTALL_BASE=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

if [ ! -d  "${INSTALL_BASE}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${INSTALL_BASE}/plugins/zsh-autosuggestions
fi

if [ ! -d  "${INSTALL_BASE}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${INSTALL_BASE}/plugins/zsh-syntax-highlighting
fi

if [ ! -d  "${INSTALL_BASE}/plugins/artisan" ]; then
    git clone https://github.com/jessarcher/zsh-artisan.git ${INSTALL_BASE}/plugins/artisan
fi
