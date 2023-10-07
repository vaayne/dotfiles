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


# zplug

export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "plugins/git",   from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions", defer:2


zplug load 
#zplug load --verbose

# zprof

