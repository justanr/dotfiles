#!/usr/bin/env bash
GOVERSION="1.18"
if [ "$ALEC_INSTALL_DEBUG" != "" ]; then
    set -x
fi
set -u
set -e
set -o pipefail

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
        lsb-release

    tmux -V
    neovim --version
    curl --version
    pip3 --version
}

function setup_virtualenvwrapper() {
    export WORKON_HOME="${HOME}/.venvs"
    pip3 install --user virtualenvwrapper
    source /usr/local/bin/virtualenvwrapper.sh
    mkvirtualenv neovim
    pip install -r requirements.txt
}

function install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup install stable
    rustup install nightly
    rustup default stable
    rustup completions bash >> ~/.local/share/bash-completion/completions/rustup
    rustup completions bash cargo >> ~/.local/share/bash-completion/completions/cargo
}

function install_node() {
    NVM_DIR="${HOME}/.nvm"
    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    . "${NVM_DIR}/nvm.sh"
    nvm install --lts
    nvm use --lts
    npm install -g neovim typescript@latest
}

function install_go {
    curl -OL "https://golang.org/dl/go${GOVERSION}.linux-amd64.tar.gz"
    sudo tar -C /usr/local -xvf "go${GOVERSION}.linux-amd64.tar.gz"
}

function install_kubectl {
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    mkdir -p ~/.local/bin
    chmod +x kubectl
    mv ./kubectl ~/.local/bin/kubectl
    kubectl version --client
}

function install_docker {
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    refresh_repos
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    # fuck compose2
    pip3 install --user docker-compose
}

function link_dotfiles() {
    echo "LINK! LINK!"
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
    refresh_repos
    install_basics
    setup_virtualenvwrapper
    install_rust
    install_node
    link_dotfiles
}

