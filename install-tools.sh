# Install various tools I need, based on OS detected


# Ubuntu
if [ -f /etc/os-release ] && [ "$(grep -c "Ubuntu" /etc/os-release)" -ne 0 ]; then

    # exa (nice ls)
    if ! command -v exa > /dev/null 2>&1; then
        # Source: https://lindevs.com/install-exa-on-ubuntu
        sudo apt update
        sudo apt install -y unzip
        EXA_VERSION=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
        curl -Lo exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip"
        sudo unzip -q exa.zip bin/exa -d /usr/local
        rm -rf exa.zip
    fi

    # bat (nice cat)
    if ! command -v bat > /dev/null 2>&1; then
        sudo apt install -y bat
        mkdir -p ~/.local/bin
        ln -s /usr/bin/batcat ~/.local/bin/bat
    fi

    # autojump (nice cd)
    if ! command -v autojump > /dev/null 2>&1; then
        # Source: https://github.com/wting/autojump
        # OMZ plugin should help with making 'j' work
        sudo apt-get install -y autojump
    fi

    # make
    if ! command -v make > /dev/null 2>&1; then
        sudo apt-get install -y build-essential
    fi


    # zsh
    if ! command -v zsh > /dev/null 2>&1; then
        sudo apt-get install -y zsh
    fi

    # conda (help set python versions)
    if ! command -v conda > /dev/null 2>&1; then
        wget --output-document miniconda-installer.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_23.1.0-1-Linux-x86_64.sh
        bash ./miniconda-installer.sh -b -p $HOME/miniconda
        eval "$($HOME/miniconda/bin/conda shell.zsh hook)"
        conda init zsh
        rm miniconda-installer.sh
    fi

    # git-delta
    if ! command -v delta > /dev/null 2>&1 ; then
        conda install git-delta -c conda-forge
    fi

    # gh
    if ! command -v gh > /dev/null 2>&1; then
        type -p curl >/dev/null || sudo apt install curl -y
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
        && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
        && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
        && sudo apt update \
        && sudo apt install gh -y
    fi

    # node (useful for vim stuff)
    if ! command -v node > /dev/null 2>&1; then
        # From: https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04
        curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
        sudo bash /tmp/nodesource_setup.sh  # be careful
        sudo apt install -y nodejs
        rm /tmp/nodesource_setup.sh
    fi


fi
