ZSH="/home/bebbis/.oh-my-zsh"

#Theme
ZSH_THEME=""

#Plugins
plugins=(git zsh-autosuggestions z docker node npm archlinux dnf cp firewalld fzf docker-compose nvm pip python starship sudo yarn yum you-should-use)
source $ZSH/oh-my-zsh.sh

#Star Ship
eval "$(starship init zsh)"