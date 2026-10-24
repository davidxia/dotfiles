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

* yubikey and gpg config for macOS

see <https://natelandau.com/managing-dotfiles-with-chezmoi/>

[chezmoi]: https://www.chezmoi.io/
