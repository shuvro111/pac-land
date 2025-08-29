#!/bin/bash

# --- Color Codes for Terminal Output ---
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# --- Log Functions for User-Friendly Output ---
log() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# --- Core Installation Logic ---
install_app() {
  local app_name=$1
  log "Processing app: ${CYAN}${app_name}${NC}"

  # Check if the app is already installed using yay's query function
  if yay -Q "$app_name" &>/dev/null; then
    log "${app_name} is already installed. Skipping..."
    return
  fi

  # Attempt to install the package using Yay
  log "Installing ${app_name}..."
  yay -S "$app_name" --needed --noconfirm
  if [ $? -eq 0 ]; then
    log "${app_name} installed successfully."
  else
    error "Failed to install ${app_name}."
  fi
}

# --- Check for Yay (the AUR helper) ---
if ! command -v yay &>/dev/null; then
  warn "Yay is not installed. Installing it now..."
  sudo pacman -S --needed git base-devel --noconfirm
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
  log "Yay installed successfully. Please re-run the script."
  exit 0
fi

# --- Main Installation Script ---
echo -e "${GREEN}Starting application installation process...${NC}"
yay -Syu --noconfirm

# Define the default app list file
APP_LIST_FILE="apps.txt"

# Check if a file was provided as a command-line argument
if [ -n "$1" ]; then
    APP_LIST_FILE="$1"
fi

# Check if the app list file exists
if [ ! -f "$APP_LIST_FILE" ]; then
    error "Application list file '${APP_LIST_FILE}' not found."
    exit 1
fi

# Read through the apps listed in the text file
log "Reading apps from ${APP_LIST_FILE}..."
while IFS= read -r app; do
  # Skip empty lines or comments
  if [[ -z "$app" || "$app" =~ ^# ]]; then
    continue
  fi

  install_app "$app"
done < "$APP_LIST_FILE"

log "Installation process complete! 🎉"