if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config $HOME/dotfiles/zsh/powerlevel10k_lean.omp.json)"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Fuck vim, long live neovim
alias vim="nvim"

alias ls="ls --color=auto"
alias ll="ls -l"

if [ "$TERM" = "xterm-kitty" ]; then
    alias kssh="kitty +kitten ssh"
    alias icat="kitty +kitten icat"
fi

# ZSH auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
