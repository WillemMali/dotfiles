#! /bin/bash
# "MetaGit" - a command for using git on the .git folder of the current git repo
mgit() {
        (
                gitroot="$(git rev-parse --show-toplevel)"
                [ $? == 0 ] || {
                        echo "MetaGit can only be run inside a Git repo, exiting."
                        exit
                }
                cd "$gitroot/.git"
                git "$@"
        )
}

# short git commit
acp() {
        git add -A :/
        if [ -n "$1" ]; then
                git commit -m "$1"
        else
                git commit "quick backup"
        fi
        git push origin master
}

explore() {
        if [ -z "$1" ]; then
                /bin/cygstart --explore `pwd`
        else
                /bin/cygstart --explore $@
        fi
}

function nonono() {
        while true; do
                printf "no "
                sleep 1
        done
}

function DoctorNo() {
        while true; do
                echo "Ask me anything?"
                read;
                echo "No."
        done
}


