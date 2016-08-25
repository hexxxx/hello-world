#
# ~/.bashrc
#

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '
# PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
  # uncomment the following three lines to activate powerline bash prompt
# if [ -f /usr/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh ]; then
#     source /usr/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh
# fi
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[0;37m\]'

alias ls='ls --color=auto'
alias pipes2='pipes -p 3 -t c++++++++++++++++ -r 3000'
# alias pipes2='pipes -p 3 -t 10 -r 3000'
    #maybe 3
    #maybe 7. must be shorter than 20000
alias ws='wiki-search'
alias wsh='wiki-search-html'
alias wsl='wiki-search-lynx'
alias ll='ls -la'
alias youtube-dl-audio='youtube-dl --extract-audio --audio-format=mp3'

export PATH=$PATH:/usr/local/bin
export PATH="$HOME/.rbenv/bin:$PATH"
export VISUAL="subl"
eval "$(rbenv init -)"

# sets chromium as the environment browswer
if [ -n "$DISPLAY" ]; then
    export BROWSER=chromium
else
    export BROWSER=links
fi

###########################################
###             FUNCTIONS               ###
###########################################

# colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# simple timer
timer() {
    date1=`date +%s`; while true; do
     echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
 done
}


# simple calculator
# ex: calc 3*3
calc() {
    echo "scale=3;$@" | bc -l
}


# combined 'cd' and 'ls'
cl() {
  local dir="$1"
  local dir="${dir:=$HOME}"
  if [[ -d "$dir" ]]; then
    cd "$dir" >/dev/null; ls
else
    echo "bash: cl: $dir: Directory not found"
fi
}


# simple note utility
# $ note insert-text-here
# display contents with: $ note <no args>
# clear contents with: $ note -c
note () {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch "$HOME/.notes"
    fi

    if ! (($#)); then
        # no arguments, print file
        cat "$HOME/.notes"
    elif [[ "$1" == "-c" ]]; then
        # clear file
        printf "%s" > "$HOME/.notes"
    else
        # add all arguments to file
        printf "%s\n" "$*" >> "$HOME/.notes"
    fi
}


# simple task utility (testing)
# $ todo <task text goes here>
# $ todo -l
  # lists tasks
# $ todo -c
  # clears tasks
# $ todo -r
  # selectively remove tasks
  todo() {
    if [[ ! -f $HOME/.todo ]]; then
        touch "$HOME/.todo"
    fi

    if ! (($#)); then
        cat "$HOME/.todo"
    elif [[ "$1" == "-l" ]]; then
        nl -b a "$HOME/.todo"
    elif [[ "$1" == "-c" ]]; then
        > $HOME/.todo
    elif [[ "$1" == "-r" ]]; then
        nl -b a "$HOME/.todo"
        eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
        read -p "Type a number to remove: " number
        sed -i ${number}d $HOME/.todo "$HOME/.todo"
    else
        printf "%s\n" "$*" >> "$HOME/.todo"
    fi
}
