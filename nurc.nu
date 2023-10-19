
# starship for prompt
const starshipConfigPath = ~/.cache/starship/init.nu
if (( $starshipConfigPath | path exists) == false) {
    mkdir ~/.cache/starship
    starship init nu | save -f $starshipConfigPath
}
use $starshipConfigPath


let carapace_completer = {|spans|
    carapace $spans.0 nushell $spans | from json
}

$env.config = {
    hooks: {
        # direnv
        pre_prompt: [{ ||
            let direnv = (direnv export json | from json | default {})
            if ($direnv | is-empty) {
                return
            }
            $direnv
            | items {|key, value|
                {
                    key: $key
                    value: (if $key in $env.ENV_CONVERSIONS {
                    do ($env.ENV_CONVERSIONS | get $key | get from_string) $value
                    } else {
                        $value
                    })
                }
            } | transpose -ird | load-env
        }]
    },
    completions: {
        # carapace completions
        external: {
            enable: true
            completer: $carapace_completer
        }
    }
}

alias vim = nvim
$env.EDITOR = vim
