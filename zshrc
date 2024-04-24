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


# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/michael/Library/Application Support/Herd/config/php/83/"


# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/michael/Library/Application Support/Herd/config/php/82/"


# Herd injected PHP binary.
export PATH="/Users/michael/Library/Application Support/Herd/bin/":$PATH


# Herd injected NVM configuration
export NVM_DIR="/Users/michael/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"


export ROUTE53_SECRET=7IoB+LW26sw82eu4FB5o/KbygPnp4LecSHotQbW8

# Set up fzf keybindings and fuzzy completion
eval "$(fzf --zsh)"

# Use fd with fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                  "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/.local/fzf-git/fzf-git.sh

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
export BAT_THEME=tokyonight_night
