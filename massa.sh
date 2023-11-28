alias a=alias
a h=history
a rm='rm -v'
a mv='mv -v'
a cp='cp -v'
a ln='ln -v'
a mkdir='mkdir -v'
a rmdir='rmdir -v'
a md=mkdir

a dir='ls -l'
a vdir='ls -l'
a hdir='ls'
a ll='ls -l'
a la='ls -a'
a l='ls'

if [ -x "$(which eza 2>/dev/null)" ]; then
  a ls='eza --git -F --icons=auto --color=auto'
  a dir='ls -l --header -aa'
  a vdir='ls -l --header -aa'
  a hdir='ls -G'
  a l='ls -G'
elif [ -x "$(which exa 2>/dev/null)" ]; then
  a ls='exa --git -F --icons=auto --color=auto'
  a dir='ls --format=long --header -aa'
  a vdir='ls --format=long --header -aa'
  a hdir='ls --format=vertical'
  a l='ls -G'
elif [ -x "$(which lsd 2>/dev/null)" ]; then
  a ls='lsd --color=auto'
elif [ -x "$(which gls 2>/dev/null)" ]; then
  a ls='gls --color=auto'
fi

a grep='noglob grep --color=auto'
a fgrep='noglob fgrep --color=auto'
a egrep='noglob egrep --color=auto'
a ack='noglob ack'
a ag='noglob ag'
a gr='noglob gr'
a rak='noglob rak'
a find='noglob find'
a vi='nvim'
a vd='nvim -d'
a vimdiff='nvim -d'
a gvimdiff='nvim-qt -d'
a view='nvim -R'

a pacq='package-query -AQSs'
a scp='rsync-copy'

a sx='tmux attach'
a s8='tmux neww -n almg -t 8 "ssh -t almg tmux attach"'
a s9='tmux neww -n root -t 9 "sudo -i"'
a s7='tmux neww -n  oo  -t 7 "ssh -t oo tmux attach"'
a s5='tmux neww -n  me  -t 5 "ssh me"'

a konf='git --git-dir=$HOME/Cloud/Git/dotfiles-bare.git --work-tree=$HOME'
konf config --local status.showUntrackedFiles no

a al='AlmgSocks -connect'
a ak='AlmgKillSocks'

HISTIGNORE=$HISTIGNORE${HISTIGNORE+:}a:h:ls:ll:la:l:s9:s7:sx
export EDITOR=nvim
export VISUAL=nvim
export ZSH_ZELLIJ_AUTOSTART=true
export ZSH_ZELLIJ_AUTOQUIT=false

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

if [ -d "$HOME/.local/share/nvim/mason/bin" ]; then
  PATH="$HOME/.local/share/nvim/mason/bin":"$PATH"
fi

if [ ! -x "$HOME/.local/share/rtx/bin/rtx" ]; then
  curl https://rtx.pub/install.sh | sh
else
  PATH="$HOME/.local/share/rtx/bin":"$PATH"
  PATH="$HOME/.local/share/rtx/shims":"$PATH"
  eval "$(rtx activate zsh)"
  rtx reshim
  # Lastly, clean my PATH
  [[ -x $(which raku) ]] && PATH=$(raku -e '%*ENV<PATH>.split(":").map(*.IO.resolve).grep(*.d).grep(*.dir.grep({.x and not .d}))>>.Str.unique.join(":").say')
fi

for i in $HOME $HOME/Cloud/{Mounts,Git,Work,Temp,Dropbox,Dropbox/Public}
do
  if [ -z "$CDPATH" ]; then
    CDPATH=$i
  else
    CDPATH=$CDPATH:$i
  fi
done
