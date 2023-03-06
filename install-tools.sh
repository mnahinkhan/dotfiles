# If OS is ubuntu install exa and autojump


if [ -f /etc/os-release ] && [ "$(grep -c "Ubuntu" /etc/os-release)" -ne 0 ]; then

    # Source: https://lindevs.com/install-exa-on-ubuntu
    sudo apt update
    sudo apt install -y unzip
    EXA_VERSION=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
    curl -Lo exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip"
    sudo unzip -q exa.zip bin/exa -d /usr/local
    rm -rf exa.zip

    # Source: https://github.com/wting/autojump
    # OMZ plugin should help with making 'j' work
    sudo apt-get install -y autojump

fi
