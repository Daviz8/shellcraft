#!/bin/bash
# =============================================================================
# shellcraft — Handy shell aliases & functions to boost your terminal workflow
# Works on macOS, Linux, WSL, and Git Bash (Windows)
# =============================================================================

# -----------------------------------------------------------------------------
# VS CODE
# -----------------------------------------------------------------------------
cde() { code .; }

# -----------------------------------------------------------------------------
# SHELL NAVIGATION
# -----------------------------------------------------------------------------
alias cls='clear'
alias c='clear'
alias q='exit'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Reload the current shell's rc file (works for bash & zsh)
reload() {
    if [ -n "$ZSH_VERSION" ]; then
        source "${HOME}/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        # Bash uses .bashrc on Linux, .bash_profile on macOS login shells
        if [ -f "${HOME}/.bashrc" ]; then
            source "${HOME}/.bashrc"
        elif [ -f "${HOME}/.bash_profile" ]; then
            source "${HOME}/.bash_profile"
        fi
    fi
}

# -----------------------------------------------------------------------------
# FILES & DIRECTORIES
# -----------------------------------------------------------------------------
alias mk='mkdir'
alias tc='touch'

mkcd() {
    if [ -z "$1" ]; then
        echo "Usage: mkcd <directory>" >&2
        return 1
    fi
    mkdir -p "$1" && cd "$1"
}

# -----------------------------------------------------------------------------
# ARCHIVES
# -----------------------------------------------------------------------------
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

extract() {
    if [ ! -f "$1" ]; then
        echo "'$1' is not a valid file" >&2
        return 1
    fi

    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz)  tar xzf "$1" ;;
        *.tar.xz)  tar xJf "$1" ;;
        *.bz2)     bunzip2 "$1" ;;
        *.rar)     unrar x "$1" ;;
        *.gz)      gunzip "$1" ;;
        *.tar)     tar xf "$1" ;;
        *.tbz2)    tar xjf "$1" ;;
        *.tgz)     tar xzf "$1" ;;
        *.zip)     unzip "$1" ;;
        *.Z)       uncompress "$1" ;;
        *.7z)      7z x "$1" ;;
        *)         echo "'$1' cannot be extracted via extract()" >&2; return 1 ;;
    esac
}

# -----------------------------------------------------------------------------
# GIT
# -----------------------------------------------------------------------------
alias g='git'

# Status & diff
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'

# Branching
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

# Committing
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'

# Switch / restore / checkout
alias gsw='git switch'
alias gswc='git switch --create'
alias grs='git restore'
alias grss='git restore --staged'
alias gco='git checkout'
alias gcb='git checkout -b'

# Fetch / push / pull
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gp='git push'
alias gpu='git push --set-upstream origin HEAD'
alias gpf='git push --force-with-lease'
alias gl='git pull'
alias glr='git pull --rebase'

# Merge / rebase
alias gm='git merge'
alias gma='git merge --abort'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'

# Stash
alias gstash='git stash push'
alias gstashp='git stash pop'
alias gstashl='git stash list'

# Info
alias gtags='git tag --sort=-creatordate'
alias gremotes='git remote --verbose'
alias gcontributors='git shortlog --summary --numbered --email'
alias glog='git log --oneline --graph --decorate'

# -----------------------------------------------------------------------------
# DOCKER
# -----------------------------------------------------------------------------
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlogs='docker logs -f'
alias dprune='docker system prune -af'

# -----------------------------------------------------------------------------
# SYSTEM UTILITIES
# -----------------------------------------------------------------------------
alias myip='curl -s ifconfig.me'

# Print $PATH one entry per line (portable)
path() {
    printf "%s\n" "$PATH" | tr ':' '\n'
}

alias now='date "+%Y-%m-%d %H:%M:%S"'
alias week='date "+%V"'

# Show current shell and version (portable bash/zsh)
shellinfo() {
    local shell_name version
    shell_name="$(basename "$SHELL")"
    if [ -n "$ZSH_VERSION" ]; then
        version="$ZSH_VERSION"
    elif [ -n "$BASH_VERSION" ]; then
        version="$BASH_VERSION"
    else
        version="unknown"
    fi
    printf "Shell: %s\nVersion: %s\n" "$shell_name" "$version"
}

# -----------------------------------------------------------------------------
# NETWORKING
# -----------------------------------------------------------------------------
alias ping5='ping -c 5'
alias pingdns='ping -c 5 1.1.1.1'

# Routing table (portable across macOS & Linux)
routeinfo() {
    if command -v ip >/dev/null 2>&1; then
        ip route
    elif command -v netstat >/dev/null 2>&1; then
        netstat -rn
    else
        echo "Neither 'ip' nor 'netstat' found." >&2
        return 1
    fi
}

# DNS servers (portable across macOS & Linux)
dnsinfo() {
    if [ -f /etc/resolv.conf ]; then
        cat /etc/resolv.conf
    elif command -v scutil >/dev/null 2>&1; then
        scutil --dns | grep 'nameserver\[[0-9]*\]'
    else
        echo "Could not locate DNS configuration." >&2
        return 1
    fi
}

# Listening TCP ports (requires lsof; fallback to ss/netstat)
listeners() {
    if command -v lsof >/dev/null 2>&1; then
        lsof -nP -iTCP -sTCP:LISTEN
    elif command -v ss >/dev/null 2>&1; then
        ss -tulnp
    elif command -v netstat >/dev/null 2>&1; then
        netstat -tulnp
    else
        echo "No suitable tool found (lsof, ss, or netstat required)." >&2
        return 1
    fi
}

# Active network connections (requires lsof; fallback to ss/netstat)
connections() {
    if command -v lsof >/dev/null 2>&1; then
        lsof -nP -i
    elif command -v ss >/dev/null 2>&1; then
        ss -tunap
    elif command -v netstat >/dev/null 2>&1; then
        netstat -tunap
    else
        echo "No suitable tool found (lsof, ss, or netstat required)." >&2
        return 1
    fi
}

# Show /etc/hosts
alias hostsfile='cat /etc/hosts'

# Local IP address (macOS, Linux, WSL, Git Bash)
localip() {
    if command -v ipconfig >/dev/null 2>&1 && ipconfig getifaddr en0 >/dev/null 2>&1; then
        # macOS: en0 is usually Wi-Fi
        ipconfig getifaddr en0
    elif command -v hostname >/dev/null 2>&1 && hostname -I >/dev/null 2>&1; then
        # Linux / WSL
        hostname -I | awk '{print $1}'
    elif command -v ip >/dev/null 2>&1; then
        # Fallback via `ip`
        ip route get 1.1.1.1 | awk '{print $7; exit}'
    else
        echo "Could not determine local IP." >&2
        return 1
    fi
}

# -----------------------------------------------------------------------------
# FUN & PRODUCTIVITY
# -----------------------------------------------------------------------------
kygen() {
    local length="${1:-16}"
    openssl rand -base64 "$length"
}

pkl() {
    local process_name="$1"
    if [ -z "$process_name" ]; then
        echo "Usage: pkl <process_name>" >&2
        return 1
    fi
    pkill "$process_name" && echo "'$process_name' processes terminated."
}

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