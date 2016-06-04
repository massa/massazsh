alias a=alias
alias h=history
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -v'
alias ln='ln -v'
alias mkdir='mkdir -v'
alias rmdir='rmdir -v'
alias md=mkdir

alias ls='ls --color=auto'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias grep='noglob grep --color=auto'
alias fgrep='noglob fgrep --color=auto'
alias egrep='noglob egrep --color=auto'
alias ack='noglob ack'
alias find='noglob find'
alias vi='nvim'
alias vd='nvim -d'
alias view='nvim -R'

alias pacq='package-query -AQSs'

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias sx='tmux attach'
alias s9='tmux neww -n root -t 9 "sudo -i"'
alias s7='tmux neww -n  oo  -t 7 "ssh -t oo tmux attach"'
alias s5='tmux neww -n  me  -t 6 "ssh me"'

if [ -x "/usr/libexec/path_helper" ]; then
  eval $(/usr/libexec/path_helper)
fi

HISTIGNORE=$HISTIGNORE${HISTIGNORE+:}a:h:ls:ll:la:l:s9:s7:sx

if [ -d "$HOME/.usr/bin" ]; then
  PATH="$HOME/.usr/bin":"$PATH"
fi

if [ -d "$HOME/.b/bin" ]; then
  PATH="$HOME/.b/bin":"$PATH"
fi

if [ -d "$HOME/.p5/bin" ]; then
  export PERLBREW_ROOT="$HOME/.p5"
  PATH="$HOME/.p5/bin":"$PATH"
  source "$HOME/.p5/etc/bashrc"
fi

if [ -d "$HOME/.usr/gnubin" ]; then
  PATH="$HOME/.usr/gnubin":"$PATH"
  MANPATH="$HOME/.usr/gnuman":"$MANPATH"
fi

for i in $HOME $HOME/Cloud/{Mounts,Git,Work,Temp,Dropbox,Dropbox/Public}
do
  if [ -z "$CDPATH" ]; then
    CDPATH=$i
  else
    CDPATH=$CDPATH:$i
  fi
done

# https://github.com/dbbolton
#
# Below are some useful Perl-related aliases/functions that I use with zsh.


# Aliases ###################################################################

# perlbrew ########
alias pbi='perlbrew install'
alias pbl='perlbrew list'
alias pbo='perlbrew off'
alias pbs='perlbrew switch'
alias pbu='perlbrew use'

# Perl ############

# perldoc`
alias pd='perldoc'

# use perl like awk/sed
alias ple='perl -wlnE'

# show the latest stable release of Perl
alias latest-perl='curl -Ls http://www.perl.org/get.html | perl -wlne '\''if (/perl\-([\d\.]+)\.tar\.gz/) { print $1; exit;}'\'



# Functions #################################################################

# newpl - creates a basic Perl script file and opens it with $EDITOR
newpl () {
	# set $EDITOR to 'vim' if it is undefined
	[[ -z $EDITOR ]] && EDITOR=vim

	# if the file exists, just open it
	if [[ -e $1 ]]; then
          print "$1 exists; not modifying.\n" && $EDITOR $1
        else
	# if it doesn't, make it, and open it
          print '#!/usr/bin/env perl'"\n"'use massa;'\
		"\n\n" > $1 && $EDITOR $1
        fi
}


# pgs - Perl Global Substitution
# find pattern		= 1st arg
# replace pattern	= 2nd arg
# filename			= 3rd arg
pgs() { # [find] [replace] [filename]
    perl -i.orig -pe 's/'"$1"'/'"$2"'/g' "$3"
}


# Perl grep, because 'grep -P' is terrible. Lets you work with pipes or files.
prep() { # [pattern] [filename unless STDOUT]
    perl -nle 'print if /'"$1"'/;' $2
}

