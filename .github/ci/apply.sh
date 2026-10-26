#!/bin/bash
# Applies the dotfiles for a new user in a fresh Ubuntu or Oracle Linux
# container, then checks that the shells start cleanly and lints the rendered
# files. Runs as root, then reruns itself as the new user with the argument
# "user". Passes GITHUB_TOKEN through to chezmoi, which uses it for GitHub API
# calls.
set -euo pipefail

if [ "${1:-}" = user ]; then
  cd ~
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
  ~/.local/bin/chezmoi init --apply --no-tty --promptString "Work email=ci@example.com" </dev/null
  if ! ~/.local/bin/chezmoi verify; then
    ~/.local/bin/chezmoi diff --no-pager
    exit 1
  fi

  # On Linux, the login shell stays bash and ~/.bashrc execs fish.
  login="$(echo 'echo "$(status fish-path) $version"' | bash -li 2>/dev/null)"
  echo "bash login runs: $login"
  [[ "$login" == "$HOME/.local/bin/fish 4."* ]]

  for cmd in "bash -lc true" "$HOME/.local/bin/fish -ic exit"; do
    err="$($cmd </dev/null 2>&1 >/dev/null)"
    if [ -n "$err" ]; then
      printf '%s wrote to stderr:\n%s\n' "$cmd" "$err" >&2
      exit 1
    fi
  done

  ~/.local/bin/uv tool install --quiet shellcheck-py
  mkdir rendered
  ~/.local/bin/chezmoi archive --exclude externals --format tar | tar -x -C rendered
  PATH="$HOME/.local/bin:$PATH" ~/.local/share/chezmoi/.github/ci/lint.sh rendered
  exit
fi

. /etc/os-release
case "$ID" in
  ubuntu)
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -qq
    apt-get install --yes -qq --no-install-recommends ca-certificates curl git sudo >/dev/null
    ;;
  ol)
    dnf install --assumeyes --quiet git sudo >/dev/null
    ;;
esac

# Containers have no systemd, so snapd can't run. Stub snap and systemctl, and
# put the stubs on sudo's PATH. chezmoi, the only snap, comes from get.chezmoi.io.
for cmd in snap systemctl; do
  printf '#!/bin/sh\nexit 0\n' >/usr/local/bin/"$cmd"
  chmod +x /usr/local/bin/"$cmd"
done
useradd --create-home --shell /bin/bash u
cat >/etc/sudoers.d/ci <<'EOF'
Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
u ALL=(ALL) NOPASSWD:ALL
EOF
mkdir -p /home/u/.local/share
cp -a "$(cd "$(dirname "$0")/../.." && pwd)" /home/u/.local/share/chezmoi
chown -R u:u /home/u/.local

sudo -u u -H --preserve-env=GITHUB_TOKEN /home/u/.local/share/chezmoi/.github/ci/apply.sh user
