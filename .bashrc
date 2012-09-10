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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
	PS1='\u@\h:\W\$:'
    ;;
*)
	#PS1='\u@\h:\[\033[31\]m$(__git_ps1)\[\033[0m\]:\W\$:'
    PS1='\u@\h:\[\033[31m\]$(__git_ps1)\[\033[0m\]:\W\$:'
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

	alias l='ls -l --color=always'
	alias ll='ls -la --color=always'

	#-----------------
	# getting places
	#-----------------
    alias ..='cd ..'
    alias ...='cd ../..'

    alias g='cd /home/mboghiu/Documents'
    alias mysrc='cd /home/mboghiu/workspace/MockFixFlex'
    alias pjsrc='cd /mnt/build_share/workspace/Rel-11-1-0'
    alias ws='cd /home/mboghiu/workspace_shared; ls -ltrh'
    alias qa='cd /mnt/build_maria_workspace; ls -ltrh --color=always'
    alias kk='cd /mnt/build_maria_workspace/idc'

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

    alias bld='ssh mboghiu@build-centos5-64'
    alias mybld='ssh -Xt mboghiu@10.2.67.58 "cd /home/mboghiu/workspace; bash"'

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
export PROJECTS_HOME='/mnt/build_share/workspace/Rel-11-1-0'
export PLATFORM='AS5_64'
export BIN='/home/mboghiu/Documents/workspace'
export REPOSITORY='/mnt/build_share/repository'
export THIRDPARTY='/mnt/build_share/sherman/home/thirdparty'
export _JAVA_AWT_WM_NONREPARENTING=1
