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
plugins=(git colored-man-pages zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# export PATH="~/bin:$PATH"

# Investigate these two
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

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
# export GPG_TTY=$(tty)

# Aliases. Consider refactoring
alias e="exa -alh"
alias dc="cd"
alias top10="history 1 | awk '{\$1=\"\"; print substr(\$0,2)}' | sort | uniq -c | sort -n | tail -n 10"
alias tldrfails="cat ~/.zsh_history | grep 'tldr' | cut -c 16- | grep '^tldr' | xargs -I _ sh -c 'echo _;_' | rg -B1 'exist yet'"

# Functions
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