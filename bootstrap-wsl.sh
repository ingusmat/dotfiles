#!/usr/bin/env bash
# Bootstrap script for WSL (Ubuntu/Debian)
# Clones dotfiles, installs dependencies, symlinks configs.
set -e

DOTFILES_REPO="https://github.com/ingusmat/dotfiles.git"
DOTFILES_DIR="$HOME/.config"

echo "==> Updating apt..."
sudo apt-get update -q

echo "==> Installing base packages..."
sudo apt-get install -y -q \
  zsh git curl wget unzip ripgrep fd-find fzf build-essential \
  python3 python3-pip nodejs npm

# fd-find installs as 'fdfind' on Ubuntu; alias it
if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
  mkdir -p "$HOME/.local/bin"
  ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
fi

echo "==> Installing Neovim (latest stable AppImage)..."
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
curl -fsSL "$NVIM_URL" -o /tmp/nvim.tar.gz
sudo tar -C /opt -xzf /tmp/nvim.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm /tmp/nvim.tar.gz

echo "==> Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "==> Cloning dotfiles..."
if [ -d "$DOTFILES_DIR/.git" ]; then
  echo "    Already cloned, pulling..."
  git -C "$DOTFILES_DIR" pull
else
  # Back up anything already at ~/.config
  [ -d "$DOTFILES_DIR" ] && mv "$DOTFILES_DIR" "${DOTFILES_DIR}.bak.$(date +%s)"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

echo "==> Symlinking shell configs..."
ln -sf "$DOTFILES_DIR/zshrc"    "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"

echo "==> Patching .zshrc for WSL (removing macOS-specific lines)..."
# Write a WSL-safe override that sources the shared zshrc but skips brew/nvm-brew
WSL_EXTRA="$HOME/.zshrc.wsl"
cat > "$WSL_EXTRA" <<'EOF'
# WSL additions — sourced after the main .zshrc

# NVM via apt/nvm-installer instead of brew
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# fd lives as 'fdfind' on Ubuntu and was symlinked to ~/.local/bin/fd
export PATH="$HOME/.local/bin:$PATH"

# Windows drive mounts shortcut
alias cdw='cd /mnt/c/Users'
EOF

# Append WSL extra sourcing to the symlinked zshrc (only once)
ZSHRC_REAL="$DOTFILES_DIR/zshrc"
if ! grep -q "zshrc.wsl" "$ZSHRC_REAL"; then
  echo "" >> "$ZSHRC_REAL"
  echo '[ -f "$HOME/.zshrc.wsl" ] && source "$HOME/.zshrc.wsl"' >> "$ZSHRC_REAL"
fi

echo "==> Installing nvm (standalone, no brew)..."
if [ ! -d "$HOME/.nvm" ]; then
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

echo "==> Changing default shell to zsh..."
sudo chsh -s "$(which zsh)" "$USER"

echo ""
echo "Done. Open a new terminal (or run: exec zsh) to start using zsh."
echo "Neovim will install plugins on first launch via lazy.nvim — just open nvim and wait."
echo ""
echo "Your Windows files are at /mnt/c/Users/<your-windows-username>/"
echo "For the project: cd /mnt/c/Users/<you>/source/repos/<white-label-web>"
