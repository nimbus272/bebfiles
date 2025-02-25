#Start Command#####
fastfetch
###################

# oh-my-zsh should stay at top
ZSH="/home/bebbis/.oh-my-zsh"
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
)
# shellcheck source=/dev/null
source $ZSH/oh-my-zsh.sh

autoload -Uz compinit
compinit
##############################

#PATH exports
export PATH=$PATH:/home/bebbis/.spicetify
export PATH="$PATH:$GEM_HOME/bin"
export PATH="$PATH:/home/bebbis/scripts"
export PATH="$PATH:/home/bebbis/.local/bin" # for user-installed apps from package managers like pipx
export PATH="$PATH:/home/bebbis/.cargo/bin" # same as above but for cargo apps

#ENV vars
export ZVM_VI_INSERT_ESCAPE_BINDKEY=kj
export ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
export GEM_HOME="/home/bebbis/.local/share/gem/ruby/3.0.0"
export MANGOHUD=1
export EDITOR="/usr/bin/nvim"
#Uncomment below if you need GO path set e.g. using chai binary installed to particular directory
# export GOPATH="/home/bebbis/go"
# export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

#Evals
eval "$(thefuck --alias)"
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(starship init zsh)"

#Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ls="eza -1la --icons=always --hyperlink --git-repos --no-time --group-directories-first --no-permissions --header"
alias lappy-ssh="ssh 10.0.0.45 -l bebbis" #TODO figure out how to get this outta here, maybe wezterm or something?
alias todo="nvim /home/bebbis/Documents/BebNotes/BebNotes/Todo-List.md"
alias obsidian="nvim /home/bebbis/Documents/BebNotes/BebNotes/"
alias ollama-start="systemctl start ollama.service"
alias nvm="fnm"
alias neovim="wezterm start --always-new-process -- neovim"

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
