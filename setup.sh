#!/bin/bash
dir=~/.dotfiles
files="aliases gitconfig tmux.conf vimrc vim zshrc oh-my-zsh zsh-completions zsh-syntax-highlighting pryrc irbrc"

for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

install_zsh () {
  if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
      git clone http://github.com/robbyrussell/oh-my-zsh.git
    fi

    if [[ ! -d $dir/zsh-completions/ ]]; then
      git clone https://github.com/zsh-users/zsh-completions.git
    fi

    if [[ ! -d $dir/oh-my-zsh/custom/plugins/zsh-autosuggestions/ ]]; then
      git clone https://github.com/zsh-users/zsh-autosuggestions.git
    fi

    if [[ ! -d $dir/zsh-syntax-highlighting/ ]]; then
      git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    fi

    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
      chsh -s $(which zsh)
    fi
  else
    platform=$(uname);
    if [[ $platform == 'Linux' ]]; then
      sudo apt-get install zsh
      install_zsh
    elif [[ $platform == 'Darwin' ]]; then
      echo "Please install zsh, then re-run this script!"
      exit
    fi
  fi
}

install_zsh
