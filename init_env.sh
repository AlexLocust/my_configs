sudo apt-get install -y aptitude vim-nox-py2 mc cmake python-dev python3-dev ffmpeg xclip tmux
sudo apt-get install -y virtualenvwrapper htop ninja-build
sudo apt-get install -y zsh ctags openssh-server git-core bmon libindicator7 libappindicator1

echo Installing Skype
# taken from https://help.ubuntu.com/community/Skype
sudo dpkg --add-architecture i386
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-get update && sudo apt-get install skype

echo Installing OpenJDK / OpenJRE
# http://help.ubuntu.ru/wiki/java
sudo apt-get install default-jdk default-jre

# docker repos
echo Installing Docker
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install -y docker-engine

# VirtualBox repositories
echo Installing VirtualBox repositories
echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee -a /etc/apt/sources.list.d/virtualbox.list 
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

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
