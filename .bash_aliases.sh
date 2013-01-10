# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth


export PRINTER=xerox
export EDITOR=vim
export CVSEDITOR=vim
export CVSROOT=':pserver:mboghiu@mack:/cvsroot/1.0'

# My vars
export VM='maria-centos5-64'
export PLATFORM='AS5_64'
export BIN='/home/mboghiu/Documents/workspace'
export REPOSITORY='/mnt/build_share/repository'
export THIRDPARTY='/mnt/build_share/sherman/home/thirdparty'
export LD_LIBRARY_PATH=""
export _JAVA_AWT_WM_NONREPARENTING=1
export MAIL='~/Maildir'


export DEPTOOL='/mnt/build_share/repository/deptool'
export LOCAL_REPO='/home/mboghiu/workspace/LOCAL_REPO'
export REPO_PATH="${LOCAL_REPO}:/mnt/build_share/repository/"
export CLASSIFIER='AS5_64-debug'
export LD_LIBRARY_PATH=''

export CMAKE='/mnt/build_share/sherman/home/thirdparty/cmake/cmake-2.8.4-Linux-i386/bin/cmake'
export OPTIMIZE='NO'

export GLOG_v=3
export GLOG_logtostderr=1


#-----------------
# base
#-----------------

alias rm='rm -I'
alias l='ls -lh --color=always'
alias ll='ls -hla --color=always'
alias ls='ls -h --color=always'
alias grep='grep -n --color'

alias cconfigure="$CMAKE ../CMakeLists.txt .."
alias clean='rm -rf AS5_64/ artifact/ Makefile*'
alias cclean='rm -rf logs/ artifact/ AS5_64/ CMakeFiles/ cmake_install.cmake Makefile CMakeCache.txt test_detail.xml'
alias rmlocalrepo='rm -irf /home/mboghiu/workspace/LOCAL_REPO'

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

alias bld='sudo chroot ~/vm-chroot /bin/bash -c "su - mboghiu"'

#-----------------
# misc/temp
#-----------------
