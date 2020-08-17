# if starship is on the path initialize starship
if hash starship 2>/dev/null; then
  eval "$(starship init bash)"
fi
