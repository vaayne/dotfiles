# zmodload zsh/zprof

# Install Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# homebrew
export HOMEBREW_NO_AUTO_UPDATE=1 # disable auto update
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# set path
export PATH="$HOME/.local/bin:$PATH" # local bin
export PATH="$HOME/go/bin:$PATH"     # golang path

# Load plugins
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Load basic plugins
zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions
# blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions

# Load starship theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Load more plugins
zinit wait"2" lucid light-mode for \
    OMZL::functions.zsh \
    OMZL::clipboard.zsh \
    OMZL::directories.zsh \
    OMZL::termsupport.zsh \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::direnv \
    OMZP::jenv \
    OMZP::nvm \
    OMZP::fzf

# ripgrep
zinit ice from"gh-r" as"program" id-as"rg" extract'!' pick"rg"
zinit light BurntSushi/ripgrep

# fd
zinit ice from"gh-r" as"program" id-as"fd" extract'!' pick"fd"
zinit light sharkdp/fd

# bat
zinit ice from"gh-r" as"program" id-as"bat" extract'!' pick"bat"
zinit light sharkdp/bat
alias cat=bat

# neovim
zinit ice as"program" from"gh-r" id-as"neovim" extract'!' pick"bin/nvim"
zinit light neovim/neovim
alias vim=nvim

# python rye
zinit ice as"program" from"gh-r" id-as"rye" mv"rye* -> rye" pick"rye" \
    atclone"./rye self completion > _rye;" \
    atpull"%atclone"
zinit light mitsuhiko/rye
export PATH="$HOME/.rye/shims:$PATH"

# direnv
zinit ice as"program" from"gh-r" id-as"direnv" mv"direnv* -> direnv" pick"direnv" \
    atclone"./direnv hook zsh > init.zsh;" \
    atpull"%atclone" \
    src"init.zsh"
zinit light direnv/direnv

# carapace completion
zinit ice as"command" id-as'carapace' from"gh-r" \
    atclone"./carapace _carapace > init.zsh" \
    atpull"%atclone" src"init.zsh" \
    atload"zicompinit"
zinit light rsteube/carapace-bin

# atuin completion
zinit ice as"command" from"gh-r" id-as'atuin' extract='!' \
    atclone"./atuin init zsh > init.zsh" \
    atpull"%atclone" pick"atuin" src"init.zsh"
zinit light atuinsh/atuin

# navi https://github.com/denisidoro/navi
zinit ice from"gh-r" as"program" id-as"navi" pick"navi"
zinit light denisidoro/navi

# https://github.com/ogham/exa
zinit ice as"program" from"gh-r" id-as"exa" extract'!' pick"bin/exa"
zinit light ogham/exa
alias ls=exa

# https://github.com/jqlang/jq
zinit ice as"program" from"gh-r" id-as"jq" pick"jq"
zinit light jqlang/jq

# https://github.com/jesseduffield/lazygit
zinit ice as"program" from"gh-r" id-as"lazygit" extract'!' pick"lazygit"
zinit light jesseduffield/lazygit

# https://github.com/nushell/nushell
zinit ice as"program" from"gh-r" id-as"nu" extract'!' pick"nu"
zinit light nushell/nushell

# zprof
