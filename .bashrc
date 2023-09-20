
# local
export PATH="~/.local/bin:~/go/bin:$PATH"

# homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# direnv
eval "$(direnv hook bash)"

# starship
eval "$(starship init bash)"

# carapace
source <(carapace _carapace)
