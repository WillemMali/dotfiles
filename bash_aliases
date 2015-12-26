alias push="git add -A :/; git commit -m 'lazy push'; git push origin master"
alias gocbgb="cd ~/work/42tech/cbgb"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# power management
alias suspend='qdbus --system org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager.Suspend true'
alias shutdown='sudo shutdown -P now'
alias reboot='sudo shutdown -r now'
alias stop='sync; '
