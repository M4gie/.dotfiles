# dotfiles

Personal macOS dotfiles with Homebrew package management and system defaults.

## Usage

Run the bootstrap script:

```bash
bash ~/.dotfiles/setup
```

This will:

- Install Oh My Zsh (if needed)
- Symlink `.gitconfig` and `.zshrc`
- Install Homebrew (if needed)
- Install packages from `install/Brewfile`
- Install Node.js LTS via Volta
- Apply macOS defaults from `macos/defaults.sh`
- Apply Dock layout from `macos/dock.sh`

## Installed with Homebrew

- `nano`
- `jq`
- `python`
- `volta`
- `git`
- `dockutil`
- `font-fira-code`
- `slack`
- `proton-pass`
- `proton-drive`
- `vlc`
- `obsidian`
- `vivaldi`

## macOS Defaults

- Auto-hide Dock enabled
- Dock recents disabled
- Battery percentage enabled
- New documents save to disk by default
- Finder shows hidden files and path bar
- Screenshots saved to `~/Screenshots`
- Locale/language/computer name defaults set
- Safari password autofill and password saving prompts disabled
