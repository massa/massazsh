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
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# alias s9='tmux neww -n Root -t 9 "sudo su -"'
# alias s7='tmux neww -n Home -t 7 "ssh -t home screen -xRR"'
# alias s7='tmux neww -n Home -t 7 "ssh -t oo tmux attach -t Home"'
# alias s6='tmux neww -n Me -t 6 "ssh -t me tmux new -s Me"'
# alias sx='tmux attach -t Work || tmux new -s Work'

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

for i in $HOME $HOME/Cloud/{Git,Work,Temp,Dropbox,Dropbox/Public}
do
  if [ -z "$CDPATH" ]; then
    CDPATH=$i
  else
    CDPATH=$CDPATH:$i
  fi
done

