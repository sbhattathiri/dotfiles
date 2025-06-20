eval "$(starship init zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/opt/nvm/nvm.sh
source <(fzf --zsh)

. "$HOME/.local/bin/env"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/svb/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
