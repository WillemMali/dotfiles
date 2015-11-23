#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

set -x
shopt -s nullglob

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
ignorefiles="$backupdirname $scriptname $profilesname README README.md"
files="$dir/*"

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
        echo "processing $file"
        # ignore blacklisted files and folders (such as this script)
        for notthisfile in $ignorefiles; do
                if [ "$notthisfile" == "$file" ]; then
                        # skip this file
                        echo "blacklisted"
                        continue 2
                fi
        done
        # remove old (conflicting) symlinks
        if [ -h "$homedir/.$file" ]; then
                echo "removing old symlink"
                rm "$homedir/.$file"
        fi
        # back up 'old'/conflicting dotfiles
        if [ -e "$homedir/.$file" ]; then
                if [ -e "$backupdir/.$file" ]; then
                        # skip this file
                        echo "backup conflict, aborting"
                        continue
                fi
                # back up file
                echo "backing up .$file"
                mv -rf "$homedir/.$file" "$backupdir"
        else
                echo "nothing to backup"
        fi
        # prioritize hostname and user-specific file
        if [ -e "$userdir/$file" ]; then
                echo "making symlink to $userdir/$file"
                ln -s "$userdir/$file" "$homedir/.$file"
                continue
        fi
        # then prioritize hostname-specific file
        if [ -e "$hostnamedir/$file" ]; then
                echo "making symlink to $hostnamedir/$file"
                ln -s "$hostnamedir/$file" "$homedir/.$file"
                continue
        fi
        # then use the default file
        if [ -e "$dir/$file" ]; then
                echo "making symlink to $file"
                ln -s "$dir/$file" "$homedir/.$file"
                continue
        fi
done
