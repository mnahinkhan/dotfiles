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

    # autojump (nice cd)
    if ! command -v autojump > /dev/null 2>&1; then
        # Source: https://github.com/wting/autojump
        # OMZ plugin should help with making 'j' work
        sudo apt-get install -y autojump
    fi

    # conda (help set python versions)
    if ! command -v conda > /dev/null 2>&1; then
        wget --output-document miniconda-installer.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_23.1.0-1-Linux-x86_64.sh
        bash miniconda-installer.sh
        rm miniconda-installer.sh
    fi

fi
