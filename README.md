# Dotfiles

These dotfiles are managed with [chezmoi]. `chezmoi init --apply` prompts for a
work email, installs the packages in `.chezmoidata/packages.yaml`, and writes
the dotfiles.

## Installation

### macOS

Install [Homebrew], then:

```bash
brew install chezmoi
chezmoi init --apply davidxia
```

Homebrew can't take over apps that were installed by hand, and macOS blocks
modifying them unless the terminal has App Management permission (System
Settings > Privacy & Security > App Management). Adopt them first:

```bash
brew install --cask --adopt <cask>...
```

### Ubuntu

```bash
sudo apt update
sudo apt install --yes snapd
sudo snap install chezmoi --classic
chezmoi init --apply davidxia
```

### Oracle Linux 9

```bash
sudo dnf install --assumeyes oracle-epel-release-el9
sudo dnf config-manager --set-enabled ol9_developer_EPEL ol9_codeready_builder
sudo dnf install --assumeyes snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install chezmoi --classic
/snap/bin/chezmoi init --apply davidxia
```

## Machine-specific files

These aren't in the repo:

* `~/.ssh/config.local`: hosts to connect to. Hosts that should get the
  YubiKey's agents need `ForwardAgent ~/.gnupg/S.gpg-agent.ssh` and
  `RemoteForward /run/user/<uid>/gnupg/S.gpg-agent ~/.gnupg/S.gpg-agent.extra`.
* `~/.ssh/yubikey.pub`: the YubiKey's SSH public key, from
  `gpg --export-ssh-key <authentication subkey>`.
* A second alias for VS Code Remote-SSH, e.g. `Host modal-dev-ssm-vscode`, with
  the same settings but without the gpg-agent `RemoteForward`. Remote-SSH can
  open its own connections, and when one that forwards gpg-agent closes, it
  removes the socket the other sessions use for signing. Without the
  `RemoteForward`, VS Code sessions sign through the socket of a regular
  `ssh` session.

## TODO

* Document importing the YubiKey's GPG keys on a new Mac.

[chezmoi]: https://www.chezmoi.io/
[Homebrew]: https://brew.sh/
