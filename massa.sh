alias a=alias
alias h=history
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -v'
alias ln='ln -v'
alias mkdir='mkdir -v'
alias rmdir='rmdir -v'
alias md=mkdir

alias ls='exa --color=automatic --color-scale'
alias dir='exa --color=automatic --color-scale --format=vertical'
alias vdir='exa --color=automatic --color-scale --format=long'
alias grep='noglob grep --color=auto'
alias fgrep='noglob fgrep --color=auto'
alias egrep='noglob egrep --color=auto'
alias ack='noglob ack'
alias find='noglob find'
alias vi='nvim'
alias vd='nvim -d'
alias vimdiff='nvim -d'
alias gvimdiff='nvim-qt -d'
alias view='nvim -R'

alias pacq='package-query -AQSs'
alias scp='rsync-copy'

alias ll='ls -l'
alias la='ls -a'
alias l='ls -GF'

alias sx='tmux attach'
alias s8='tmux neww -n almg -t 8 "ssh -t almg tmux attach"'
alias s9='tmux neww -n root -t 9 "sudo -i"'
alias s7='tmux neww -n  oo  -t 7 "ssh -t oo tmux attach"'
alias s5='tmux neww -n  me  -t 5 "ssh me"'

alias konf='git --git-dir=$HOME/Cloud/Git/dotfiles-bare.git --work-tree=$HOME'
konf config --local status.showUntrackedFiles no

alias al='AlmgSocks -connect'
alias ak='AlmgKillSocks'

HISTIGNORE=$HISTIGNORE${HISTIGNORE+:}a:h:ls:ll:la:l:s9:s7:sx
export EDITOR=nvim
export VISUAL=nvim
export ZSH_TMUX_UNICODE=true
export ZSH_TMUX_AUTOCONNECT=true

if [ -x "/usr/libexec/path_helper" ]; then
  eval $(/usr/libexec/path_helper)
fi

if [ -x "$(which kitty 2>/dev/null)" ]; then
  . <(kitty + complete setup zsh)
fi

if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
  [ -x /home/linuxbrew/.linuxbrew/bin/brew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

if [ -d "/usr/local/bin" ]; then
  [ -x /usr/local/bin/brew ] && eval $(/usr/local/bin/brew shellenv)
fi

if [ -d "$HOME/.usr/bin" ]; then
  PATH="$HOME/.usr/bin":"$PATH"
fi

if [ -d "$HOME/.usr/gnubin" ]; then
  PATH="$HOME/.usr/gnubin":"$PATH"
  MANPATH="$HOME/.usr/gnuman":"$MANPATH"
fi

if [ -d "$HOME/.p5/bin" ]; then
  export PERLBREW_ROOT="$HOME/.p5"
  PATH="$HOME/.p5/bin":"$PATH"
  source "$HOME/.p5/etc/bashrc"
fi

if [ -d "$HOME/.local/node_modules/.bin" ]; then
  PATH="$HOME/.local/node_modules/.bin":"$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin":"$PATH"
fi

if [ -d "$HOME/.raku/bin" ]; then
  PATH="$HOME/.raku/bin":"$PATH"
fi

if [ ! -x "$HOME/.local/share/rtx/bin/rtx" ]; then
  curl https://rtx.pub/install.sh | sh
fi
PATH="$HOME/.local/share/rtx/bin":"$PATH"
PATH="$HOME/.local/share/rtx/shims":"$PATH"
eval "$(rtx activate zsh)"

case "$SHELL" in
  (*/zsh)
    [ -x "$HOME/.rakubrew/bin/rakubrew" ] && eval "$($HOME/.rakubrew/bin/rakubrew init Zsh)"
    ;;
esac

for i in $HOME $HOME/Cloud/{Mounts,Git,Work,Temp,Dropbox,Dropbox/Public}
do
  if [ -z "$CDPATH" ]; then
    CDPATH=$i
  else
    CDPATH=$CDPATH:$i
  fi
done
