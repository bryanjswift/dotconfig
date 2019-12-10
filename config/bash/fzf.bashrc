# if both fzf and fd are installed use fd with fzf by default
if hash fd 2>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
fi
