source $HOME/dotfiles/shell/aliases.sh

# Convenience
alias s="subl \."
alias cat="bat"

# Flush DNS
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Lock the screen
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

alias pr="gh pr create"
