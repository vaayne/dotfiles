
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

# direnv auto env
eval "$(direnv hook bash)"

# starship prompt
eval "$(starship init bash)"

# alias
source ~/.config/dotfiles/alias


# carapace auto completions
source <(carapace _carapace)
