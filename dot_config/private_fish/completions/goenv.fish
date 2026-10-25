# goenv ships fish completions, which `goenv init` would otherwise load.
if test -f $HOME/.goenv/completions/goenv.fish
  source $HOME/.goenv/completions/goenv.fish
end
