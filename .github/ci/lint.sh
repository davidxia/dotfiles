#!/bin/bash
# Lints the shell and fish files in a rendered target state, as extracted from
#   chezmoi archive --exclude externals --format tar | tar -x -C DIR
# Usage: lint.sh DIR
set -euo pipefail
cd "$1"

shellcheck --severity=warning --shell=bash .chezmoiscripts/*.sh .bashrc .bash_profile
shellcheck --severity=warning --shell=sh .profile .config/shell/env.sh
find .config/fish -name '*.fish' -print0 | xargs -0 -n 1 fish --no-execute
echo "lint passed"
