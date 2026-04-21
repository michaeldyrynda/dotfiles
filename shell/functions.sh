function releaseDate() {
    date +"%Y%m%d%H%M"
}

function routes()
{
    if ! command -v fzf > /dev/null
    then
        if [ $# -eq 0 ]; then
            php artisan route:list
        else
            php artisan route:list | grep ${1}
        fi

        return
    fi

    if [ $# -eq 0 ]; then
        php artisan route:list | fzf
    else
        php artisan route:list | rg ${1}
    fi
}

function composer-link() {
    composer config repositories.local '{"type": "path", "url": "'$1'"}' --file composer.json
}

function fetchjson() {
    if [ $# -eq 0 ]; then
        echo "Usage: fetchjson <base_uri> <endpoint> [outfile]"
        return 1
    fi

    local base_uri="$1"
    local endpoint="${2:-}"
    local outfile="${3:-}"

    if [ -z "$endpoint" ]; then
        outfile="${outfile:-index.json}"
    else
        outfile="${outfile:-${endpoint//\//_}.json}"
    fi

    curl -s "${base_uri}/${endpoint}" | jq '.' > "${outfile}"
}



function unit() {
    if [ -f "./vendor/bin/pest" ]; then
        clear && ./vendor/bin/pest "$@"
        return
    fi

    if [ -f "./vendor/bin/sail" ]; then
        clear && ./vendor/bin/sail test
        return
    fi

    (php artisan) > /dev/null

    if [ $? -eq 0 ]; then
        VERSION=$(php artisan --version | awk '{print $3}' | cut -d . -f1)

        if [ $VERSION -ge 7 ]; then
            clear && php artisan test
            return
        fi
    fi

    if [ -f "./vendor/bin/phpunit" ]; then
        clear && ./vendor/bin/phpunit --colors -c phpunit.xml "$@"
    else
        clear && phpunit "$@"
    fi
}

function makegif() {
    if  ! command -v ffmpeg > /dev/null
    then
        echo "ffmpeg not available"
        exit 1;
    fi

    if [ $# -eq 0 ]; then
        echo "Usage: makegif <input> <output>"
    else
        ffmpeg -i ${1} -vf "fps=10,scale=1440:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 ${2}
    fi
}

function make-stereo() {
    if ! command -v ffmpeg > /dev/null
    then
        echo "ffmpeg not available"
        exit 1;
    fi

    filename=$(echo $1 | cut -d "." -f1)
    extension=$(echo $1 | cut -d "." -f2)

    ffmpeg -i $1 -af "pan=stereo|c0=c0|c1=c0" "$filename-stereo.$extension"
}

function opsecret() {
    if ! command -v op > /dev/null; then
        echo "1Password CLI (op) is not installed"
        return 1
    fi

    if ! command -v fzf > /dev/null; then
        echo "fzf is not installed"
        return 1
    fi

    local vault="${1:-}"
    local item="${2:-}"
    local field="${3:-}"

    # Select account (always interactive)
    local account_line
    account_line=$(op account list --format=json \
        | jq -r '.[] | "\(.account_uuid)\t\(.email) (\(.url))"' \
        | fzf --prompt="Account > " --height=~50% --with-nth=2..)
    [ -z "$account_line" ] && return 1
    local account
    account=$(echo "$account_line" | cut -f1)

    # Select vault
    if [ -z "$vault" ]; then
        vault=$(op vault list --account="$account" --format=json \
            | jq -r '.[].name' \
            | fzf --prompt="Vault > " --height=~50%)
        [ -z "$vault" ] && return 1
    fi

    # Select item
    if [ -z "$item" ]; then
        item=$(op item list --vault="$vault" --account="$account" --format=json \
            | jq -r '.[].title' \
            | fzf --prompt="Item ($vault) > " --height=~50%)
        [ -z "$item" ] && return 1
    fi

    # Select field
    if [ -z "$field" ]; then
        field=$(op item get "$item" --vault="$vault" --account="$account" --format=json \
            | jq -r '[.fields[]? | select(.label != null and .label != "")] | sort_by(.label) | .[].label' \
            | fzf --prompt="Field ($item) > " --height=~50%)
        [ -z "$field" ] && return 1
    fi

    op read "op://$vault/$item/$field" --account="$account"
}

_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}

function rmb() {
    if [ -z "$1" ]; then
        echo "Usage: rmb <branch-name>"
        return 1
    fi

    local output
    output=$(git branch -d "$1" 2>&1)
    local ret=$?

    if [ $ret -eq 0 ]; then
        return 0
    fi

    if echo "$output" | grep -q "not fully merged"; then
        git branch -D "$1"
    else
        echo "$output"
        return $ret
    fi
}
