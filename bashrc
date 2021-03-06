#!/bin/bash
#*****************************************************************
# Copyright (c) 2013 The 6Th Column Project
# All rights reserved.
#*****************************************************************
#
#  Organization: A Couple of Guys That Need A Life
#   Directorate: Computation
#    Department: Computing Applications and Research
#       Program: Tom Foolery
#       Project: BASH-FOO
# First Authors: Gavin M. Bell (gavin@llnl.gov) & 
#                Charles Doutriaux (doutriaux1@llnl.gov)
#
#   Description:
#   A clean and easy way to setup your bash environment that is hassle free.
#   We use lots of different machines... it makes it less painful
#
#*****************************************************************
[ -z "$PS1" ] && return


shopt -s extglob
shopt -s dotglob
shopt -s cdspell
shopt -s histappend
shopt -s checkwinsize

set -o emacs
#set -o ignoreeof
export IGNOREEOF=1

set show-all-if-ambiguous on                                                    
set visible-stats on 

export LC_CTYPE="en_US.UTF-8"
export HISTCONTROL=ignoredups
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export TMOUT=0

export BASH_COMPLETION=${HOME:-~}/.bash_completion >& /dev/null
export BASH_COMPLETION_DIR=${HOME:-~}/.bash_completion.d >& /dev/null
source $BASH_COMPLETION >& /dev/null
source $BASH_COMPLETION_DIR/* >& /dev/null
export PATH=.:~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/git/bin:/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11R6/bin:/usr/texbin:/sw/bin

export LANG="C"
export EDITOR='emacs'
export TERM="xterm-color"
export CLICOLOR="true"
#-----
# http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#-----
export LSCOLORS=dxgxcxdxbxcgcdabagacad

#-----
# http://linux-sxs.org/housekeeping/lscolors.html
#-----
export LS_COLORS="no=00:fi=00:di=33:ln=00;36:pi=40;33:so=00;35:bd=40;33;00:cd=40;33;00:or=40;31;00:ex=00;31:*.tar=00;*.class=00;22;*.jar=46;00:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.deb=00;31:*.rpm=00;31:*.jpg=00;35:*.png=00;35:*.gif=00;35:*.bmp=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.png=00;35:*.mpg=00;35:*.avi=00;35:*.fli=00;35:*.gl=00;35:*.dl=00;35:"
#-----

export GREP_OPTIONS='--color=auto' 
export GREP_COLORS='01;36;*'

export CDPATH=.:..

complete -o default -o nospace -F _git_checkout gci
complete -o default -o nospace -F _git_checkout gco
complete -o default -o nospace -F _git_checkout gls

[ -e ~/.pythonrc ] && export PYTHONSTARTUP=~/.pythonrc

declare -r _RED="\[\033[00;31m\]" >& /dev/null
declare -r _GREEN="\[\033[00;32m\]" >& /dev/null
declare -r _BLUE="\[\033[00;34m\]" >& /dev/null
declare -r _GOLD="\[\033[00;33m\]" >& /dev/null
declare -r _WHITE="\[\033[00;37m\]" >& /dev/null
declare -r _NOCOLOR="\[\033[00;00m\]" >& /dev/null
declare -r _CLOSE_COLOR="\[\033[00m\]" >& /dev/null

BASH_CACHE_DIR=${HOME}/.bash_cache

#----------------------------
# User "Theme" preferences ;-)
#----------------------------
fonts=(doom banner cybermedium digital doh dotmatrix epic fuzzy gothic hollywood isometric1 larry3d lean letters puffy pebbles script serifcap shadow slant smisome1 smslant smkeyboard speed standard starwars stop straight thin tinker-toy)

PROMPT_ADDRESS_COLOR=
PROMPT_DIR_COLOR=
PROMPT_GIT_BRANCH_COLOR=
PROMPT_COMMAND_HIST_INDEX_COLOR=
PROMPT_SHOW_FULL_PATH=
#-----------------------------



source ${HOME:-~}/.bash_aliases
source ${HOME:-~}/.bash_functions
source ${HOME:-~}/.bash_git

__local_bash_rc=${HOME:-~}/.bash_local
[ -e ${__local_bash_rc} ] && source ${__local_bash_rc}

BANNER_FONT=${fonts[$((RANDOM % ${#fonts[@]}))]}

mkdir -p ${BASH_CACHE_DIR}

#-----------------------------
# PROMPT
#-----------------------------
case "$TERM" in
    xterm | xterm-color) 
        ## Charles Doutriaux 2013-02-06
	## Commenting out gives weird character on centos and terminal length issues
	##PS1='${debian_chroot:+($debian_chroot)}\[\033[00;33m\]\u@\h\[\033[00m\]:[\033[00;31m\]\W\[\033[00m\]]$(__git_ps1 ":[\033[00;32m\]%s$(__git_prompt_info)\033[00m\]]"):[\!]> '
	if [ -z "${_PS1}" ]; then
          PS1='${debian_chroot:+($debian_chroot)}'\
${PROMPT_ADDRESS_COLOR:-${_GOLD}}'\u@\h'${_CLOSE_COLOR}\
${_NOCOLOR}':['${_CLOSE_COLOR}\
${PROMPT_DIR_COLOR:-${_RED}}'\W'${_CLOSE_COLOR}\
${_NOCOLOR}']:'${_CLOSE_COLOR}\
${PROMPT_GIT_BRANCH_COLOR:-${_GREEN}}'$(__git_ps1 "[%s$(__git_prompt_info)]\[\033[00m\]:")'\
${_NOCOLOR}'['${_CLOSE_COLOR}\
${PROMPT_COMMAND_HIST_INDEX_COLOR:-${_NOCOLOR}}'\!'${_CLOSE_COLOR}\
${_NOCOLOR}']> '${_CLOSE_COLOR}
	  _PS1=${PS1}
	fi
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007";history -a'
	;;
    *)
        if [ -z "${_PS1}" ]; then
	  PS1='${debian_chroot:+($debian_chroot)}\u@\h:[\W]:[\!]> '
	  _PS1=${PS1}
	fi
	;;
esac
#-----------------------------
show_welcome

# added by Anaconda2 4.0.0 installer
export PATH="/export/durack1/anaconda2/bin:$PATH"