source $HOME/dotfiles/shell/functions.sh

function httpstatus()
{
    if [ $# -ne 1 ]; then
        echo "Usage: httpstatus <url>"
    else
        if http --check-status --ignore-stdin HEAD ${1} &> /dev/null; then
            echo 'OK!'
        else
            case $? in
                2) echo 'Request timed out' ;;
                3) echo 'Unexpected HTTP redirect' ;;
                4) echo 'HTTP 4xx client error' ;;
                5) echo 'HTTP 5xx server error' ;;
                *) echo 'Other error' ;;
            esac
        fi
    fi
}

function newdb() {
    if [ $# -eq 0 ]; then
        echo "Usage: newdb <dbname>"
    else
        mysql -e "create database if not exists\`${1}\`"
    fi
}

function clean() {
    defaults write com.apple.finder CreateDesktop -bool false
    killall Finder
}

function clutter() {
    defaults write com.apple.finder CreateDesktop -bool true
    killall Finder
}

function screenshot() {
    vim -Nu ~/.vim/.vimrc.clean $@
}

function xdebugenable() {
    sed -ie 's!^;\(zend.*xdebug\.so\)!\1!' $(php --ini | awk '/php.ini$/' | awk '{print $4}')
}

function xdebugdisable() {
  sed -ie 's!^\(zend.*xdebug\.so\)!;\1!' $(php --ini | awk '/php.ini$/' | awk '{print $4}')
}

function takeoutdbs() {
    for db in frodo crm gnaf appointments storage geoscape pmacct coverage nbn faults
    do
        newdb $db;
        newdb testing_$db;
    done
}
