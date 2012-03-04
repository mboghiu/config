#--------------------------------------------------------------------------------------
# HELLO, welcome to Maria's BashRC. For more examples, see
#                                   /usr/share/doc/bash/examples/startup-files
#                                   (in the package bash-doc) for examples
#--------------------------------------------------------------------------------------


#--------------------------------------------------------------------------------------
# PATH
#        add here variables with paths to locations not otherwise included in the PATH
#--------------------------------------------------------------------------------------
#--------define your path here
JAVA_HOME="/usr/share/menu/sun-java6-jdk"
#FLEX_HOME="/opt/flex_sdk_3/bin"

#--------and don't forget to add it to the PATH here
PATH="${JAVA_HOME}":"${FLEX_HOME}":"${PATH}"

#--------finally, includes user's private bin/s if it/they exists
if [ -d /home/maria/Dropbox/bin ] ; then
	PATH=/home/maria/Dropbox/bin:"${PATH}"
fi

#--------------------------------------------------------------------------------------
# PROMPT
#       coloured prompt, xterm title and other such useful tweaks
#--------------------------------------------------------------------------------------
#--------if not running interactively, don't do anything
[ -z "$PS1" ] && return

#--------don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
#--------... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

#--------check the window size after each command and, if necessary,
#--------update the values of LINES and COLUMNS.
shopt -s checkwinsize

#--------make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

#--------set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
   debian_chroot=$(cat /etc/debian_chroot)
fi

#--------set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm*|rxvt*)
	PS1='\u@\h:\W\$ '
    ;;
*)
	PS1='\u@\h:\W\$ '
    ;;
esac
#--------comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#--------if this is an xterm or (u)rxvt then set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

#--------------------------------------------------------------------------------------
# COLOUR support and ALIASES
#      aliases can go in an enternal file, e.g. ~/.bash_aliases; if one exists, this
#      first command will load it.
#--------------------------------------------------------------------------------------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ "$TERM" != "dumb" ]; then
	[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
	[ -e "$DIR_COLORS" ] || DIR_COLORS=""
eval "`dircolors -b`"

	#-----------------
	# Being lazy
	#-----------------
		# Bash
		#-------------
	alias ww='source ~/.bashrc'
	alias mb='vi ~/.bashrc'
	alias l='ls -lX --color=always'
	alias ll='ls -lXa --color=always'
		#--------------
		# Housekeeping
		#--------------
	alias fixres='~/fix_resolution'
	alias jflap='java -jar /home/maria/Desktop/FOCS/JFLAP.jar'
	alias mend='~/mendeley/bin/mendeleydesktop &'
		#--------------
		# LaTeX
		#--------------
	alias bibifi='cp bib/IR.bib my.bib ; cat /home/maria/my2.bib >> my.bib'
	alias clean='rm *.aux *.log *.out *.pdf'
	alias pdfi='pdflatex cv.tex; evince cv.pdf'
	alias texrehash='sudo texhash'
		#--------------
		# Unix
		#--------------
	alias loadURXVTdefaults=' xrdb -load ~/.Xdefaults'
		#--------------
		# Coding
		#--------------
	alias fcsh='rlwrap fcsh'
	alias vi='vim'

	#------------------
	# Internet
	#------------------
	alias vpnc='sudo vpnc-connect'
	alias vpnd='sudo vpnc-disconnect'
	alias connectOWL='sudo ifconfig wlan0 down; sudo dhclient -r wlan0; sudo ifconfig wlan0 up; sudo iwconfig wlan0 essid "OWL"; sudo iwconfig wlan0 mode Managed; sudo dhclient -v wlan0; vpnc'
	alias stopAVAHI='sudo update-rc.d -f avahi-daemon remove'
	alias v='ps -ef | grep vpn'
	alias pp='ping www.google.com'
	#------------------
	# Getting around
	#------------------
    alias gt='ssh -T git@github.com'
	alias pj='cd /home/maria/Dropbox/Desktop/Project/frepXML'
	alias re='cd /home/maria/Dropbox/Desktop/Project/frepReport'
	alias frep='cd /home/maria/Dropbox/Desktop/Project/frep'

	#-------------------
	# Machines Oxford
	#-------------------
	alias rwin='rdesktop comla1.comlab.ox.ac.uk -f'
	alias lix='ssh kell2346@linux.ox.ac.uk'
	alias rfed='ssh c10mb@ecs.ox.ac.uk'
fi

#--------------------------------------------------------------------------------------
# AUTOCOMPLETION
#     enable programmable completion features (you don't need to enable
#     this, if it's already enabled in /etc/bash.bashrc and /etc/profile
#     sources /etc/bash.bashrc).
#--------------------------------------------------------------------------------------
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
