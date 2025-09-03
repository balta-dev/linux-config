#!/bin/bash
# -----------------------------------
# linux-config/install.sh
# -----------------------------------
# Script para instalar dotfiles de Zsh y Powerlevel10k
# Crea symlinks y asegura que los plugins estén listos
# -----------------------------------

set -e  # Salir si hay error
DOTFILES_DIR="$HOME/linux-config"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

echo "🚀 Instalando dotfiles desde $DOTFILES_DIR..."

# -------------------------------
# 1. Symlinks
# -------------------------------
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
echo "✅ Symlink creado: .zshrc"

[ -f "$DOTFILES_DIR/.p10k.zsh" ] && ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh" && echo "✅ Symlink creado: .p10k.zsh"

# -------------------------------
# 2. Instalar Oh My Zsh si no existe
# -------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "✅ Oh My Zsh ya instalado"
fi

# -------------------------------
# 3. Instalar plugins
# -------------------------------
echo "📦 Instalando plugins de Zsh..."
mkdir -p "$ZSH_CUSTOM/plugins"

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    echo "✅ zsh-autosuggestions instalado"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    echo "✅ zsh-syntax-highlighting instalado"
fi

# -------------------------------
# 4. Mensaje final
# -------------------------------
echo "🎉 Dotfiles instalados correctamente!"
echo "Abre una nueva terminal o ejecuta 'source ~/.zshrc' para cargar la configuración"
