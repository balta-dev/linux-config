# -------------------------------
# zsh/aliases.zsh
# -------------------------------

# Editing
alias ezrc='nano ~/.zshrc'
alias szrc='source ~/.zshrc'

# Date
alias da='date "+%Y-%m-%d %A %T %Z"'

# Safety aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias apt-get='sudo apt-get'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias obs='strace -e trace=execve obs'

# Editor shortcuts
alias vi='nvim'
alias svi='sudo vi'
alias vis='nvim "+set si"'

# Audio loopback
alias eml='pactl load-module module-loopback'
alias dml='pactl unload-module module-loopback'
alias eml0ms='pactl load-module module-loopback latency_ms=0'

# Directory shortcuts
alias zD='cd /run/media/balta/829707d9-cc45-42fe-8f9c-2bc0dda71a26/Descargas'
alias mkcd='function _mkcd(){ mkdir -p "$1" && cd "$1"; }; _mkcd'
alias mntdsk='udisksctl mount -b /dev/sda1'
alias th='thunar . & disown && exit'
alias ehypr='nano ~/.config/hypr/hyprland.conf'

# Remap input
alias startR='input-remapper-gtk'
alias sr='startR'

# Navigation
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"'

# Remove directories safely
alias rmd='/bin/rm  --recursive --force --verbose'

# LS variants
alias la='ls -Alh'
alias ls='ls -aFh --color=always'
alias lx='ls -lXBh'
alias lk='ls -lSrh'
alias lc='ls -lcrh'
alias lu='ls -lurh'
alias lr='ls -lRh'
alias lt='ls -ltrh'
alias lm='ls -alh | more'
alias lw='ls -xAh'
alias ll='ls -Fls'
alias labc='ls -lap'
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"

# Chmod shortcuts
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# History & processes
alias h="history | grep "
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Find & count
alias f="find . | grep "
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# Command check
alias checkcommand="type -t"

# Network & system
alias openports='netstat -nape --inet'
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Disk & directories
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Logs
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# Misc
alias sha1='openssl sha1'
alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'
alias kssh="kitty +kitten ssh"
