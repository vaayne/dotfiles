# zmodload zsh/zprof

# Order of execution of related Ice-mods: atinit -> atpull! -> make'!!' -> mv -> cp -> make! -> atclone/atpull -> make -> (plugin script loading) -> src -> multisrc -> atload.
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

# Load plugins
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit lucid light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    from"gh-r" atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" atpull"%atclone" src"init.zsh" sbin'**/starship -> starship' starship/starship

# Load basic plugins
zinit wait"2" lucid light-mode for \
    atinit"zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions \
    OMZL::functions.zsh \
    OMZL::clipboard.zsh \
    OMZL::directories.zsh \
    OMZL::termsupport.zsh \
    OMZL::git.zsh \
    OMZP::git

# asdf
zinit wait lucid light-mode for \
    src'asdf.sh' id-as'asdf' mv'completions/_asdf -> .' \
    atclone'./bin/asdf plugin add nodejs; \
            ./bin/asdf plugin add direnv; \
            ./bin/asdf plugin add python; \
            ./bin/asdf plugin add java; \
            . ~/.asdf/plugins/java/set-java-home.zsh; \
            ./bin/asdf direnv setup --shell zsh --version latest; \
            ./bin/asdf direnv install
            ' \
    atpull'%atclone' \
    atload'source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"' \
    @asdf-vm/asdf

# Load some binaries as null
zi wait"4" as"null" lucid from"gh-r" for \
    sbin'rg' BurntSushi/ripgrep \
    sbin'bat' @sharkdp/bat \
    sbin'fd' @sharkdp/fd \
    sbin'delta' dandavison/delta \
    sbin'exa' atload"alias ls=exa" ogham/exa \
    sbin'fzf' junegunn/fzf \
    sbin'gh' cli/cli \
    sbin"uv" @astral-sh/uv \
    sbin'lazygit' jesseduffield/lazygit \
    sbin'nvim' atclone"git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1" atpull"cd ~/.config/nvim && git pull" atload"alias vim=nvim" neovim/neovim \
    sbin"cloudflared" cloudflare/cloudflared \
    sbin"nu" atload'alias nu="nu --config ~/.nurc"' nushell/nushell \
    atclone'golangci-lint completion zsh > _golangci-lint' sbin'golangci-lint' @golangci/golangci-lint \
    sbin"rclone" rclone/rclone \
    sbin"carapace" atclone"./carapace _carapace > init.zsh" atpull"%atclone" src"init.zsh" atload"zicompinit" carapace-sh/carapace-bin \
    sbin"atuin" atclone"./atuin init zsh > init.zsh" atpull"%atclone" src"init.zsh" atload"zicompinit" atuinsh/atuin

# preview files using fzf
alias pf="fzf --preview='bat --color=always {}' --previewindow=right:80%:wrap --bind shift-up:preview-page-up,shift-down:preview-page-down"

function frg {
    result=$(rg --ignore-case --color=always --line-number --no-heading "$@" |
        fzf --ansi \
            --color 'hl:-1:underline,hl+:-1:underline:reverse' \
            --delimiter ':' \
            --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
            --previewindow 'up,60%,border-bottom,+{2}+3/3,~3')
    file=${result%%:*}
    linenumber=$(echo "${result}" | cut -d: -f2)
    if [[ -n "$file" ]]; then
        $EDITOR +"${linenumber}" "$file"
    fi
}

# zprof
