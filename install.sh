#!/bin/bash
##################
# install.sh
##################

dotfiles=~/.dotfiles
old_dotfiles=~/.dotfiles.bak
files="bashrc bash_profile gitconfig vim vimrc zshrc tmux.conf"

echo "Pulling all submodules"
git pull && git submodule init && git submodule update && git submodule status

echo -ne "Creating $old_dotfiles for backup of any existing dotfiles in ~ ..."
mkdir -p $old_dotfiles
echo "done"

echo -ne "Changing to the $dotfiles directory..."
cd $dir
echo "done"

for file in $files; do
   if [ -e ~/.$file ]; then
      if [ -h ~/.$file ]; then
         echo -ne "Removing symbolic link .$file from ~ ..."
         rm ~/.$file
         echo "done"
      else
         echo -ne "Backing up .$file from ~ to $old_dotfiles..."
         mv ~/.$file $old_dotfiles/
         echo "done"
      fi
   fi

   echo -ne "Installing .$file..."
   ln -s $dotfiles/$file ~/.$file
   echo "done"
done

OS=`uname -s`
if [ $OS = "Linux" ]; then
   sudo apt-get install -y zsh vim ctags curl
   chsh -s /bin/zsh
   curl -L https://get.rvm.io | bash -s stable --ruby
fi
