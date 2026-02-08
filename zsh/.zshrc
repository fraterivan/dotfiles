# Auto-source all .zsh config files
for file in ~/.zsh/*.zsh; do
  [[ -f "$file" ]] && source "$file"
done

# Load Starship prompt
eval "$(starship init zsh)"

# Launch fastfetch (only in login shells, not in VS Code/IDEs)
if [[ -o login ]] && [[ -z "$VSCODE_INJECTION" ]] && [[ -z "$TERMINAL_EMULATOR" ]]; then
  fastfetch -c ~/.config/fastfetch/small.jsonc
fi
