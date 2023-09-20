if status is-interactive
    # Commands to run in interactive sessions can go here
end

carapace _carapace | source
direnv hook fish | source
jenv init - | source
pyenv init - | source
starship init fish | source
