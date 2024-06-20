ZSH="/home/bebbis/.oh-my-zsh"

# Load zplug
source ~/.zplug/init.zsh

# Install plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "MichaelAquilina/zsh-you-should-use"

# Then, source plugins and check if there are plugins that have not been installed
zplug check || zplug install

zplug load

#Plugins
plugins=(git z docker node npm archlinux dnf cp firewalld docker-compose nvm pip python starship sudo yarn yum httpie zsh-sdkman)
source $ZSH/oh-my-zsh.sh

#Aliases
alias ..="cd .."
alias ...="cd ../.."


#Star Ship
eval "$(starship init zsh)"
fastfetch

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH=$PATH:/home/bebbis/.spicetify
source /usr/share/nvm/init-nvm.sh

export GEM_HOME="/home/bebbis/.local/share/gem/ruby/3.0.0"
export PATH="$PATH:$GEM_HOME/bin"
export MANGOHUD=1
export LS_COLORS="$(vivid generate catppuccin-mocha)"
