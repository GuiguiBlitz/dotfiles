#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

load_brew_env() {
  for d in /home/linuxbrew/.linuxbrew /opt/homebrew /usr/local; do
    if [[ -x "$d/bin/brew" ]]; then
      eval "$("$d/bin/brew" shellenv bash)"
      return
    fi
  done

  echo "brew was installed but shellenv could not be loaded" >&2
  exit 1
}

install_chezmoi() {
  if command -v chezmoi >/dev/null 2>&1; then
    return
  fi

  brew install chezmoi
}

main() {
  install_homebrew
  load_brew_env
  install_chezmoi

  chezmoi init --apply --force --source="$SCRIPT_DIR"
}

main "$@"
