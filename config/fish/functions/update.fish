# Defined in /Users/folke/.config/fish/config.fish @ line 71
function update --description 'Update homebrew, fish, pnpm'
    echo "[update] Homebrew"
    and brew update -v
    and brew upgrade
    and brew cleanup
    and brew bundle dump --describe --force

    echo "[update] Doom Emacs"
    and doom upgrade
    and doom build -r
    and doom sync

    echo "[update] nodejs"
    and pnpm update -g

    echo "[update] python"
    and pip3 list -o --user --format=freeze | sed "s/==.*//" | xargs pip3 install -U --user

    echo "[update] tldr"
    and tldr -u

    echo "[update] fish"
    and fisher self-update
    and fisher
    and fish_update_completions
end