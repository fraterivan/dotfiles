HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS      # No consecutive duplicates
setopt HIST_IGNORE_ALL_DUPS  # Remove older duplicate
setopt SHARE_HISTORY         # Share across sessions
setopt HIST_REDUCE_BLANKS    # Trim whitespace
setopt INC_APPEND_HISTORY    # Write immediately, don't wait for shell exit
