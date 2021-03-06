# Setup fzf
# ---------
if [[ ! "$PATH" == *${BREW_BASE_DIR}/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${BREW_BASE_DIR}/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${BREW_BASE_DIR}/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${BREW_BASE_DIR}/opt/fzf/shell/key-bindings.zsh"
