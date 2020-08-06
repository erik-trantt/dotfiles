sudo /etc/init.d/postgresql start

ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(git gitfast last-working-dir common-aliases sublime zsh-syntax-highlighting history-substring-search ssh-agent)

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

ZSH_DISABLE_COMPFIX=true
# ZSH_DISABLE_COMPFIX = TRUE
# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load rbenv if installed (To manage your Ruby versions)
export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# Load pyenv (To manage your Python versions)
export PATH="${HOME}/.pyenv/bin:${PATH}" # Needed for Linux/WSL
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"

# Load nvm if installed (To manage your Node versions)
# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
 export NVM_DIR=~/.nvm
 [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
 local node_version="$(nvm version)"
 local nvmrc_path="$(nvm_find_nvmrc)"

 if [ -n "$nvmrc_path" ]; then
 local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

 if [ "$nvmrc_node_version" = "N/A" ]; then
 nvm install
 elif [ "$nvmrc_node_version" != "$node_version" ]; then
 nvm use
 fi
 elif [ "$node_version" != "$(nvm version default)" ]; then
 echo "Reverting to nvm default version"
 nvm use default
 fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Load 'lewagon' virtualenv for the Data Bootcamp. You can comment these 2 lines to disable this behavior.
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
pyenv activate lewagon 2>/dev/null && echo "🐍 Loading 'lewagon' virtualenv"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# export BUNDLER_EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -a"
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"

export BROWSER=/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

# Add EXERCISM to PATH for download and upload exercises from exercism.io
export PATH="${HOME}/bin:${PATH}"
[[ ":$PATH:" == *":$HOME/bin:"* || ":$PATH:" == *":~/bin:"* ]]

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
