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

* [install uv]
* [install gh]
* [install goenv] and use `source (goenv init - | psub)` in ~/.config/fish/config.fish
* see <https://natelandau.com/managing-dotfiles-with-chezmoi/>

[chezmoi]: https://www.chezmoi.io/
[install uv]: https://docs.astral.sh/uv/getting-started/installation/
[install gh]: https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian-ubuntu-linux-raspberry-pi-os-apt
[install goenv]: https://github.com/go-nv/goenv/blob/master/INSTALL.md
