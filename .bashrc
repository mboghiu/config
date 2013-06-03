# Set PATH to include user's bin if it exists
if [ -d /home/me/bin ] ; then
	PATH=/home/me/bin:"${PATH}"
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm*|rxvt*)
    PS1='\[\033[1;37m\]\u:lpc\[\033[0m\]\[\033[32m\]$(__my_git_ps1)\[\033[0m\]:\W\$:'
    xset -b
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    xset -b
    PS1='\[\033[1;37m\]\u:\h\[\033[0m\]\[\033[37m\]$(__my_git_ps1)\[\033[0m\]:\W\$:'
    ;;
esac

# Alias definitions.
alias ma='vim ~/.bash_aliases.sh'
alias mf='vim ~/.bash_functions.sh'
if [ -f ~/.bash_aliases.sh ]; then
    . ~/.bash_aliases.sh
    . ~/.bash_functions.sh
fi

# enable color support for ls
if [ "$TERM" != "dumb" ]; then
   [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
   [ -e "$DIR_COLORS" ] || DIR_COLORS=""
   eval "`dircolors -b`"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#fortune -s
export LANG="en_GB.ISO-8859-1"
