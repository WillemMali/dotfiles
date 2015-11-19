#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

set -x
homedir="/home/willem"
dir=$homedir/dotfiles                    # dotfiles directory
olddir=$dir/old             # old dotfiles backup directory
files="bashrc bash_aliases bash_logout vimrc vim Xdefaults profile"    # list of files/folders to symlink in homedir

# read input
read -p "Are you sure you want to install dotfiles with these settings? Y/N: " answer

# handle input
while true
do
    case $answer in
        [yY]* ) break;;
        [nN]* ) exit;;
        * )     read -p "Y/N: " answer;;
    esac
done

##########

# create dotfiles_old in homedir
mkdir -p $olddir

# change to the dotfiles directory
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    if [ -h $homedir/.$file ]; then
        echo "symlink already exists"
        continue
    fi
    if [ -e $homedir/.$file ]; then
        mv $homedir/.$file $olddir
    fi
    if [ -e $dir/$file ]; then
        ln -s $dir/$file $homedir/.$file
    fi
done
