# Switches Node to the version in the nearest .nvmrc, or to nvm's default
# outside projects with one. An exact version that's already installed is
# switched to by editing PATH, because each nvm call loads nvm.sh through bass
# and takes about 200 ms. Aliases like lts/*, partial versions, and versions
# that need installing go through nvm.
function load_nvm --on-variable="PWD"
  set -l nvm_dir $HOME/.nvm
  set -l nvmrc_path (nvm_find_nvmrc)
  set -l wanted default
  if test -n "$nvmrc_path"
    # .nvmrc may have comments and blank lines around the version.
    set wanted (string replace -r '\s*#.*' '' < $nvmrc_path | string trim | string match -v '')[1]
  end
  set -l current (string match -rg '/versions/node/([^/]+)/bin$' -- "$NVM_BIN")

  set -l exact $wanted
  if test "$wanted" = default; and test -f $nvm_dir/alias/default
    set exact (string trim < $nvm_dir/alias/default)
  end
  set exact (string replace -r '^(\d)' 'v$1' -- $exact)
  if string match -qr '^v\d+\.\d+\.\d+$' -- $exact; and test -d $nvm_dir/versions/node/$exact/bin
    test "$exact" = "$current"; and return
    # Stay quiet at startup, when no nvm Node is on PATH yet.
    if test -n "$current"
      echo "Now using node $exact"
    end
    # The PATH, NVM_BIN, and NVM_INC changes `nvm use` makes.
    set -l bin $nvm_dir/versions/node/$exact/bin
    if set -l i (contains -i -- "$NVM_BIN" $PATH)
      set PATH[$i] $bin
    else
      set -gx PATH $bin $PATH
    end
    set -gx NVM_BIN $bin
    set -gx NVM_INC $nvm_dir/versions/node/$exact/include/node
    return
  end

  if test -n "$nvmrc_path"
    set -l nvmrc_node_version (nvm version $wanted)
    if test "$nvmrc_node_version" = "N/A"
      nvm install $wanted
      # nvm doesn't enable corepack, so new Node versions lack pnpm.
      if type -q corepack
        corepack enable pnpm
      end
    else if test "$nvmrc_node_version" != "$current"
      nvm use $nvmrc_node_version
    end
  else if test -f $nvm_dir/alias/default
    # Without a default, there's no Node to revert to.
    set -l default_version (nvm version default)
    if test "$default_version" != N/A; and test "$default_version" != "$current"
      echo "Reverting to default Node version"
      nvm use default
    end
  end
end
