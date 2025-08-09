# Dotfiles

These dotfiles are managed with [chezmoi].

## Installation

### OS X

```bash
brew install chezmoi
chezmoi init davidxia/dotfiles
chezmoi apply -v
```

### Linux

```bash
sudo apt update
sudo apt install snapd
sudo snap install chezmoi --classic
chezmoi init davidxia/dotfiles
chezmoi apply -v
```

## TODO

* create `~/src/github.com` dir
* [install uv] for macOS
* install Monaco nerdfont for macOS
* try to export and load iTerm2 profile
* [install gh] for Linux?
* install IDEs like VS Code
* yubikey and gpg config for macOS
* [install goenv] and use `source (goenv init - | psub)` in `~/.config/fish/config.fish`
* see <https://natelandau.com/managing-dotfiles-with-chezmoi/>

[chezmoi]: https://www.chezmoi.io/
[install uv]: https://docs.astral.sh/uv/getting-started/installation/
[install gh]: https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian-ubuntu-linux-raspberry-pi-os-apt
[install goenv]: https://github.com/go-nv/goenv/blob/master/INSTALL.md
