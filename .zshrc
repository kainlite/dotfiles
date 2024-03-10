# zmodload zsh/zprof

DISABLE_AUTO_TITLE=true

# Patch for alacritty on wayland :shrug:
WINIT_UNIX_BACKEND=x11

# Set custom prompt
ZSH=$HOME/.oh-my-zsh
DISABLE_CORRECTION="true"

# Configuring history
unsetopt share_history
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_no_store

# Initialize completion
autoload -Uz compinit
compinit
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(expand-or-complete)

# Added slash when changing dirs
zstyle ':completion:*' special-dirs true

# Colorize terminal
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

# Some aliases
alias ls='ls -G'
alias ll='ls -lG'
alias gadd='git add --all .'
alias gc='git commit -S '
alias git='LANGUAGE=en_US.UTF-8 git'
alias glog='git log --graph --color'
alias glogs='git log --stat --color -p'
alias node='node --harmony'
alias pacupgrade='pacaur -Syua'
alias sshcam="ssh $REMOTEHOST ffmpeg -an -f video4linux2 -s 640x480 -i /dev/video0 -r 10 -b:v 500k -f matroska - | mplayer - -idle -demuxer matroska"
alias webcamtest="mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0"
alias truefree="free -m | awk 'NR==3 {print \$4 \" MB\"}'"
alias dockerrmv="docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v"
alias dockerrmi="docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi"
alias update_submodules="cd ~/.dotfiles && git pull --recurse-submodules"

# Somewhat important aliases
alias cat='bat -p'
alias preview="fzf --preview 'bat --color \"always\" {}'"
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
alias vim='nvim'
export ERL_AFLAGS="-kernel shell_history enabled"

# Nicer history
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.history"

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Use vim as the editor
export EDITOR=nvim
# GNU Screen sets -o vi if EDITOR=vi, so we have to force it back.
set -o vi

# Use C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

# Highlight search results in ack.
export ACK_COLOR_MATCH='red'

# Aliases
function mcd() { mkdir -p $1 && cd $1 }
function cdf() { cd *$1*/ } # stolen from @topfunky

# Autostart tmux
set -g xterm-keys on

# This config doesn't add spaces to the end of the line, but home/end doesn't work
export ZSH_TMUX_TERM=tmux-256color
set -g default-terminal "tmux-256color"
ZSH_TMUX_AUTOSTART="true"

function up()
{
    local DIR=$PWD
    local TARGET=$1
    while [ ! -e $DIR/$TARGET -a $DIR != "/" ]; do
        DIR=$(dirname $DIR)
    done
    test $DIR != "/" && echo $DIR/$TARGET
}

alias vim="stty stop '' -ixoff ; nvim"
alias vims="stty stop '' -ixoff ; nvim -S ~/.dotfiles/Session.vim"
alias vimrc="nvim ~/.vimrc"
alias zshrc="nvim ~/.zshrc"

# `Frozing' tty, so after any command terminal settings will be restored
ttyctl -f

# Initialize VM
export NPM_PACKAGES="${HOME}/.npm"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$NODE_PATH

# Python packages
USER_BASE_PATH=$(python -m site --user-base)
export PATH=$PATH:$USER_BASE_PATH/bin

# Java exports
# archlinux-java set java-8-openjdk/jre
export JAVA_HOME=/usr/lib/jvm/default-runtime

plugins=(asdf git git-extras tmux archlinux systemd vagrant kubectl safe-paste terraform)

source $ZSH/oh-my-zsh.sh

# Tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

# Nvm
source ~/.nvm/nvm.sh

# Add paths
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}

# Cargo
source $HOME/.cargo/env
export PATH="$HOME/.cargo/bin:$PATH"

# Mamba
source /opt/mambaforge/etc/profile.d/conda.sh

# Go path
export GOPATH=$HOME/Webs/go
export PATH=$PATH:$GOPATH/bin

# Gpg
export GNUPGHOME="$HOME/.gnupg"

# copy aliases
alias ccopy="xclip -sel clip"
alias cpaste="xclip -sel clip -o"
alias s="screen"
alias sr="screen -r"
alias hugs="hugs -98 -E'nvim'"

# Restore the last backgrounded task with Ctrl-V
function foreground_task() {
  fg
}

# Define a widget called "run_info", mapped to our function above.
zle -N foreground_task

# Bind it to ESC-i.
bindkey "\Cv" foreground_task

# Back and forth history search for current command (fix for tmux)
bindkey "${terminfo[kcuu1]}" up-line-or-search
bindkey "${terminfo[kcud1]}" down-line-or-search
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Move in the shell with arrows
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Custom functions
c() { cd ~/Webs/$1; }
_c() { _files -W ~/Webs -/; }
compdef _c c

# Allow minikube to use docker env
if pgrep -f minikube > /dev/null
then
    eval $(minikube docker-env)
fi

# Direnv
eval "$(direnv hook zsh)"

# Disable bell
xset -b

if [[ -z "${SSH_CONNECTION}" ]]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

export PATH=$PATH:~/.nix-profile/bin

eval "$(starship init zsh)"

# zprof
