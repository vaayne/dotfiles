# set PATH
let PATH = open ~/.config/dotfiles/config.json | get env.PATH | reverse | str join ":"
$env.PATH = ($env.PATH | split row (char esep) | prepend $PATH)

# set ENV
$env.EDITOR = vim

# alias

# config
use ~/.cache/starship/init.nu
source ~/.cache/carapace/init.nu
source ~/.local/share/atuin/init.nu

