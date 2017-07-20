#!/usr/bin/env bash

# /!\ Ceci est un script d'installation prévu pour des personnes n'ayant rien de configuré sur leur machine
# /!\ Adaptez ce script en fonction de vos besoins avant de le lancer.

# Lancer ce script depuis la racine de Docker :
# ./install/linux-install.sh

set -e

source ../color.sh

echoInfo "============================================================="
echoInfo "======================= Install Docker ======================"
echoInfo "============================================================="

echo

#
# Check if Homebrew is installed
#
which -s brew
if [[ $? != 0 ]] ; then
    # Install package manager on mac osx call homebrew
    # https://github.com/mxcl/homebrew/wiki/installation
    echoInfo "==> Install Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echoInfo "brew update && brew upgrade"
    # Make sure brew is up to date
    brew update && brew upgrade
    echoSuccess "======= Done ! ======="
fi

echoInfo "==> Install brew-cask"
# Homebrew Cask extends Homebrew and brings its elegance, simplicity, and speed to OS X applications and large binaries alike.
brew tap caskroom/cask
echoSuccess "======= Done ! ======="

if  [[ "$(vboxmanage --version)" == 0 ]] ; then
    echoInfo "==> Install Virtualbox"
    brew cask install virtualbox
    echoSuccess "======= Done ! ======="
fi

echoInfo "==> Install some libraries with brew"
for pkg in wget git docker docker-compose docker-machine gettext docker-machine-nfs; do
    echoInfo "Trying to install '$pkg'..."
    sleep 0.3
    if brew list -1 | grep -q "^${pkg}\$"; then
        echo " - '$pkg' already installed"
    else
        brew install $pkg
    fi
done
echoSuccess "======= Done ! ======="


echoInfo "Check docker machine dev already created..."
if [[ $(docker-machine ls -q) != "dev" ]]; then

    echoInfo "==> Create docker machine dev"
    sh ./install/docker-machine/create-machine.sh
else
    echoInfo "==> docker machine dev already exist"
fi

if `docker-machine ls | grep -qi 'Stopped'`; then
    docker-machine start dev
fi

default=$HOME/.bash_profile
read -p "- Enter your shell profile path (${YELLOW}$default${COL_RESET}): " BASH_PATH
BASH_PATH=${BASH_PATH:-$default}
docker-machine env dev >> $BASH_PATH
echo "export EASY_PROJECT_PATH=\"$HOME/www\"" >> $BASH_PATH
echo "export EASY_PROJECT_DOCKER_PATH=\"$HOME/docker\"" >> $BASH_PATH
source $BASH_PATH

if `docker-machine ssh dev mount | grep -qi 'type nfs'`; then
    :
else
    echoInfo "==> Mount local path to doker-machine please wait ... "
    sleep 5
    docker-machine-nfs dev --shared-folder=/Users/$USER --nfs-config="-alldirs -maproot=0" --mount-opts="noatime,soft,nolock,vers=3,udp,proto=udp,rsize=8192,wsize=8192,namlen=255,timeo=10,retrans=3,nfsvers=3"
    echoSuccess "======= Done ! ======="
fi


echoSuccess "-------------------------------------------------------------------------------"
echo
echoSuccess "     Docker installed with success"
echoSuccess "     docker-machine 'dev' was created and is running"
echoSuccess "     To create a new project run 'create-project' command in your terminal"
echo
echoSuccess "-------------------------------------------------------------------------------"
