# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

##---PERSONAL---##
alias ls="ls --color"
alias ll="ls -l"
alias la="ls -a"
LS_COLORS=$LS_COLORS:'di=0;36:fi=0;92:ex=0;94:' ; export LS_COLORS

PS1="\n[\u@\H]\n:\W> "
#PS1="\n\[\e[1;31m\]\A \w \[\e[0m\]\n"

export LANG="es_ES.UTF-8"
export LANGUAGE="es_ES.UTF-8"
export EDITOR="vim"

img_path=~/.config/neofetch/img.jpg
##------ALIASES

#Commands
alias py="python2"
alias rm="rm -vi"
alias cp="cp -ir"
alias mv="mv -i"
alias armk="cp ~/.source_files/Makefile ."

#Directories
alias ..="cd .."
alias ...="cd ../.."
alias home="cd"
alias b="cd -"
alias z="clear"
alias q="exit"
alias v="vim"

#Config Files
alias .b="vim ~/.bashrc && source ~/.bashrc"
alias .x="vim ~/.xinitrc"
alias .v="vim ~/.vimrc"
alias .t="vim ~/.config/termite/config"
alias .c="vim ~/.config/i3/config"
alias .cy="vim ~/.config/i3/conkyrc"
alias .xr="vim ~/.Xresources && xrdb ~/.Xresources"
alias .mn="vim ~/.config/openbox/menu.xml && openbox --reconfigure"
alias .rc="vim ~/.config/openbox/rc.xml && openbox --reconfigure"

#Packages
alias ainstall="sudo pacman -S"
alias aremove="sudo paccache -ruk0"
alias remove="sudo pacman -Rsnc"
alias update="sudo pacman -Syy"
alias purge="sudo pacman -Sc"
alias upgrade="sudo pacman -Syyu"

#Utilities
alias arch="z && screenfetch"
alias arch2="z && neofetch --w3m $img_path"
alias nfi="cp $1 $img_path"
alias ayy="echo lmao"
alias bye="exit"
alias delswapfiles="find ./ -type f -name '\.*sw[kvlmnop]' -delete"
alias fuck='sudo $(history -p \!\!)'
alias clock="while sleep 2;do 
				tput sc;
				tput cup 0 $(($(tput cols)-29));
				date;
				tput rc;
			done &"
alias last="echo $(fc -ln -2) | tail -n 1 | cut -d' ' -f2- |xargs $1"
alias myip="curl http://ipecho.net/plain"
alias nano="vim"
alias pingg="ping -c 4 google.com"
alias pipes="pipes && z"
alias please="fc -ln -100 | grep $2"
alias pleaseall="fc -ln -1000 | less"
alias pleasef="fc -ln -1000 | grep $2"
alias sauce="source ~/.bashrc"
alias save='echo $(history -p \!\!) >> commands'
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias tempwatch="while :; do sensors; sleep 1 && clear; done"
alias vis="transset-df -a --dec .2 && vis && transset-df -a --inc .2"
alias weather="curl --silent http://wttr.in/ | head -7"
alias weatherv="curl --silent http://wttr.in/Vigo |head -7"

alias ydd="youtube-dl --no-mtime"
alias yv="youtube-viewer --video-player=mpv --region=ES"
alias yva="yv --login"
alias yvs="yv -S"

alias emulate="emulator -avd nexus -use-system-libs -no-boot-anim -scale 0.65 -show-kernel"


##------FUNCTIONS

#Moves to a dir and lists the files
function cdd(){
	cd  $1 && ls
}

#Create a dir and cd into it
function mdd(){
	mkdir -p $1 && cd $1
}

#Move element to a dir and cd into it
function mvd(){
	mv $1 $2 && cd $2
}

#Pretend to be busy
function grepcolor(){
	cat /dev/urandom | hexdump -C | grep --color=auto "ca fe"
}

#send to pi
function cppi(){
	scp $1 adrian@192.168.0.28:/home/adrian
}

#copy img to print with neofetch
function nzi(){
	cp -f $1 $img_path
}
#create a new Arduino project
function arnp(){
	pro_name=$1
	tmp_dir=~/Documentos/arduino_projects/$1
	mkdir $tmp_dir
	cd $tmp_dir
	armk
	cp ~/.source_files/arduino_skel.ino $1.ino
	vim $1.ino
}

#Youtube-dl
function yd(){

	if [ "$#" -lt 1 ]; then
		return
	fi
	if [ "$#" -lt 2 ]; then
		dir="~/Videos"
	else
		dir=$2
		mkdir -p $dir
	fi

	dir=$dir"/%(title)s.%(ext)s"
	
	ydd --recode-video webm -o $dir $1

}

function ydm(){

	if [ "$#" -ne 2 ]; then
		echo "ydm url name"
		return
	fi

	dir="~/Videos/Musica/"$2
	mkdir -p $dir

	dir=$dir"/%(title)s.%(ext)s"

	ydd -x --audio-format mp3 -o $dir $1

}

#VPN FIC
function vpnu(){
	screen -m -S vpn sudo openconnect --juniper vpn.udc.es/estudantes --user=adrian.estevez1
}

function 4chan() {

    if [[ $# -ne 1 ]]
    then
        echo 'No URL specified! Give the URL to thread as the ONLY argument'
        return 1
    fi

    url=$1

    grep 'boards\.4chan\.org/[a-z0-9]\{1,4\}/thread/[0-9]\{4,12\}.*' <<< $url 2>&1 > /dev/null
    exit_code=$?    # I know this isn't the best approach, but it's the best I can come up with.
    if [[ $exit_code -ne 0 ]]
    then
        echo 'Malformed URL! Give the URL to thread as the ONLY argument'
        return 2
    fi

    curl -k -f -s $url 2>&1 > /dev/null
    exit_code=$?    # I know this isn't the best approach, but it's the best I can come up with.
    if [[ $exit_code -ne 0 ]]
    then
        echo 'Invalid URL! Or you don`t have permission to view the page'
        return 3
    fi

    if [[ $(grep '^http' <<< $url) ]]    # If thread doesn't have any protocol, add https
    then
        :
    else
        url=$(sed 's/^/https:\/\//' <<< $url)
    fi

    if [[ $(grep '^http:' <<< $url) ]]
    then
        url=$(sed 's/^http\(.*\)$/https\1/' <<< $url)
    fi

    total=$(curl -k -s $url | grep -o '\/\/i\.4cdn\.org\/.\{1,4\}\/[0-9]\{6,15\}\.[a-z]\{3,4\}' | uniq | wc -l)
    counter=1

	number=$(echo $url | rev | cut -d/ -f1 | rev)
	board=$(echo $url | rev | cut -d/ -f3 | rev)
	cd ~/Imagenes/4chan/

	if [ ! -d "$board" ]; then
		mkdir $board
	fi
	cd $board
	
	if [ ! -d "$number" ]; then
		mkdir $number
	fi
	cd $number


    echo -n Downloading total of $total images ...
    for image_url in $(curl -k -s $url | grep -o '\/\/i\.4cdn\.org\/.\{1,4\}\/[0-9]\{6,15\}\.[a-z]\{3,4\}' | uniq | sed 's/^/https:/')
    do
        wget --no-check-certificate -q -nc $image_url -o trash
        counter=$(($counter + 1))
    done
    echo -n thread $number done
}

##SYSTEMC
export SYSTEMC_HOME=/opt/systemc231
alias gss="g++ -I. -I$SYSTEMC_HOME/include -L. -L$SYSTEMC_HOME/lib-linux64 -Wl,-rpath=$SYSTEMC_HOME/lib-linux64 -lsystemc -lm"
alias gsso="g++ -I. -I$SYSTEMC_HOME/include -L. -L$SYSTEMC_HOME/lib-linux64 -Wl,-rpath=$SYSTEMC_HOME/lib-linux64 -lsystemc -lm -o"
stty -ixon #Vim no se bloquea al pulsa C-s



#Arduino Makefile
export ARDUINO_DIR=/usr/share/arduino
export ARDMK_DIR=/home/adrian/.arduino_mk
export AVR_TOOLS_DIR=/usr
#export USER_LIB_PATH=/home/adrian/Arduino/libraries
export ARDUINO_LIB_PATH=$ARDUINO_DIR/hardware/archlinux-arduino/avr/libraries
export ARDUINO_PLATFORM_LIB_PATH=$ARDUINO_LIB_PATH

#Android
export ANDROID_HOME=~/opt/android-sdk
PATH=$PATH:~/opt/android-sdk/tools
