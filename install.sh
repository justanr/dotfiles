#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
GOVERSION="1.22.2"
XDG_CONFIG="${XDG_CONFIG:-${HOME}/.local}"
COMPLETIONS_DIR="${XDG_CONFIG}/share/bash-completion/completions/"

if [ "$ALEC_INSTALL_DEBUG" != "" ]; then
    set -x
fi
set -e
set -o pipefail

mkdir -p ${XDG_CONFIG}/{bin,share,lib}
mkdir -p ${COMPLETIONS_DIR}
export PATH=${PATH}:${XDG_CONFIG}/bin

# Sue me.
WORKDIR="/tmp/$(cat /proc/sys/kernel/random/uuid)"

function refresh_repos() {
    echo "Updating repos"
    sudo apt-get update
}

function install_basics() {
    echo "Installing the basics"
    sudo apt-get install -y apt-transport-https
    # don't bother with git here because I probably already installed it
    # and if I didn't, well fuck me then because I'm not doing all the nonsense
    # required to some how bootstrap that w/ a new ssh key or restore from a
    # backup.

    sudo apt-get install -y tmux \
        neovim \
        python3-pip \
        curl \
        ca-certificates \
        gnupg \
        lsb-release \
	bash-completion


    tmux -V
    nvim --version
    curl --version
    pip3 --version
}

function setup_virtualenvwrapper() {
    export WORKON_HOME="${HOME}/.venvs"
    pip3 install --user virtualenvwrapper
    source ${XDG_CONFIG}/bin/virtualenvwrapper.sh
}

function install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o install-rustup.sh
    chmod +x install-rustup.sh
    ./install-rustup.sh -y
    source ${HOME}/.cargo/env
    rustup install stable
    rustup install nightly
    rustup default stable


    rustup completions bash > ${COMPLETIONS_DIR}/rustup
    rustup completions bash cargo > ${COMPLETIONS_DIR}/cargo
}

function install_node() {
    NVM_DIR="${HOME}/.nvm"
    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    . "${NVM_DIR}/nvm.sh"
    nvm install --lts
    nvm use --lts
}

function configure_neovim() {
    npm install -g neovim typescript@latest
    mkvirtualenv neovim
    pip install -r ${SCRIPT_DIR}/requirements.txt
    deactivate

    local NEOVIM_HOME=${HOME}/.config/nvim
    echo "NEOVIM_HOME=${NEOVIM_HOME}"
    rm -rf ${NEOVIM_HOME}  || true
    mkdir -p ${NEOVIM_HOME}
    ln -s ${SCRIPT_DIR}/init.vim ${NEOVIM_HOME}/init.vim
    ln -s ${SCRIPT_DIR}/coc-settings.json ${NEOVIM_HOME}/coc-settings.json

    curl -fLo ${XDG_CONFIG}/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function install_go {
    curl -OL "https://golang.org/dl/go${GOVERSION}.linux-amd64.tar.gz"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xvf "go${GOVERSION}.linux-amd64.tar.gz"
    export PATH=${PATH}:/usr/local/go/bin
    go version
}

function install_kubectl {
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    chmod +x kubectl
    mv ./kubectl ${XDG_CONFIG}/bin/kubectl
    kubectl version --client
}

function install_docker {
    sudo apt-get remove docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc
		sudo mkdir -p /etc/apt/keyrings
		sudo rm /etc/apt/keyrings/docker.gpg || true
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    refresh_repos
		sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

function link_dotfiles() {
    echo "LINK! LINK!"

    local HOME_DIR_FILES=(.bashrc .bash_alias .editorconfig .gitignore .npmrc .ripgreprc .tmux.conf .bash_ps1)

    for f in "${HOME_DIR_FILES[@]}"; do
        rm ${HOME}/${f} || true
        ln -s ${SCRIPT_DIR}/${f} ${HOME}/${f}
    done

}

function configure_git() {
    gpg --full-generate-key
    # this is perfectly fine, don't worry about it
    git config --global user.signingkey "$(gpg --list-secret-keys --keyid-format=long  | grep sec | head -1 | grep --color=never -oe '/\(\w\+\)' | sed 's/\///g')"
    echo "Be sure to configure user.name and user.email as well"
}

function install() {
    mkdir -p "${WORKDIR}"
    cd "${WORKDIR}"
    install_basics
    install_node
    install_rust
    install_go
    install_docker
    install_kubectl
    link_dotfiles
    setup_virtualenvwrapper
    configure_neovim
    configure_git
}


install
