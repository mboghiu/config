# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth


export EDITOR=vim
export GLOG_v=3
export GLOG_logtostderr=1


#-----------------
# base
#-----------------
alias tree='tree -d -L 2'
alias rm='rm -I'
alias l='ls -lh --color=always'
alias ld='ls -ld'
alias ll='ls -hla --color=always'
alias ls='ls -h --color=always'
alias grep='grep -n --color'
alias cconfigure="$CMAKE ../CMakeLists.txt .."
alias cclean='rm -rf logs/ artifact/ AS5_64/ CMakeFiles/ cmake_install.cmake Makefile CMakeCache.txt test_detail.xml'
alias run='build/debug/tree'

#-----------------
# getting places
#-----------------
alias ..='cd ..'
alias ...='cd ../..'
alias qa='cd /home/me/workspace'

#-----------------
# admin
#-----------------
alias wm_conf='vim ~/.xmonad/xmonad.hs'
alias mp='ps -ef | grep mboghiu'
alias mi='vim ~/.i3/config'
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
alias tig='tig --all'

alias xephyr='Xephyr -ac -kb -screen 1074x1889 -br -reset -terminate :1 &'
alias gdms='DISPLAY=:1.0 gnome-session --session=2d-gnome'
