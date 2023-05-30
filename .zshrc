if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config $HOME/dotfiles/powerlevel10k_leanV2.omp.json)"
fi

# pfetch (with kitties) ASCII art 
export PF_ASCII="Catppuccin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export JAVA_20_HOME=$(/usr/libexec/java_home -v20)

export JAVA_HOME=$JAVA_20_HOME

# Fuck vim, long live neovim
alias vim="nvim"

alias ls="ls --color=auto"
alias ll="ls -l"

if [ "$TERM" = "xterm-kitty" ]; then
    alias kssh="kitty +kitten ssh"
    alias icat="kitty +kitten icat"
fi

# pfetch with kitties (https://github.com/andreasgrafen/pfetch-with-kitties)
alias pfetch=~/pfetch

# ZSH auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

pfetch

# fzf command history fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ZSH syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZSH Autocomplete
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi

# Kubectl autocompletions
source <(kubectl completion zsh)
