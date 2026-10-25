# Loads goenv's fish integration the first time goenv runs, because
# `goenv init` takes about 0.5 s. Its shims are already on PATH from
# config.fish, so `go` works without it; only goenv's own commands such as
# `goenv shell` need the function it defines.
function goenv
  functions --erase goenv
  source (command goenv init - | psub)
  goenv $argv
end
