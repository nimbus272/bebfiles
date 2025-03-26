#Start Command#####
fastfetch
###################

# oh-my-zsh should stay at top
ZSH="$HOME/.oh-my-zsh"
#Plugins
plugins=(
  git
  z
  docker
  node
  npm
  archlinux
  cp
  firewalld
  docker-compose
  pip
  uv
  python
  starship
  httpie
  sdk
  golang
  fnm
  you-should-use
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-vi-mode
  zsh-system-clipboard
)
# shellcheck source=/dev/null
source $ZSH/oh-my-zsh.sh
# source $ZSH_CUSTOM/plugins/zsh-system-clipboard.zsh

autoload -Uz compinit
compinit
##############################

#ENV vars
# export ZSH_SYSTEM_CLIPBOARD_METHOD=xcc
export ZVM_VI_INSERT_ESCAPE_BINDKEY=kj
export ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
export GEM_HOME="$HOME/.local/share/gem/ruby/3.0.0"
export MANGOHUD=1
export EDITOR="/usr/bin/nvim"
#Uncomment below if you need GO path set e.g. using chai binary installed to particular directory
# export GOPATH="$HOME/go"
# export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

#PATH exports
export PATH="$PATH:$HOME/.spicetify"
export PATH="$PATH:$GEM_HOME/bin"
export PATH="$PATH:$HOME/scripts"
export PATH="$PATH:$HOME/.local/bin" # for user-installed apps from package managers like pipx
export PATH="$PATH:$HOME/.cargo/bin" # same as above but for cargo apps
export PATH="$PATH:$HOME/go/bin"     # same as above but for go apps

#Evals
eval "$(thefuck --alias)"
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(starship init zsh)"

#Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ls="eza -1la --icons=always --hyperlink --git-repos --no-time --group-directories-first --no-permissions --header"
alias lappy-ssh="ssh 10.0.0.45" #Use with '-l {username}'
alias todo="nvim $HOME/Documents/BebNotes/BebNotes/Todo-List.md"
alias obsidian="nvim $HOME/Documents/BebNotes/BebNotes/"
alias ollama-start="systemctl start ollama.service"
alias nvm="fnm"
alias neovim="wezterm start --always-new-process -- neovim"
alias posting="uv tool run posting"
alias ollama-ui="DATA_DIR=~/.open-webui uvx --python 3.11 open-webui@latest serve"

# VI MODE STUFF###################################
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
##############################################

#Lazy Load SDKMAN################
export SDKMAN_DIR="$HOME/.sdkman"
function sdk() {
  unset -f sdk
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}
###################################

#PyEnv######
export PYENV_ROOT="$HOME/.pyenv"
function pyenv() {
  unset -f pyenv
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(command pyenv init -)"
  pyenv "$@"
}
############

#Yazi#########
#Open Yazi with 'y', navigate and exit with 'q' changes cwd
#Exit with 'Q' returns to original dir
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd" || exit
  fi
  rm -f -- "$tmp"
}
#############
