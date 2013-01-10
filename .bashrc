# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# set PATH so it includes user's private bin if it exists
if [ -d /home/mboghiu/bin ] ; then
	PATH=/home/mboghiu/bin:/home/mboghiu/Scripts/binORB:/home/mboghiu/Eclipse:/home/mboghiu/.arcanist/arcanist/bin:"${PATH}"
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
   debian_chroot=$(cat /etc/debian_chroot)
fi

# Define GIT PS1
__my_git_ps1 ()
{
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf ":(%s)" "${b##refs/heads/}";
    fi
}

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
*)
    PS1='\[\033[1;37m\]\u:lpc\[\033[0m\]\[\033[32m\]$(__my_git_ps1)\[\033[0m\]:\W\$:'
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""
eval "`dircolors -b`"

	#-----------------
	# base
	#-----------------

    alias rm='rm -I'
	alias l='ls -lh --color=always'
	alias ll='ls -hla --color=always'
    alias ls='ls -h --color=always'
    alias grep='grep -n --color'

	#-----------------
	# getting places
	#-----------------
    alias ..='cd ..'
    alias ...='cd ../..'
    alias qa='cd ~/workspace; ls -ltrh --color=always'

	#-----------------
	# admin
	#-----------------

	alias wm_conf='vim ~/.xmonad/xmonad.hs'
	alias mp='ps -ef | grep mboghiu'
	alias mb='vim ~/.bashrc'
	alias ww='source ~/.bashrc'
	alias vi='vim'
	alias mutt='mutt -y'
	alias lpr='lpr -p'
	alias tcl='rlwrap tclsh8.5'
	alias cvsd='export CVSROOT=$CVSROOT_DEV'
	alias cvso='export CVSROOT=$CVSROOT_OPENBET'
    alias vall='vim -p src/*.cpp'
    alias vallt='vim -p test/*.cpp'

    alias send='scp AS5_64/libMarketAnalyticsAdaptor*.so flexsys@ldn1-dev-pulse1:market_analytics_adaptor'

    alias headlessvm='vboxmanage startvm fe5be18f-9ade-45dd-9ef0-961f6f085ca8 --type headless'
    alias xephyr='Xephyr -ac -kb -screen 1074x1889 -br -reset -terminate :1 &'
    alias gdms='DISPLAY=:1.0 gnome-session --session=2d-gnome'

	#------------------------
	# connecting to machines
	#------------------------

	alias vm='ssh root@maria-centos5-64'
	alias vmsys='ssh flexsys@maria-centos5-64'
	alias vmapp='ssh -X flexapp@maria-centos5-64'

    alias susys='ssh flexsys@ldn1-dev-rencap.london.flextrade.com'
    alias suapp='ssh -X flexapp@ldn1-dev-rencap.london.flextrade.com'

    alias pflexsys='ssh flexsys@ldn1-dev-pulse1'
    alias pflexapp='ssh -X flexapp@ldn1-dev-pulse1'
    alias poptsys='ssh optsys@ldn1-dev-pulse1'
    alias pmaxxsys='ssh maxxsys@ldn1-dev-pulse1'
    alias pdevapp='ssh -X devapp@ldn1-dev-pulse1'

    alias pflexsys2='ssh flexsys@ldn1-dev-pulse2'
    alias pflexapp2='ssh -X flexapp@ldn1-dev-pulse2'
    alias poptsys2='ssh optsys@ldn1-dev-pulse2'
    alias pmaxxsys2='ssh maxxsys@ldn1-dev-pulse2'
    alias pdevapp2='ssh -X devapp@ldn1-dev-pulse2'

    alias pflexsys3='ssh flexsys@ldn1-dev-pulse3'
    alias pflexapp3='ssh -X flexapp@ldn1-dev-pulse3'
    alias poptsys3='ssh optsys@ldn1-dev-pulse3'
    alias pmaxxsys3='ssh maxxsys@ldn1-dev-pulse3'
    alias pdevapp3='ssh -X devapp@ldn1-dev-pulse3'

    alias bld='sudo chroot ~/vm-chroot'

    alias ecmaxflex='echo -e "\033[31mflexsys@ec-max1:\033[0m"; ssh flexsys@ec-max1.hosted.flextrade.com'
    alias ecmaxopt='echo -e "\033[31m@optsys@ec-max1:\033[0m"; ssh optsys@ec-max1.hosted.flextrade.com'

	#-----------------
	# misc/temp
	#-----------------

fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export PRINTER=xerox
export EDITOR=vim
export CVSEDITOR=vim

# My vars
export VM='maria-centos5-64'
export PLATFORM='AS5_64'
export BIN='/home/mboghiu/Documents/workspace'
export REPOSITORY='/mnt/build_share/repository'
export THIRDPARTY='/mnt/build_share/sherman/home/thirdparty'
export _JAVA_AWT_WM_NONREPARENTING=1
export MAIL='~/Maildir'


export DEPTOOL='/mnt/build_share/repository/deptool'
export REPO_PATH='/mnt/build_maria_workspace/LOCAL_REPO:/mnt/build_share/repository/'
export CLASSIFIER='AS5_64-debug'
export LD_LIBRARY_PATH=''

export vmid="fe5be18f-9ade-45dd-9ef0-961f6f085ca8"
# awesome: vim -p `grep -r "Exceptions" src/ | sed 's/:.*//'`

wmname LG3D
