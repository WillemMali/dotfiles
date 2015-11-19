#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

set -x
shopt -s nullglob

########## Variables
homedir="/home/willem"
dotfilesname="dotfiles"
backupdirname="old"
scriptname="deploy.sh"

dir=$homedir/$dotfilesname                  # dotfiles directory
backupdir=$dir/$backupdirname             # old dotfiles backup directory
ignorefiles="$backupdirname $scriptname README README.md"    # list of files/folders to symlink in homedir
files=$dir/*

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
mkdir -p $backupdir

# change to the dotfiles directory
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 

for file in $files; do
    echo "processing $file"
    for notthisfile in $ignorefiles; do
        if [ "$dir/$notthisfile" == "$file" ]; then
            echo "blacklisted"
            continue 2
        fi
    done
            
    if [ -h $homedir/.$(basename $file) ]; then
        echo "symlink already exists"
        continue
    fi
    if [ -e $homedir/.$(basename $file) ]; then
        if [ -e $backupdir/.$file ]; then
            echo "backup conflict, aborting"
            continue
        fi
        echo "backing up .$file"
        mv $homedir/.$(basename $file) $backupdir
    else
        echo "nothing to backup"
    fi
    if [ -e $file ]; then
        echo "making symlink to $file"
        ln -s $file $homedir/.$(basename .$file)
    fi
done
