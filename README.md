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

* install and set fish as default shell
* [install starship] add `eval "$(starship init bash)"`
* [install uv]
* see <https://natelandau.com/managing-dotfiles-with-chezmoi/>

[chezmoi]: https://www.chezmoi.io/
[install starship]: https://starship.rs/guide/#%F0%9F%9A%80-installation
[install uv]: https://docs.astral.sh/uv/getting-started/installation/
