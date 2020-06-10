DISABLE_AUTO_TITLE=true

ZSH_THEME=gbt
# Set custom prompt
ZSH=$HOME/.oh-my-zsh
DISABLE_CORRECTION="true"
# DISABLE_UPDATE_PROMPT="true"

# Configuring history
unsetopt share_history
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_no_store

# gnome-terminal wide chars
# export VTE_CJK_WIDTH=wide

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
alias dotfiles_update="cd ~/.dotfiles; rake update; cd -"
alias meteors='meteor --settings settings.json'
alias mt='DEBUG=1 JASMINE_DEBUG=1 VELOCITY_DEBUG=1 mrt --settings settings.json'
alias node='node --harmony'
alias pacupgrade='pacaur -Syua'
alias sshcam="ssh $REMOTEHOST ffmpeg -an -f video4linux2 -s 640x480 -i /dev/video0 -r 10 -b:v 500k -f matroska - | mplayer - -idle -demuxer matroska"
alias webcamtest="mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0"
alias truefree="free -m | awk 'NR==3 {print \$4 \" MB\"}'"
alias dockerrmv="docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v"
alias dockerrmi="docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi"

# Somewhat important aliases
alias cat='bat -p'
alias pping='prettyping --nolegend'
alias preview="fzf --preview 'bat --color \"always\" {}'"
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias help='tldr'
alias man='tldr'
alias vim='nvim'

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
export EDITOR=vim
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
# export TERM=screen-256color
# set -g default-terminal "screen-256color"

# This config doesn't add spaces to the end of the line, but home/end doesn't work
# export TERM=tmux-256color
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
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# Python packages
USER_BASE_PATH=$(python -m site --user-base)
export PATH=$PATH:$USER_BASE_PATH/bin


# Java exports
# archlinux-java set java-8-openjdk/jre
export JAVA_HOME=/usr/lib/jvm/default-runtime

plugins=(git ruby bundler git-extras tmux archlinux systemd vagrant rbenv kubectl safe-paste terraform)

source $ZSH/oh-my-zsh.sh
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.exenv/bin:$PATH"

export PATH="/home/kainlite/.chefdk/gem/ruby/2.3.0/bin:$PATH"
export PATH="$HOME/.tfenv/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

# load the erlang vm manager
# source $HOME/.evm/scripts/evm

# eval "$(exenv init -)"

# Nvm
# source ~/.nvm/nvm.sh

# Add paths
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="$HOME/bin:$PATH:$HOME/Android/sdk/platform-tools"

# Cargo
source $HOME/.cargo/env

# Krew path
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

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
alias hugs="hugs -98 -E'vim'"

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

# if [[ -e '/usr/share/doc/pkgfile/command-not-found.zsh' ]]; then
#   source '/usr/share/doc/pkgfile/command-not-found.zsh'
# fi

# Allow minikube to use docker env
if pgrep -f minikube > /dev/null
then
    eval $(minikube docker-env)
fi

# Direnv
eval "$(direnv hook zsh)"

# urxvt
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Disable bell
xset -b

if [[ -z "${SSH_AUTH_SOCK}" ]]; then
  dbus-update-activation-environment --systemd DISPLAY
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
  export SSH_AUTH_SOCK
fi

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

# GBT magic
export GBT__HOME='/usr/share/gbt'
source $GBT__HOME/sources/gbts/cmd/local.sh

# GBT Configuration
# Local
alias ssh='gbt_ssh'
alias docker='gbt_docker'
export GBT_CAR_DIR_FG='40;40;40'
export GBT_CAR_DIR_BG='146;231;116'
export GBT_CAR_KUBECTL_FORMAT='{{ Namespace }} {{ Icon }} {{ Context }} '
export GBT_CAR_GIT_STATUS_CLEAN_FG='light_green'
export GBT_CAR_DIR_DEPTH='9999'
export GBT_CARS='Status, Os, Hostname, Dir, Git, Kubectl, Sign'

# Remote
export GBT__THEME_REMOTE_CARS='Status, Os, Hostname, Dir, Git, Sign'
export GBT__AUTO_ALIASES='0'
