# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

DEFAULT_USER=michael
ZSH_THEME=""
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
BREW_BASE_DIR=$(brew --prefix)

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
fpath+=$HOME/dotfiles/pure

# Enable pure-prompt
autoload -U promptinit; promptinit
prompt pure

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
export PATH="/opt/homebrew/bin:$HOME/bin:$HOME/.composer/vendor/bin:$HOME/.config/composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/local/opt/mysql-client/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/usr/local/MacGPG2/bin"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

ARTISAN_OPEN_ON_MAKE_EDITOR=vim
