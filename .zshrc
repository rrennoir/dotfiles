# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rre/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

EDITOR='nvim'

# source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la'
alias vim='nvim'
alias ssh='kitty +kitten ssh'
alias icat='kitty +kitten icat'

# Prompt
PROMPT="[%n@%m %~]$ "

eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/powerlevel10k_lean.omp.json)"
