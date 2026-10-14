#!/bin/bash
# =============================================================================
# Shell Aliases & Functions Toolkit
# =============================================================================

# --- VS Code ---
# Open current directory in VS Code
cde() { code .; }

# --- Shell Navigation ---
# Clear screen
alias cls='clear'
# Go up directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --- Directory & File Management ---
alias mk='mkdir'
alias tc='touch'
# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# --- Archive Utilities ---
# Your original turn_zip function (excellent!)
turn_zip() {
    TARGET_DIR="${1:-.}"
    TARGET_DIR="${TARGET_DIR%/}"
    [ -z "$TARGET_DIR" ] && TARGET_DIR="."
    if [ ! -d "$TARGET_DIR" ]; then
        echo "Error: '$TARGET_DIR' is not a directory." >&2
        return 1
    fi
    ABS_DIR="$(cd "$TARGET_DIR" && pwd)"
    FOLDER_NAME="$(basename "$ABS_DIR")"
    PARENT_DIR="$(dirname "$ABS_DIR")"
    ZIP_NAME="${PARENT_DIR}/${FOLDER_NAME}.zip"
    echo "Compressing '$FOLDER_NAME' into '$ZIP_NAME'..."
    ( cd "$PARENT_DIR" && zip -r -X "$ZIP_NAME" "$FOLDER_NAME" -x "*.DS_Store" "*__MACOSX*" )
    if [ $? -eq 0 ]; then
        echo "Success! Created $ZIP_NAME"
    else
        echo "Error: Failed to create zip file." >&2
        return 1
    fi
}

# Universal extractor
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1" ;;
            *)         echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# --- Git Aliases ---
alias gi='git'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gst='git stash'
alias glog='git log --oneline --graph --decorate'

# --- Docker Aliases ---
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlogs='docker logs -f'
alias dprune='docker system prune -af'

# --- System Utilities ---
alias c='clear'
alias q='exit'
alias myip='curl -s ifconfig.me'
alias reload='source ~/.zshrc' # Change to ~/.bashrc if you use Bash

# --- Fun & Productivity ---
# Random password generator (now with optional length)
kygen() {
    local length="${1:-16}"
    openssl rand -base64 "$length"
}

# Process killer
pkl() {
    local process_name="$1"
    if [ -z "$process_name" ]; then
        echo "Usage: pkl <process_name>" >&2
        return 1
    fi
    pkill "$process_name" && echo "'$process_name' processes terminated."
}

# Rename images to sequential numbers (Zsh & Bash compatible)
rename_images() {
    [ -n "$ZSH_VERSION" ] && setopt localoptions nullglob
    local count=1
    for file in *.jpg *.jpeg *.png *.gif *.webp; do
        [ -e "$file" ] || continue
        local ext="${file##*.}"
        mv -- "$file" "image_$count.$ext"
        ((count++))
    done
}