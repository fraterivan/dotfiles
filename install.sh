#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
fi
echo "Running brew bundle..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Stow
backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
backed_up=false

for dir in "$DOTFILES_DIR"/*/; do
  pkg="${dir%/}"
  pkg="${pkg##*/}"
  [[ "$pkg" == .* ]] && continue

  # Back up real files that would conflict
  conflicts=$(cd "$DOTFILES_DIR" && stow -n -t "$HOME" "$pkg" 2>&1 | grep "existing target" || true)
  if [[ -n "$conflicts" ]]; then
    while IFS= read -r line; do
      target=$(echo "$line" | sed 's/.*existing target is neither a link nor a directory: //')
      full="$HOME/$target"
      if [[ -e "$full" && ! -L "$full" ]]; then
        mkdir -p "$backup_dir/$(dirname "$target")"
        mv "$full" "$backup_dir/$target"
        echo "Backed up ~/$target"
        backed_up=true
      fi
    done <<< "$conflicts"
  fi

  stow --restow -t "$HOME" -d "$DOTFILES_DIR" "$pkg"
  echo "Linked $pkg"
done

$backed_up && echo "Backups in $backup_dir"

# macOS defaults
bash "$DOTFILES_DIR/macos.sh"

echo "Done — restart to pick up all changes."
