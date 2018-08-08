#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias melb-vpn='sudo openconnect remote.unimelb.edu.au/student'
alias melb-ssh='ssh gkaw@dimefox.eng.unimelb.edu.au'
alias please='sudo $(fc -ln -1)'
#Enter correct directory when exiting ranger
alias ran='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

alias scrot="scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Pictures/Screenshots'"
alias setkb="setxkbmap -layout au -option caps:ctrl_modifier" 
alias rm="rm -i"
alias kilall="killall"

alias discord="flatpak run com.discordapp.Discord"


# Location aliases
alias gs="cd ~/Documents/school/"
alias gc="cd ~/Documents/school/COMP10002/assessment_2"
alias dot="vim ~/dotrectory.md"

PS1='[\u@\h \W]\$ '

#set -o vi

#Makes 
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


(cat ~/.cache/wal/sequences &)

