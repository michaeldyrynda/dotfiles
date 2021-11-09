source $HOME/dotfiles/shell/functions.sh

if command -v mtpush &> /dev/null; then
    function isGit {
        [ -d ".git" ]
    }

    function branchExists {
        branch=$1
        location=${2:-'local'}

        if [ ! -n "$branch" ]; then
            echo 'Usage: branchExists <branch> [<local|remote>]'
            return 1
        fi

        if [[ "$location" == "local" ]]; then
            check=`git show-ref refs/heads/${branch}`
        else
            check=`mtpush -branch | sed -nrb "s|(dy_)?($branch)|\2|p" | xargs`
        fi

        [ -n "$check" ]
    }

    function currentBranch {
        location=${1:-local}

        if [[ "$location" == "local" ]]; then
            check=`git rev-parse --abbrev-ref HEAD`
        else
            check=`mtpush -status | sed -nrb "s|\# On branch (dy_)?(.*)|\2|p"`

            if [[ "$check" == "dy" ]]; then
                check="master"
            fi
        fi

        echo "$location: $check"
    }

    function hasStash {
        if [[ -n "$1" ]]; then
            [[ -n `git stash list | grep "$1"` ]]
        else
            [ -n `git stash list` ]
        fi
    }

    function mg {
        if ! isGit; then
            echo "Not in a git working directory"
        else
            LAST_SHA=`git rev-parse --short HEAD`
            LAST_COMMIT=`git log -1 --pretty="%s"`
            STASH_ID="mtpush-$LAST_SHA"

            if [ -z "$LAST_COMMIT" ]; then
                echo "No commit to push"
            else
                git stash save -u "$STASH_ID"
                mtpush -push "'$LAST_COMMIT'"

                if hasStash $STASH_ID; then
                    git stash pop
                fi
            fi
        fi
    }

    # Switch branches in MaxoGit TM, ensuring that local and remote branches remain
    # in sync with each other, and that unstaged local changes don't go missing.
    function mb {
        if ! isGit; then
            echo "Not in a git directory"
            return 1
        elif [ -z ${1} ]; then
            echo "Usage: mb <new-branch-name>"
            return 1
        else
            newBranch=$1

            echo "Stashing changes..."
            git stash -u

            if ! branchExists $newBranch "local"; then
                echo "Branch ($newBranch) doesn't exist locally. Creating..."
                git checkout master
                mtpush -checkout master
                git add . && git commit -m "sync upstream"
                git checkout -b "$newBranch"
            fi

            currentLocal=`currentBranch local`

            if [[ "$newBranch" != "$currentLocal" ]]; then
                echo "Switching to ($newBranch) locally..."
                git checkout "$newBranch"
            fi

            if ! branchExists $newBranch "remote"; then
                echo "Branch ($newBranch) does not exist remotely. Creating..."
                mtpush -branch "$newBranch"
            fi

            currentRemote=`currentBranch remote`

            if [[ "$newBranch" != "$currentRemote" ]]; then
                echo "Switching to ($newBranch) remotely..."
                mtpush -checkout "$newBranch"
            fi

            git add .
            git commit -m "sync upstream"

            if hasStash; then
                git stash pop
            fi
        fi
    }
fi
