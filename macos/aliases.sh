# Generic
alias ll='ls -lh'
alias rm='trash'

# Artisan
alias a='php artisan'
alias tinker='php artisan tinker'
alias serve='php artisan serve'
alias horizon='php artisan horizon'
alias pham='php artisan migrate'
alias pham:r='php artisan migrate:rollback'
alias phat='php artisan tinker'
alias phacc='php artisan cache:clear'
alias mmo='php artisan make:model'
alias mmi='php artisan make:migration'
alias mf='php artisan migrate:fresh'
alias mfs='php artisan migrate:fresh --seed'

# Composer
alias co="composer dumpautoload -o"
alias ci="composer install --prefer-dist"
alias cu="composer update"
alias cr="composer require"
alias cgr="composer global require"
alias cgu="composer global update"

# Git
alias gs="git status"
alias gca="git commit -m"
alias gb="git checkout -b"
alias nah="git reset --hard && git clean -df"
alias wip="git add --all && git commit -m 'wip'"
alias glr="git pull --rebase"
alias glt="git last-tag"
alias branches="git branches"
alias switch="git switch"
alias dm="git branch --merged | egrep -v \"(^\*|master|dev)\" | xargs git branch -d"

# Convenience
alias s="subl \."
alias uf="unit --filter"
alias phpunit="unit"
alias hr="printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -"
alias please="sudo !!"
alias cat="bat"
alias preview="fzf --preview 'bat --color \"always\" {}'"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Flush DNS
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Lock the screen
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

alias rd=releaseDate
alias gf="git flow"

alias sshconf="vim ~/.ssh/config"
alias sshkey="cat ~/.ssh/id_ed25519.pub | pbcopy && echo 'Copied to clipboard.'"

alias op="cd ~/code/\$(ls ~/code | fzf) && vim +GFiles"
