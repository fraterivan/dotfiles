# Enable completion system
autoload -Uz compinit && compinit

# Case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Arrow-key menu selection
zstyle ':completion:*' menu select
