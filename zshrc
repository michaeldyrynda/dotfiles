export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  history
  history-substring-search
  artisan
  zsh-syntax-highlighting
  zsh-autosuggestions
)

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
export PATH="/opt/homebrew/bin:$HOME/bin:$HOME/.composer/vendor/bin:$HOME/.config/composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/opt/homebrew/opt/mysql-client/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/usr/local/MacGPG2/bin:$HOME/node_modules/.bin"

export EDITOR="nvim"

export GPG_TTY=$(tty)

setopt auto_cd
cdpath=($HOME/code)

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

ensure_tmux_is_running

ulimit -n 10000

# Initialise starship prompt for zsh
eval "$(starship init zsh)"

eval "$(fzf --zsh)"

# Use fd with fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
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
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort' --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

export BAT_CONFIG_PATH="/Users/michael/.config/bat.conf"

# opencode
export PATH=/Users/michael/.opencode/bin:$PATH

# Local config (machine-specific, not in version control)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
