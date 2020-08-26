# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

DEFAULT_USER=michael
ZSH_THEME=""
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  git-flow
  history
  history-substring-search
  sublime
  common-aliases
  artisan
  zsh-syntax-highlighting
  zsh-autosuggestions
)

fpath=($HOME/dotfiles/zsh-completions/completions $fpath)
fpath+=$HOME/dotfiles/pure

# Enable pure-prompt
autoload -U promptinit; promptinit
prompt pure

source $ZSH/oh-my-zsh.sh
source $HOME/dotfiles/macos/aliases.sh
source $HOME/dotfiles/macos/functions.sh

# User configuration
export PATH="$HOME/bin:$HOME/.composer/vendor/bin:$HOME/.config/composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/local/opt/mysql-client/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/usr/local/MacGPG2/bin"

export EDITOR=vim

export BAT_THEME="Nord"
export GPG_TTY=$(tty)

export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

setopt auto_cd
cdpath=($HOME/code)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

ARTISAN_OPEN_ON_MAKE_EDITOR=vim
