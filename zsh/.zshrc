if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config $HOME/dotfiles/zsh/powerlevel10k_lean.omp.json)"
fi

# The next line updates PATH for the Google Cloud SDK.
#if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
# if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Fuck vim, long live neovim
alias vim="nvim"

alias ls="eza --icons --group-directories-first"
alias ll="ls -l"

if [ "$TERM" = "xterm-kitty" ]; then
    alias kssh="kitty +kitten ssh"
    alias icat="kitty +kitten icat"
fi

eval "$(zoxide init zsh --cmd cd)"

# Kubectl autocompletions
#source <(kubectl completion zsh)
