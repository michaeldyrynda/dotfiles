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
  artisan
  zsh-syntax-highlighting
  zsh-autosuggestions
)

fpath=($HOME/dotfiles/zsh-completions/completions $fpath)
fpath+=(/opt/homebrew/share/zsh/site-functions)

source $ZSH/oh-my-zsh.sh
if [[ `uname` == 'Darwin' ]]
then
  source $HOME/dotfiles/shell/macos/aliases.sh
  source $HOME/dotfiles/shell/macos/functions.sh
else
  source $HOME/dotfiles/shell/linux/aliases.sh
  source $HOME/dotfiles/shell/linux/functions.sh
fi

# User configuration
export PATH="/opt/homebrew/bin:$HOME/bin:$HOME/.composer/vendor/bin:$HOME/.config/composer/vendor/bin:$HOME/.config/phpmon/bin:/usr/local/sbin:/usr/local/bin:/opt/homebrew/opt/mysql-client/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/usr/local/MacGPG2/bin:$HOME/node_modules/.bin"

if command -v nvim &> /dev/null
then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

export BAT_THEME="Nord"
export GPG_TTY=$(tty)

export FZF_DEFAULT_COMMAND='ag -u -g ""'
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

setopt auto_cd
cdpath=($HOME/code)

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

ensure_tmux_is_running

ulimit -n 10000

# Initialise starship prompt for zsh
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

BREW_BASE_DIR=$(brew --prefix)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
