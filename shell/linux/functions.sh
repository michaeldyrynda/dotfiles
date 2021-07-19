source $HOME/dotfiles/shell/functions.sh

if command -v mtpush &> /dev/null; then
    function mg() {
        if [ ! -d ".git" ]; then
            echo "Not in a git working directory"
        else
            LAST_COMMIT=`git log -1 --pretty="%s"`

            if [ -z "$LAST_COMMIT" ]; then
                echo "No commit to push"
            else
                git stash -u
                mtpush -push "'$LAST_COMMIT'"
                git stash pop
            fi
        fi
    }
fi
