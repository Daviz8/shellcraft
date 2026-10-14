# shellcraft

> Handy shell aliases to speed up your terminal workflow.

A curated collection of shell aliases and functions that save keystrokes and boost productivity. Copy, paste, done.

![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-blue)
![License](https://img.shields.io/badge/license-MIT-green)

---

## Why?

Typing the same commands over and over is a waste of time. This repo bundles the shortcuts I use daily — from opening VS Code in one keystroke to renaming a folder full of images — into a single file you can drop into your shell config.

---

## What's Inside

| Shortcut                             | What it does                                                       |
| ------------------------------------ | ------------------------------------------------------------------ |
| `cde`                                | Open the current folder in VS Code                                 |
| `cls`                                | Clear the terminal screen                                          |
| `..` `...` `....`                    | Go up 1, 2, or 3 directories                                       |
| `mkcd <dir>`                         | Create a folder and `cd` into it in one step                       |
| `turn_zip [folder]`                  | Compress any folder into a clean `.zip` (no Mac junk)              |
| `extract <file>`                     | Universal extractor for `.zip`, `.tar.gz`, `.rar`, `.7z`, and more |
| `rename_images`                      | Rename all images in a folder to `image_1.png`, `image_2.png`, …   |
| `kygen [length]`                     | Generate a random base64 password (default 16 chars)               |
| `pkl <process>`                      | Kill processes by name                                             |
| `myip`                               | Show your public IP                                                |
| `reload`                             | Reload your shell config                                           |
| `g`, `gs`, `ga`, `gc`, `gp`, `gl`, … | Git shortcuts                                                      |
| `d`, `dc`, `dps`, `dex`, `dlogs`, …  | Docker shortcuts                                                   |

See the full list below.

---

## Installation

### macOS & Linux

1. **Clone this repo somewhere permanent:**

   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git ~/.shellcraft
   ```

2. **Add one line to your shell config** to load it:

   **Zsh** (default on macOS):

   ```bash
   echo '[ -f ~/.shellcraft/main.sh ] && source ~/.shellcraft/main.sh' >> ~/.zshrc
   source ~/.zshrc
   ```

   **Bash** (default on most Linux):

   ```bash
   echo '[ -f ~/.shellcraft/main.sh ] && source ~/.shellcraft/main.sh' >> ~/.bashrc
   source ~/.bashrc
   ```

3. Done. Open a new terminal and try `cde` or `turn_zip`.

### Windows

#### Option A — WSL (recommended)

If you use WSL, you're in a real Linux environment. Follow the macOS/Linux steps above inside your WSL terminal.

#### Option B — Git Bash

1. Clone the repo to your home directory:

   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git ~/.shellcraft
   ```

2. Add the load line to `~/.bashrc`:

   ```bash
   echo '[ -f ~/.shellcraft/main.sh ] && source ~/.shellcraft/main.sh' >> ~/.bashrc
   source ~/.bashrc
   ```

3. Some functions (like `extract` for `.rar` / `.7z`) require extra tools. Install them with `pacman` (Git Bash) or use WSL for full compatibility.

### One-liner install (no clone)

If you just want to try it:

```bash
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/main.sh >> ~/.zshrc
source ~/.zshrc
```

> ⚠️ Always read a script before piping it into your shell. You can `curl -sSL <url>` first to inspect it.

---

## Full Alias Reference

### VS Code

```bash
cde               # Open current directory in VS Code
```

### Shell Navigation

```bash
cls               # Clear the screen
..                # cd ..
...               # cd ../..
....              # cd ../../..
q                 # exit
reload            # Reload ~/.zshrc or ~/.bashrc
```

### Files & Directories

```bash
mk                # mkdir
tc                # touch
mkcd <dir>        # Create directory and cd into it
```

### Archives

```bash
turn_zip [folder] # Zip a folder (defaults to current dir).
                  # Produces ~/path/to/folder.zip next to the folder.
                  # Skips .DS_Store and __MACOSX junk.

extract <file>    # Extract .zip, .tar.gz, .tar.bz2, .rar, .7z, .gz, etc.
```

### System Utilities

```bash
myip              # Print public IP address
kygen [length]    # Random base64 password (default 16 chars)
pkl <process>     # Kill processes by name
```

### Image Utilities

```bash
rename_images     # Rename all images in the current folder to
                  # image_1.png, image_2.png, ...
```

### Git

```bash
g                 # git
gs                # git status
ga                # git add .
gc                # git commit -m
gp                # git push
gl                # git pull
gd                # git diff
gco               # git checkout
gb                # git branch
gst               # git stash
glog              # git log --oneline --graph --decorate
```

### Docker

```bash
d                 # docker
dc                # docker compose
dps               # docker ps
dpsa              # docker ps -a
di                # docker images
dex               # docker exec -it
dlogs             # docker logs -f
dprune            # docker system prune -af
```

---

## Examples

### Zip a project folder

```bash
cd ~/Documents
turn_zip MyProject
# → Compressing 'MyProject' into '/Users/you/Documents/MyProject.zip'...
# → Success! Created /Users/you/Documents/MyProject.zip
```

### Create and enter a new project

```bash
mkcd ~/projects/new-thing
cde                        # opens VS Code in the new folder
```

### Rename a folder of screenshots

```bash
cd ~/Desktop/screenshots
rename_images
# cat.png → image_1.png
# dog.png → image_2.png
# ...
```

### Generate a password

```bash
kygen           # 16-char password
kygen 32        # 32-char password
```

---

## Requirements

- **macOS / Linux**: `zip`, `unzip`, `tar`, `openssl` (all preinstalled on macOS; install with your package manager on Linux).
- **Optional**: `unrar` and `7z` for `.rar` / `.7z` extraction.
- **Windows**: Use WSL for full compatibility. Git Bash works for most features.

---

## Customization

All aliases live in a single file: `main.sh`. Fork the repo, edit, and `reload`.

**Adding a new alias:**

```bash
alias please='sudo'   # 😈
```

Then run `reload` and you're done.

---

## Contributing

Got a shortcut you can't live without? Open a PR. Keep it short, useful, and portable across bash and zsh where possible.

1. Fork the repo
2. Create a branch (`git checkout -b add-my-alias`)
3. Commit your change (`git commit -m 'Add my-alias'`)
4. Push (`git push origin add-my-alias`)
5. Open a Pull Request

---

## License

MIT — do whatever you want with it.

---

## Star History

If this saved you some keystrokes, drop a ⭐ — it helps others find it.
