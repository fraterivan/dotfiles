#!/usr/bin/env bash
set -euo pipefail

# Adopt a config file into the dotfiles repo as a Stow package
# Usage: dotfiles-add <package-name> <config-file-path>
# Example: dotfiles-add bat ~/.config/bat/config

if [[ $# -ne 2 ]]; then
  echo "Usage: dotfiles-add <package-name> <config-file-path>"
  echo "Example: dotfiles-add bat ~/.config/bat/config"
  exit 1
fi

pkg="$1"
src="$2"

# Resolve to absolute path
src="${src/#\~/$HOME}"

if [[ ! -f "$src" ]]; then
  echo "Error: $src is not a file"
  exit 1
fi

# Compute path relative to home
rel="${src#"$HOME"/}"
if [[ "$rel" == "$src" ]]; then
  echo "Error: $src is not under \$HOME"
  exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
dest="$DOTFILES_DIR/$pkg/$rel"
dest_dir="$(dirname "$dest")"

mkdir -p "$dest_dir"
mv "$src" "$dest"
echo "Moved $src -> $dest"

# Stow the package to create symlink
cd "$DOTFILES_DIR" && stow -t ~ "$pkg"
echo "Stowed package '$pkg' — symlink created"
