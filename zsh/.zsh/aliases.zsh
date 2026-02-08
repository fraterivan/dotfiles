# Easier navigation
alias ..="cd .."
alias ...="cd ../.."

# Shortcuts (zoxide handles smart jumping via `z`, these are for explicit paths)
alias dot="cd ~/dotfiles"
alias desk="cd ~/Desktop"
alias dev="cd ~/Developer"
alias down="cd ~/Downloads"

# Replace ls with eza
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"

# Replacements
alias c="clear"
alias cat="bat"
alias top="btop"
alias grep="rg"
alias find="fd"

# Enable aliases to be sudo'ed
alias sudo="sudo "
