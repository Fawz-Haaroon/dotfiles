# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="lexitron-tokyonight"

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
#fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'


alias cliprev="cliphist list | fzf --preview 'cliphist decode {} | chafa -' --preview-window=right:60% | cliphist decode | wl-copy"


# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


# --- The Hook Widget ---
autoload -Uz add-zsh-hook


# Auto-LS
# Lists files automatically, but only if the directory isn't huge
goat_auto_ls() {
    # Check if there are more than 50 files to avoid terminal spam
    if [ $(ls -1 | wc -l) -le 50 ]; then
        echo -e "\e[1;34m--- Directory Contents ---\e[0m"
        # Uses 'ls' with colors, or 'eza' if you have it installed
        command -v eza >/dev/null && eza --icons || ls -G
    else
        echo -e "\e[1;33mLarge directory ($(ls -1 | wc -l) files). Skipping auto-ls.\e[0m"
    fi
}

# Python Venv Auto-Activator
# Automatically enters a .venv if it exists in the folder
goat_venv_autoselect() {
    if [[ -d ".venv" ]]; then
        source .venv/bin/activate
        echo -e "\e[1;32m🐍 Python Virtualenv activated\e[0m"
    elif [[ -n "$VIRTUAL_ENV" ]]; then
        # Deactivate if we move to a folder without a venv
        deactivate
    fi
}

# Local Project Config Loader
# Safely sources a .env or .project_rc file if it exists
goat_load_local_config() {
    if [[ -f ".env" ]]; then
        echo -e "\e[1;36m⚙️  Loading local .env config...\e[0m"
        set -a; source .env; set +a
    fi
}

# Terminal Title Updater
# Keeps your terminal tab name synced with your current project folder
goat_update_terminal_title() {
  print -Pn "\e]0;%~ - Zsh\a"
}

#  REGISTER THE WIDGETS
# These replace the standalone 'chpwd' function
add-zsh-hook chpwd goat_auto_ls
add-zsh-hook chpwd goat_venv_autoselect
add-zsh-hook chpwd goat_load_local_config
add-zsh-hook chpwd goat_update_terminal_title





waifu() {
  local dir="$HOME/Pictures/term_waifus"
  local img=""

  if command -v fd >/dev/null 2>&1; then
    img=$(fd -e png -e jpg -e jpeg . "$dir" | shuf -n 1)
  else
    img=$(find "$dir" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | shuf -n 1)
  fi

  [ -z "$img" ] && return

  fastfetch \
    -c "$HOME/.config/fastfetch/config-waifu.jsonc" \
    --logo "$img" \
    --logo-type kitty

  print -P "%F{237}${(l.$COLUMNS..-.)}%f"
  }

# run only once per shell session
if [[ $- == *i* ]] && [[ -z "$WAIFU_FETCH_DONE" ]]; then
  export WAIFU_FETCH_DONE=1
  waifu
fi

#. "$HOME/.local/share/../bin/env"


#RUBY-solargraph
export PATH=/home/lexitron/.local/share/gem/ruby/3.4.0/bin:$PATH


# opencode
export PATH=/home/lexitron/.opencode/bin:$PATH

# manga-tui
export PATH=/home/lexitron/.cargo/bin:$PATH

# for haskell
[ -f "/home/lexitron/.ghcup/env" ] && . "/home/lexitron/.ghcup/env" # ghcup-env

#export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"






#HADOOP
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export HADOOP_HOME=/opt/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

export SPARK_HOME=~/spark
export PATH=$PATH:$SPARK_HOME/bin



export JAVA_HOME=/usr/lib/jvm/java-17-openjdk




#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"



#TREEPORT
alias restic-mount-demo='export RESTIC_PASSWORD=demo && restic mount --repo ~/Desktop/restic-repo ~/Desktop/restic-mount &'




#eval "$(starship init zsh)"





# ───── Tokyo Night MAXED palette ─────

autoload -Uz compinit && compinit

# syntax engine
ZSH_HIGHLIGHT_HIGHLIGHTERS=(
    main
    brackets
    pattern
    regexp
    cursor
)

# base text
ZSH_HIGHLIGHT_STYLES[default]='fg=#c0caf5'

# invalid commands
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e,bold'

# shell keywords
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#bb9af7,bold'

# actual valid commands
ZSH_HIGHLIGHT_STYLES[command]='fg=#9ece6a,bold'

# builtins
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7dcfff,bold'

# aliases
ZSH_HIGHLIGHT_STYLES[alias]='fg=#73daca,bold'

# functions
ZSH_HIGHLIGHT_STYLES[function]='fg=#2ac3de,bold'

# directories typed manually
ZSH_HIGHLIGHT_STYLES[path]='fg=#7aa2f7'

# options like:
# ls -la
# cargo --release
ZSH_HIGHLIGHT_STYLES[option]='fg=#ff9e64,bold'

# wildcards
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#bb9af7'

# numbers
ZSH_HIGHLIGHT_STYLES[numeric]='fg=#ff757f'

# quoted strings
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#e0af68'

# command separators
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#f7768e'

# command substitutions
ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#73daca'

# variables
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#7dcfff'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#bb9af7'

# brackets
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#e0af68'

# history expansion
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#ff9e64,bold'

# cursor
ZSH_HIGHLIGHT_STYLES[cursor]='standout'

# ghost suggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#565f89'

# completion menu
zstyle ':completion:*' menu select

# selected completion row
zstyle ':completion:*' list-colors \
'ma=48;2;65;72;104;38;2;192;202;245' \
'di=38;2;158;206;106' \
':fi=38;2;192;202;245' \
':ln=38;2;125;207;255' \
':ex=38;2;247;118;142' \
':*.rs=38;2;255;158;100' \
':*.py=38;2;187;154;247' \
':*.zip=38;2;247;118;142' \
':*.jpg=38;2;224;175;104' \
':*.png=38;2;224;175;104' \
':*.json=38;2;122;162;247' \
':*.toml=38;2;255;158;100' \
':*.md=38;2;115;218;202'

zstyle ':completion:*:descriptions' format '%F{111}☾ %d%f'
zstyle ':completion:*:warnings' format '%F{203}No matches%f'
zstyle ':completion:*:messages' format '%F{183}%d%f'

# ls / eza
export LS_COLORS='di=38;2;158;206;106:ln=38;2;125;207;255:ex=38;2;247;118;142:fi=38;2;192;202;245'

# git prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%F{183}git:(%f"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{183})%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{203}✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{120}✓%f"



source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh




kbd() {
    hyprctl keyword "device[at-translated-set-2-keyboard]:enabled" false
    notify-send "Internal keyboard disabled"
}

kbe() {
    hyprctl keyword "device[at-translated-set-2-keyboard]:enabled" true
    notify-send "nternal keyboard enabled"
}

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<
