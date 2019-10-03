#!/usr/bin/env bash
DOTFILES=$(pwd -P)

#cd "$(dirname "${BASH_SOURCE}")";

#cd "/home/timeic/dev/test"

info() {
    printf "\033[00;34m$@\033[0m\n"
}
# ==========================================
# COPY BASH
# ==========================================
doBash() {
    info "Copying bash_aliases"
    cp -v ./.bash_aliases ~/.bash_aliases

    source ~/.bash_aliases

    info "DONE"
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
# SSH Config
# ==========================================
doSSH() {

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
# ALL SOFTWARE
# ==========================================
doSoftware() {
    info " "
    info "Installing all software"
    info " "

    info "Brave browser"
    ./software/brave-browser.sh

    info " "
    info "Docker"
    ./software/docker.sh

    info " "
    info "Google browser"
    ./software/google-chrome.sh

    info " "
    info "Numix Icons"
    ./software/numix.sh

    info " "
    info "Pulse Equalizer"
    ./software/pulseequalizer.sh

    info " "
    info "Remmina Remote Desktop"
    ./software/remmina.sh

    info " "
    info "Postman"
    ./software/postman.sh

    info " "
    info "Shutter screenshot taker"
    ./software/shutter.sh

    info " "
    info "Skype"
    ./software/skype.sh

    info " "
    info "Slack"
    ./software/slack.sh

    info " "
    info "Spotify"
    ./software/spotify.sh

    info " "
    info "Sublime Text"
    ./software/sublime-text.sh

    info " "
    info "Virtual Box"
    ./software/virtual-box.sh

}
# ==========================================
# DOCKER RELATED
# ==========================================
doDocker() {
    info " "
    info "Portainer"
    ./software/portainer.sh
}
# ==========================================
#
# ==========================================
doInstall() {
    info "Installing Numix circles"
    ./software/numix.sh

    echo "Installing xsltproc"
    sudo apt-get install xsltproc
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
    echo "   -b, --bash             Synchronizes bash_aliases to home directory"
    echo "   -s, --sync             Synchronizes dotfiles to home directory"
    echo "   -l, --link             Create symbolic links"
    echo "   -h, --ssh              Install ssh configuration"
    echo "   -i, --install          Install (extra) software"
    echo "   -d, --docker           Install Docker stuff"
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
            -b|--bash)
                doBash
                shift
                ;;
            -l|--link)
                doSymLink
                shift
                ;;
            -h|--ssh)
                doSSH
                shift
                ;;
            -i|--install)
                doSoftware
                shift
                ;;
            -d|--docker)
                doDocker
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