if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
    starship init fish | source
else
    echo 'not interactive!'
end
