ZSH="/home/bebbis/.oh-my-zsh"

# Load zplug
source ~/.zplug/init.zsh

# Install plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "MichaelAquilina/zsh-you-should-use"

# Then, source plugins and check if there are plugins that have not been installed
zplug check || zplug install

#Plugins
plugins=(git z docker node npm archlinux dnf cp firewalld docker-compose nvm pip python starship sudo yarn yum)
source $ZSH/oh-my-zsh.sh

#Aliases
alias ..="cd .."
alias ...="cd ../.."


#Star Ship
eval "$(starship init zsh)"
neofetch
