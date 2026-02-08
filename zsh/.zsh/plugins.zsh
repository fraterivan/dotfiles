# Cache brew prefix (avoid repeated subprocess calls)
BREW_PREFIX="${BREW_PREFIX:-$(brew --prefix)}"

# zsh-autosuggestions (installed via Homebrew)
if [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# zsh-syntax-highlighting (installed via Homebrew, must be sourced last among plugins)
if [[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# fzf configuration (use fd for speed + .gitignore respect)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

# fzf keybindings and completions
if [[ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
  source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"
fi

# zoxide (smarter cd)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi
