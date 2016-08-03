sudo apt-get install aptitude vim-nox-py2 mc cmake python-dev python3-dev ffmpeg xclip
sudo apt-get install virtualenvwrapper htop ninja-build
sudo apt-get install zsh ctags openssh-server git-core bmon libindicator7 libappindicator1

echo Installing Skype
# taken from https://help.ubuntu.com/community/Skype
sudo dpkg --add-architecture i386
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-get update && sudo apt-get install skype

echo Installing OpenJDK / OpenJRE
# http://help.ubuntu.ru/wiki/java
sudo apt-get install default-jdk default-jre


#echo Installing Oracle Java
## http://help.ubuntu.ru/wiki/java
#echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
#sudo add-apt-repository ppa:webupd8team/java
#sudo apt-get update
#sudo apt-get install oracle-java8-installer

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
