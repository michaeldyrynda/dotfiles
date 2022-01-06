# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source $HOME/dotfiles/shell/linux/aliases.sh
source $HOME/dotfiles/shell/linux/functions.sh

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
