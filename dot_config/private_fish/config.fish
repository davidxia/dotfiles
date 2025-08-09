fish_config theme choose my

# needed to use gpg-agent for SSH
if status --is-interactive
  set -x GPG_TTY (tty)
  # Only needed on local workstation
  # set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
end
