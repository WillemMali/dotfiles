#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=$dir/old             # old dotfiles backup directory
files="bashrc bash_aliases bash_logout vimrc vim Xdefaults profile"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    if [ -h ~/.$file ]; then
        echo "Skipping $file because symlink already exists"
        continue
    fi
    if [ -e ~/.$file ]; then
        echo "Moving .$file to $olddir"
        mv ~/.$file $olddir
    fi
    if [ -e $dir/$file ]; then
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/.$file
    fi
done
