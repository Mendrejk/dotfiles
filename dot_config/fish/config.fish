starship init fish | source

# Replace ls with eza
alias ls='eza --icons'
alias ll='eza -l --header --icons'
alias la='eza -la --header --icons'
alias tree='eza --tree'

# Add ~/.local/bin to PATH
if not contains "$HOME/.local/bin" $PATH
    set -x PATH "$HOME/.local/bin" $PATH
end

zoxide init fish | source
alias cd='z'

# Load custom secrets (e.g., GH API key) if present
if test -f ~/.config/fish/conf.d/secrets.fish
    source ~/.config/fish/conf.d/secrets.fish
end
