export ZOXIDE_CMD_OVERRIDE="cd"
#Start Command#####
fastfetch
###################

# oh-my-zsh should stay at top
ZSH="$HOME/.oh-my-zsh"
#Plugins
plugins=(
  git
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
  zoxide
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-vi-mode
)
# shellcheck source=/dev/null
source "$ZSH/oh-my-zsh.sh"

autoload -Uz compinit
compinit
##############################

#ENV vars
export ZVM_VI_INSERT_ESCAPE_BINDKEY=kj
export ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
export GEM_HOME="$HOME/.local/share/gem/ruby/3.0.0"
export MANGOHUD=1
export EDITOR="/usr/bin/nvim"
export SDL_HINT_GAMECONTROLLER_USE_BUTTON_LABELS=0
# export JAVA_HOME="$HOME/.sdkman/candidates/java/21.0.7-tem"
# export MAVEN_HOME="$HOME/.sdkman/candidates/maven/current/bin"
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
# export PATH="$PATH:$JAVA_HOME/bin"
# export PATH="$PATH:$MAVEN_HOME"

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
alias gswu=switch_upstream
alias rm="rm -i"

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

#ZSH-VI-MODE###############
my_zvm_vi_yank() {
  zvm_vi_yank
  echo -en "${CUTBUFFER}" | wl-copy -n
  zvm_exit_visual_mode
}

my_zvm_vi_delete() {
  zvm_vi_delete
  echo -en "${CUTBUFFER}" | wl-copy -n
}

my_zvm_vi_change() {
  zvm_vi_change
  echo -en "${CUTBUFFER}" | wl-copy -n
}

my_zvm_vi_change_eol() {
  zvm_vi_change_eol
  echo -en "${CUTBUFFER}" | wl-copy -n
}

my_zvm_vi_put_after() {
  CUTBUFFER=$(wl-paste)
  zvm_vi_put_after
  zvm_highlight clear # zvm_vi_put_after introduces weird highlighting for me
}

my_zvm_vi_put_before() {
  CUTBUFFER=$(wl-paste)
  zvm_vi_put_before
  zvm_highlight clear # zvm_vi_put_before introduces weird highlighting for me
}

zvm_after_lazy_keybindings() {
  zvm_define_widget my_zvm_vi_yank
  zvm_define_widget my_zvm_vi_delete
  zvm_define_widget my_zvm_vi_change
  zvm_define_widget my_zvm_vi_change_eol
  zvm_define_widget my_zvm_vi_put_after
  zvm_define_widget my_zvm_vi_put_before

  zvm_bindkey visual 'y' my_zvm_vi_yank
  zvm_bindkey visual 'd' my_zvm_vi_delete
  zvm_bindkey visual 'x' my_zvm_vi_delete
  zvm_bindkey vicmd 'C' my_zvm_vi_change_eol
  zvm_bindkey visual 'c' my_zvm_vi_change
  zvm_bindkey vicmd 'p' my_zvm_vi_put_after
  zvm_bindkey vicmd 'P' my_zvm_vi_put_before
}
###########################

function switch_upstream() {
  # Get current upstream branch
  local current_upstream="$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)"

  # Check if upstream exists
  if [[ -z "$current_upstream" ]]; then
    echo "Error: No upstream branch set."
    return 1
  fi

  # Split into remote and branch name
  local current_remote="${current_upstream%%/*}"
  local branch_name="${current_upstream#*/}"

  # Determine target remote
  local target_remote
  case "$current_remote" in
  "origin") target_remote="gutter" ;;
  "gutter") target_remote="origin" ;;
  *)
    echo "Error: Unexpected remote '$current_remote'"
    return 1
    ;;
  esac

  # Set new upstream
  git branch --set-upstream-to="$target_remote/$branch_name" >/dev/null

  # Verify and print result
  echo "Switched upstream from $current_remote/$branch_name to $target_remote/$branch_name"
}
