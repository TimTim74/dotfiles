#!/usr/bin/env bash
DOTFILES=$(pwd -P)

#cd "$(dirname "${BASH_SOURCE}")";

#cd "/home/timeic/dev/test"

info() {
    printf "\033[00;34m$@\033[0m\n"
}
# ==========================================
# SYNC
# ==========================================
doSync() {
	rsync --exclude ".git/" \
		--exclude ".idea/" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~/dev/test;
#	source ~/.bash_profile;
}
# ==========================================
# GIT CONFIG
# ==========================================
doGitConfig() {
    info "Configuring Git"

    # The .gitconfig will be overwritten; reconfigure it.
    echo "Configuring global .gitignore"
    git config --global core.excludesfile ~/.gitignore_global
}
# ==========================================
# FONTS
# ==========================================
doFonts() {
    info "Installing Fonts"

    if [ "$(uname)" == "Linux" ]; then
        fonts=~/.fonts
        mkdir -p "$fonts"
    fi

    find "$DOTFILES/fonts/" -name "*.[o,t]tf" -type f | while read -r file
    do
        cp -v "$file" "$fonts"
    done

    sudo fc-cache
}
# ==========================================
# CONFIG
# ==========================================
doConfig() {
	info "Configuring"

	if ["$(uname)" == "Linux" ]; then
		echo "Configuring Linux"
		./linux.sh
	fi
}
# ==========================================
# ==========================================
doInstall() {
    info "Installing Numix circles"
    ./software/numix.sh
}
# ==========================================
# ALL
# ==========================================
doAll() {
    doUpdate
    doSync
    doGitConfig
    doSymLink
    doInstall
    doFonts
    doConfig
}
# ==========================================
# HELP
# ==========================================
doHelp() {
    echo "Usage: $(basename "$0") [options]" >&2
    echo
    echo "   -s, --sync             Synchronizes dotfiles to home directory"
    echo "   -l, --link             Create symbolic links"
    echo "   -i, --install          Install (extra) software"
    echo "   -f, --fonts            Copies font files"
    echo "   -c, --config           Configures your system"
    echo "   -a, --all              Does all of the above"
    echo
    exit 1
}
# ==========================================
# MAIN
# ==========================================
if [ $# -eq 0 ]; then
    doHelp
else
    for i in "$@"
    do
        case $i in
            -s|--sync)
                doSync
                doGitConfig
                shift
                ;;
            -l|--link)
                doSymLink
                shift
                ;;
            -i|--install)
                doInstall
                shift
                ;;
            -f|--fonts)
                doFonts
                shift
                ;;
            -c|--config)
                doConfig
                shift
                ;;
            -a|--all)
                doAll
                shift
                ;;
            *)
                doHelp
                shift
                ;;
        esac
    done
fi