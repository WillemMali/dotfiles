#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

set -x
# no result if glob matches nothing
shopt -s nullglob
# glob filetype pattern support
shopt -s extglob

########## Variables
homedir="/home/$USER"
dotfilesname="dotfiles"
backupdirname="old"
scriptname="deploy.sh"
profilesname="profiles"
hostname="$(hostname)"

dir="$homedir/$dotfilesname"
backupdir="$dir/$backupdirname"
profilesdir="$dir/$profilesname"
hostnamedir="$profilesdir/$hostname"
userdir="$hostnamedir/$USER"
ignorefiles="$backupdirname $scriptname $profilesname README README.md *.sh"
files="$dir/*"

# make files with this extension executable
executablefilter=@(*.py|*.sh)

set +x

########## Confirmation dialog
read -p "Are you sure you want to install dotfiles with these settings? Y/N: " answer

while true
do
        case $answer in
                [yY]* ) break;;
                [nN]* ) exit;;
                * )     read -p "Y/N: " answer;;
        esac
done

########## Process
# Backup directory
mkdir -p "$backupdir"

# change to the dotfiles directory
cd "$dir"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 

for file in $files; do
        file=$(basename "$file")
        printf "\nprocessing $file\n"
        # ignore blacklisted files and folders (such as this script)
        for notthisfile in $ignorefiles; do
                if [ "$notthisfile" == "$file" ]; then
                        # skip this file
                        echo "file blacklisted, aborting"
                        continue 2
                fi
        done
        # remove old (conflicting) symlinks
        if [ -h "$homedir/.$file" ]; then
                printf "removing old symlink..."
                if rm "$homedir/.$file"; then echo " success."; else echo " fail, aborting!"; fi
        fi
        # back up 'old'/conflicting dotfiles
        if [ -e "$homedir/.$file" ]; then
                if [ -e "$backupdir/.$file" ]; then
                        # skip this file
                        echo "backup conflict, aborting!"
                        continue
                fi
                # back up file
                printf "backing up .${file}..."
                if ! mv "$homedir/.$file" "$backupdir"; then
                        # skip this file
                        echo " backup fail, aborting!"
                        continue
                else
                        echo " success."
                fi
        else
                echo "nothing to backup"
        fi
        # prioritize hostname and user-specific file
        if [ -e "$userdir/$file" ]; then
                printf "making symlink to $userdir/$file"
                if ln -s "$userdir/$file" "$homedir/.$file"; then echo " success."; else echo " fail!"; fi
        # then prioritize hostname-specific file
        elif [ -e "$hostnamedir/$file" ]; then
                printf "making symlink to $hostnamedir/$file"
                if ln -s "$hostnamedir/$file" "$homedir/.$file"; then echo " success."; else echo " fail!"; fi
        # then use the default file
        elif [ -e "$dir/$file" ]; then
                printf "making symlink to ${file}..."
                if ln -s "$dir/$file" "$homedir/.$file"; then echo " success."; else echo " fail!"; fi
        fi
        # make executable
        case "$file" in
                $executablefilter ) printf "making .$file executable..."; if chmod +x "$homedir/.$file"; then echo " success."; else echo " fail!"; fi ;;
        esac
done

printf "\nprocessed all files\n"
