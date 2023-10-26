# zmodload zsh/zprof

# Install Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
export PATH="$ZPFX:$PATH"

# homebrew
export HOMEBREW_NO_AUTO_UPDATE=1 # disable auto update
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# set path
export PATH="$HOME/.local/bin:$PATH" # local bin
export PATH="$HOME/go/bin:$PATH"     # golang path

PIP_APPS="black httpie pre-commit ruff tldr"

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
    atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions

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
    OMZP::git

# ripgrep
zinit ice from"gh-r" id-as"rg" extract'!' sbin"rg"
zinit light BurntSushi/ripgrep

# fzf https://github.com/junegunn/fzf
zinit ice from"gh-r" id-as"fzf" sbin"fzf"
zinit light junegunn/fzf

# fd
zinit ice from"gh-r" id-as"fd" extract'!' sbin"fd"
zinit light sharkdp/fd

# bat
zinit ice from"gh-r" id-as"bat" extract'!' sbin"bat"
zinit light sharkdp/bat
alias cat=bat

# https://github.com/ogham/exa
# zinit ice from"gh-r" id-as"exa" extract'!' sbin"exa"
zinit ice as"command" from"gh-r" id-as"exa" extract'!' pick"exa"
zinit light ogham/exa
alias ls=exa

# https://github.com/jqlang/jq
zinit ice from"gh-r" id-as"jq" mv"jq-* -> jq" sbin"jq"
zinit light jqlang/jq

# https://github.com/jesseduffield/lazygit
zinit ice from"gh-r" id-as"lazygit" extract'!' sbin"lazygit"
zinit light jesseduffield/lazygit

# cloudflared
zinit ice from"gh-r" id-as"cloudflared" sbin"cloudflared"
zinit light cloudflare/cloudflared

# https://github.com/nushell/nushell
zinit ice from"gh-r" id-as"nu" extract'!' sbin"nu"
zinit light nushell/nushell
alias nu="nu --config ~/.nurc"

# asdf
zinit ice src'asdf.sh' mv'completions/_asdf -> .'
zinit light asdf-vm/asdf
# asdf java set env
. ~/.asdf/plugins/java/set-java-home.zsh

# neovim
zinit ice from"gh-r" id-as"neovim" extract'!' sbin"bin/nvim" \
    atclone"git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1" \
    atpull"cd ~/.config/nvim && git pull"
zinit light neovim/neovim
alias vim=nvim

# python rye
zinit ice from"gh-r" id-as"rye" mv"rye* -> rye" sbin"rye" \
    atclone"./rye self completion > _rye" \
    atpull"%atclone"
zinit light mitsuhiko/rye
export PATH="$HOME/.rye/shims:$PATH"

# direnv
zinit ice from"gh-r" id-as"direnv" mv"direnv* -> direnv" sbin"direnv" \
    atclone"./direnv hook zsh > init.zsh;" \
    atpull"%atclone" \
    src"init.zsh"
zinit light direnv/direnv

# carapace completion
zinit ice id-as'carapace' from"gh-r" sbin"carapace" \
    atclone"./carapace _carapace > init.zsh" \
    atpull"%atclone" src"init.zsh" \
    atload"zicompinit"
zinit light rsteube/carapace-bin

# atuin
zinit ice from"gh-r" id-as'atuin' extract='!' sbin"atuin" \
    atclone"./atuin init zsh > init.zsh" \
    atpull"%atclone" src"init.zsh"
zinit light atuinsh/atuin

# zprof
