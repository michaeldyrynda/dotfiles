function releaseDate() {
    date +"%Y%m%d%H%M"
}

function routes()
{
    if [ ! command -v fzf > /dev/null ]
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

function fetchjson()
{
    if [ $# -eq 0 ]; then
        echo "Usage: json <base_uri> <endpoint>"
    else
        if [ -z "$2" ]; then
            endpoint=""
            outfile="index.json"
        else
            endpoint="${2}"
            outfile="${2//\//_}.json"
        fi

        if [ -z "$3" ]; then
            outfile="$3"
        fi

        curl -s ${1}/${endpoint} | python -m json.tool > ${outfile}
    fi
}

function syncBranch() {
    if [ $# -eq 0 ]; then
        echo "Usage: syncBranch <remote> <branch>"
    else
        git checkout ${2} && git fetch --prune && git merge --ff-only ${1} ${2}
    fi
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
    if [ ! command -v ffmpeg > /dev/null ]
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
    if [ ! command -v ffmpeg > /dev/null ]
    then
        echo "ffmpeg not available"
        exit 1;
    fi

    ffmpeg -i $1 -af "pan=stereo|c0=c0|c1=c0" "$1-stereo.mp3"
}
