starship init fish | source

function toggle-starship-theme
    if grep -q "palette = 'gruvbox_light'" ~/.config/starship.toml
        sed -i "s/palette = 'gruvbox_light'/palette = 'gruvbox_dark'/" ~/.config/starship.toml
        echo "Switched to Gruvbox Dark"
    else
        sed -i "s/palette = 'gruvbox_dark'/palette = 'gruvbox_light'/" ~/.config/starship.toml
        echo "Switched to Gruvbox Light"
    end
end

# Replace ls with eza
alias ls='eza --icons'
alias ll='eza -l --header --icons'
alias la='eza -la --header --icons'
alias tree='eza --tree'

zoxide init fish | source
alias cd='z'
