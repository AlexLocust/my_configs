sudo apt-get install aptitude vim-nox-py2 mc cmake python-dev python3-dev ffmpeg xclip
sudo apt-get install virtualenvwrapper htop ninja-build
sudo apt-get install zsh ctags openssh-server git-core bmon

git submodule update --init --recursive

ln -s ~/my_configs/.vim/.vimrc ~/.vimrc
ln -s ~/my_configs/.vim/ ~/.vim
ln -s ~/my_configs/.tmux.conf ~/.tmux.conf

echo Installing YouCompleteMe
cd ~/my_configs/.vim/bundle/YouCompleteMe
./install.py --clang-completer
cd -

# install VIM plugins throught vundle
vim +PluginInstall +qall

#ln -s ~/.my_configs/fontconfig/fonts.conf ~/.fonts.conf
#ln -s ~/.my_configs/xfce4/ ~/.config/xfce4
#ln -s ~/.my_configs/xfce4-session/ ~/.config/xfce4-session
#ln -s ~/.my_configs/.Xresources ~/.Xresources
#ln -s ~/.my_configs/.fonts ~/.fonts

# install oh-my-zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
rm ~/.zshrc
ln -s ~/my_configs/.zshrc ~/.zshrc

./powerline_fonts/install.sh
