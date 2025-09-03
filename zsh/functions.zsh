# -------------------------------
# zsh/functions.zsh
# -------------------------------

# Extract archives
extract() {
    for archive in "$@"; do
        if [ -f "$archive" ]; then
            case $archive in
                *.tar.bz2) tar xvjf $archive ;;
                *.tar.gz) tar xvzf $archive ;;
                *.bz2) bunzip2 $archive ;;
                *.rar) rar x $archive ;;
                *.gz) gunzip $archive ;;
                *.tar) tar xvf $archive ;;
                *.tbz2) tar xvjf $archive ;;
                *.tgz) tar xvzf $archive ;;
                *.zip) unzip $archive ;;
                *.Z) uncompress $archive ;;
                *.7z) 7z x $archive ;;
                *) echo "don't know how to extract '$archive'..." ;;
            esac
        else
            echo "'$archive' is not a valid file!"
        fi
    done
}

# Search text in folder
ftext() {
    grep -iIHrn --color=always "$1" . | less -r
}

# Copy with progress (simplificada)
cpp() {
    cp "$1" "$2"
}

# Copy / Move and go to dir
cpg() { cp "$1" "$2" && [ -d "$2" ] && cd "$2"; }
mvg() { mv "$1" "$2" && [ -d "$2" ] && cd "$2"; }

# mkdir and go
mkdirg() { mkdir -p "$1" && cd "$1"; }

# Up N directories
up() {
    local d=""
    local limit=$1
    for ((i=1; i<=limit; i++)); do d=$d/..; done
    cd ${d#/}
}

# cd auto-ls
cd () { builtin cd "$@" && ls; }

# pwd tail
pwdtail() { pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'; }

# Distro info
distribution() {
    local dtype="unknown"
    if [ -r /etc/os-release ]; then
        source /etc/os-release
        case $ID in
            fedora|rhel|centos) dtype="redhat" ;;
            sles|opensuse*) dtype="suse" ;;
            ubuntu|debian) dtype="debian" ;;
            gentoo) dtype="gentoo" ;;
            arch) dtype="arch" ;;
            slackware) dtype="slackware" ;;
        esac
    fi
    echo $dtype
}

ver() {
    local dtype=$(distribution)
    case $dtype in
        redhat) [ -s /etc/redhat-release ] && cat /etc/redhat-release || cat /etc/issue; uname -a ;;
        suse) cat /etc/SuSE-release ;;
        debian) lsb_release -a ;;
        gentoo) cat /etc/gentoo-release ;;
        arch) cat /etc/os-release ;;
        slackware) cat /etc/slackware-version ;;
        *) [ -s /etc/issue ] && cat /etc/issue || echo "Unknown distro" ;;
    esac
}

# IP lookup
whatsmyip() {
    echo -n "Internal IP: "
    ip addr show wlan0 | grep "inet " | awk '{print $2}'
    echo -n "External IP: "
    curl -s ifconfig.me
}

# Trim spaces
trim() { local var=$*; var="${var#"${var%%[![:space:]]*}"}"; var="${var%"${var##*[![:space:]]}"}"; echo -n "$var"; }

# Git shortcuts
gcom() { git add . && git commit -m "$1"; }
lazyg() { git add . && git commit -m "$1" && git push; }

# Hastebin upload
hb() {
    [ $# -eq 0 ] && { echo "No file path specified."; return; }
    [ ! -f "$1" ] && { echo "File path does not exist."; return; }
    uri="http://bin.christitus.com/documents"
    response=$(curl -s -X POST -d "$(cat "$1")" "$uri")
    hasteKey=$(echo $response | jq -r '.key')
    echo "http://bin.christitus.com/$hasteKey"
}
