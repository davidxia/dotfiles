# Prints the nearest .nvmrc at or above the current directory, like nvm.sh's
# nvm_find_nvmrc without the cost of loading nvm.sh through bass.
function nvm_find_nvmrc
  set -l dir $PWD
  while true
    if test -f $dir/.nvmrc
      echo $dir/.nvmrc
      return
    end
    test "$dir" = /; and return 1
    set dir (path dirname $dir)
  end
end
