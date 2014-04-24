#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

dotfilesDir=~/dotfiles/dotfiles
configDir=~/dotfiles/config
backupDir=~/dotfiles_old


echo "Creating $backupDir and $backupDir/config..."
mkdir -p $backupDir/config
echo "Creating $backupDir and $backupDir/config... done"

echo "cd $dotfilesDir"
echo ""
cd $dotfilesDir

for file in *; do
    echo "Backing up $file to $backupDir/$file"
    mv ~/.$file $backupDir/

    echo "Creating symlink to $file in home directory"
    ln -s $dotfilesDir/$file ~/.$file

    echo ""
done


echo "cd $configDir"
echo ""
cd $configDir

for file in *; do
    echo "Backing up .config/$file to $backupDir/config/$file"
    mv ~/.config/$file $backupDir/config/

    echo "Creating symlink to $file in ~/.config directory"
    ln -s $configDir/$file ~/.config/$file

    echo ""
done

