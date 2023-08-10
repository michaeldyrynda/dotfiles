# Generic
alias ll='ls -lAFh'   #long list,show almost all,show type,human readable

alias zshrc='${=EDITOR} ~/.zshrc' # Quick access to the ~/.zshrc file

alias t='tail -f'
alias dud='du -d 1 -h'

# Artisan
alias a='artisan'
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
alias sail='bash vendor/bin/sail'

# Composer
alias co="composer dumpautoload -o"
alias ci="composer install --prefer-dist"
alias cu="composer update"
alias cr="composer require"
alias cgr="composer global require"
alias cgu="composer global update"

# Git
alias g="git"
alias ga="git add"
alias gp="git push"
alias gpf="git push --force-with-lease --force-if-includes"
alias gc="git commit"
alias gs="git status"
alias gca="git commit -m"
alias gb="git checkout -b"
alias nah="git reset --hard && git clean -df"
alias wip="git add --all && git commit -m 'wip'"
alias glr="git pull --rebase"
alias glt="git last-tag"
alias branches="git branches"
alias switch="git switch"
alias dm="git branch --merged | egrep -v \"(^\*|master|main|dev)\" | xargs git branch -d"
alias lg="lazygit"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias pop="git stash pop"
alias grc="git add . && git rebase --continue"
alias gd="git d"
alias yoink="git cherry-pick"

# Convenience
alias uf="unit --filter"
alias phpunit="unit"
alias hr="printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -"
alias please="sudo !!"
alias vim="nvim"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

alias rd=releaseDate

alias sshconf="vim ~/.ssh/config"
alias sshkey="cat ~/.ssh/id_ed25519.pub | pbcopy && echo 'Copied to clipboard.'"

alias ready="git pull --rebase && composer install && npm i && npm run dev"

alias vimdiff="nvim -d"

if command -v fzf &> /dev/null
then
    alias preview="fzf --preview 'bat --color \"always\" {}'"
fi
