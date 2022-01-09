# Allow local customizations in the ~/.zshrc_local_before file
if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local_before
fi

# If tmux exists, the shell is interactive, and we aren't already in
# tmux, start tmux or attach to the "driver" session
# From: https://unix.stackexchange.com/a/113768
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s driver
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"


# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages zsh-autosuggestions zsh-syntax-highlighting docker docker-compose kubectl)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/bin:$PATH"

# Investigate these two
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# locale settings (helps with Mosh https://github.com/mobile-shell/mosh/issues/793#issuecomment-605407244)
export LC_CTYPE="en_US.UTF-8"

# Settings to help vim show emojis...
export LANGUAGE="en"
export LANG="C"
export LC_MESSAGES="C"


# Don't store commands starting with a space
setopt HIST_IGNORE_SPACE

# Vim setttings
export EDITOR=vim
bindkey -v

# Ctrl+j to accept autocomplete suggestion
bindkey '^j' autosuggest-accept


# One of these two works!
export TERM=xterm-256color
# export TERM=screen-256color

# if fzf is installed load it
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# If GPG stops working try this
export GPG_TTY=$TTY

# Bat theme
export BAT_THEME="Solarized (light)"


# Aliases. Consider refactoring
# alias e="exa -alh"
alias docker="sudo docker"
alias docker-compose="sudo docker-compose"
alias dc="cd"
alias rgg="batgrep"
alias top10="history 1 | awk '{\$1=\"\"; print substr(\$0,2)}' | sort | uniq -c | sort -n | tail -n 10"
alias tldrfails="cat ~/.zsh_history | grep 'tldr' | cut -c 16- | grep '^tldr' | xargs -I _ sh -c 'echo _;_' | rg -B1 'exist yet'"
alias k=kubectl
alias kx=kubectx
complete -F __start_kubectl k

# FZF stuff
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    *)            fzf "$@" --preview 'bat --style=numbers --color=always --line-range :500 {}' ;;
    # *)            fzf "$@" ;;
  esac
}

export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi --history=$HOME/.fzf_history"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


# Functions
e() {
    for arg in "$@"
    do
        e-helper "$arg"
    done
    if [ $# -eq 0 ]; then
        e .
    fi
}

e-helper() {
    if [ $# -ne 1 ]; then
        echo "Error!"
        exit(1);
    fi

    if [ -f "$1" ]; then
        bat "$1"
    else
        exa -alh --git --icons "$1"
    fi
}

add-vim-plugins() {
    if ! cd ~/.vim/pack/vendor/start; then
      return
    fi
    for repo in ./*
    do
        echo $repo
        git submodule add $(cd $repo && git remote get-url origin)
    done
    cd -
}

colors() {
    for R in $(seq 0 20 255); do
        for G in $(seq 0 20 255); do
            for B in $(seq 0 20 255); do
                printf "\e[38;2;${R};${G};${B}m█\e[0m";
            done
        done
    done
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Allow local customizations in the ~/.zshrc_local_after file
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi
