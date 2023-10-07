# zmodload zsh/zprof

autoload -Uz compinit
compinit

# local
export PATH="~/.local/bin:~/go/bin:$PATH"

# homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"

# python rye
export PATH="$HOME/.rye/shims:$PATH"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"
alias jenv-init='eval "$(jenv init -)"'

# direnv
eval "$(direnv hook zsh)"

# starship
eval "$(starship init zsh)"

# alias
source ~/.config/dotfiles/alias

# atuin
eval "$(atuin init zsh)"

# carapace
source <(carapace _carapace)


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zi snippet OMZP::git
### End of Zinit's installer chunk

# zprof

