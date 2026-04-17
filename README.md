# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quickstart — apply on a new system

### 1. Install Homebrew (if not already installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After the install, follow the instructions printed at the end to add `brew` to your `PATH` (usually `eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"`).

### 2. Install chezmoi and apply the dotfiles

```bash
brew install chezmoi
chezmoi init --apply GuiguiBlitz
```

This will:
- clone this repo to `~/.local/share/chezmoi`
- apply all dotfiles to your home directory
- run the `run_onchange_after_*` scripts, which install all packages from the `Brewfile`

---

## Updating config from your main machine

### Add or edit a dotfile

```bash
# Edit an existing managed file (opens it and re-applies on save)
chezmoi edit ~/.bashrc

# Or add a new file to be tracked
chezmoi add ~/.config/some/new/file

# Review what would change before applying
chezmoi diff

# Apply pending changes
chezmoi apply
```

### Add a new Brew package

1. Install it locally: `brew install <package>`
2. Add it to the `Brewfile` in the chezmoi source dir:
   ```bash
   chezmoi edit ~/.local/share/chezmoi/Brewfile   # or just open it directly
   ```
3. Commit and push:
   ```bash
   chezmoi cd
   git add Brewfile
   git commit -m "feat: add <package>"
   git push
   ```

> The `run_onchange_after_install-packages.sh.tmpl` script re-runs `brew bundle` automatically whenever the `Brewfile` changes (chezmoi detects it via its sha256 hash).

### Push changes to the repo

```bash
chezmoi cd          # jumps into ~/.local/share/chezmoi
git add -A
git commit -m "..."
git push
```

### Pull latest config on another machine

```bash
chezmoi update      # git pull + apply in one command
```
