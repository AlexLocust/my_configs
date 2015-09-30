# The following lines were added by compinstall
setopt nonomatch
source /etc/profile
unsetopt nonomatch

path=( $path $HOME/.bin /usr/local/bin )
    export HISTFILE=${HOME}/.bash_history
    export HISTSIZE=9999999999999
    export SAVEHIST=9999999999999
    export USER=$USERNAME
    export HOSTNAME=$HOST
    export LANG="ru_RU.UTF-8"
    export SHELL=$(which zsh)
    export EDITOR=$(which vim)

    unset profile_func

    case $TERM in
        *xterm*)
            precmd () {print -Pn "\e]0;%n@%M: %~\a"} ;;
        *screen*)
            RPROMPT=$'%{\e[1;34m%}'$TERM$'%{\e[0m%}'
    esac
zstyle :compinstall filename '$HOME/.zshrc'

if test -e ~/.zsh/completion
    then fpath=(~/.zsh/completion $fpath)
fi

if test -e /usr/local/share/zsh/site-functions
    then fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

autoload -Uz compinit
autoload -U incremental-complete-word
autoload -U insert-files
autoload -U predict-on
autoload -U colors && colors
zle -N incremental-complete-word
zle -N insert-files
zle -N predict-on
compinit -u
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -a zsh/mapfile mapfile

bindkey '\e[3~' delete-char     # del
bindkey "^[OF"  end-of-line     # END key
bindkey '\e[4~' end-of-line     # END key
bindkey "^[OH"  beginning-of-line   # HOME key
bindkey '\e[1~' beginning-of-line   # HOME key

# History completion on pgup and pgdown
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\e[5~" history-beginning-search-backward-end
bindkey "\e[6~" history-beginning-search-forward-end

zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'

if test -e /usr/bin/dircolors
    then eval `dircolors`;
    else LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
fi

zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

setopt autocd
setopt CORRECT_ALL
SPROMPT="Может: %r, вместо: %R? ([Y]es/[N]o/[E]dit/[A]bort) "
#
zstyle ':completion:*' menu select=long-list select=0

if [[ $EUID != 0 ]]
then PROMPT=$'%{\e[1;32m%}%n@%M %{\e[1;34m%}%~ $%{\e[0m%} ' # user dir #
else PROMPT=$'%{\e[1;31m%}%M %{\e[1;34m%}%~ #%{\e[0m%} ' # root dir %
fi
#RPROMPT=$'%{\e[1;34m%}'$TERM$'%{\e[0m%}' # right prompt with time

zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' old-menu false
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' word true
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# Some environment variables $HOME/.cw/def

# Avoid network problems
#   ... \177 (ASCII-DEL) and \010 (ASCII-BS)
#       do `backward-delete-char'
# Note: `delete-char' is maped to \033[3~
#       Therefore xterm's responce on pressing
#       key Delete or KP-Delete should be
#       \033[3~ ... NOT \177
bindkey    "^?"      backward-delete-char
bindkey    "^H"      backward-delete-char

if [[ "$TERM" == "xterm" ]] then
    # Normal keypad and cursor of xterm
    bindkey    "^[[1~"   history-search-backward
    bindkey    "^[[4~"   set-mark-command
    bindkey    "^[[H"   beginning-of-line
    bindkey    "^[[F"   end-of-line
    # Home and End of application keypad and cursor of xterm
    bindkey    "^[OH"   beginning-of-line
    bindkey    "^[OF"   end-of-line
    bindkey    "^[O5H"   beginning-of-line
    bindkey    "^[O5F"   end-of-line
else
if [[ "$TERM" == "kvt" ]] then
    bindkey    "^[[1~"   history-search-backward
    bindkey    "^[[4~"   set-mark-command
    bindkey    "^[OH"   beginning-of-line
    bindkey    "^[OF"   end-of-line
else
    # TERM=linux or console
    bindkey    "^[[1~"   beginning-of-line
    bindkey    "^[[4~"   end-of-line
fi
fi

# Application keypad and cursor of xterm
if [[ "$TERM" == "xterm" ]] then
    bindkey    "^[OD"   backward-char
    bindkey    "^[OC"   forward-char
    bindkey    "^[OA"   up-history
    bindkey    "^[OB"   down-history
    # DEC keyboard KP_F1 - KP_F4
    bindkey -s "^[OP"   "^["
    bindkey    "^[OQ"   undo
    bindkey    "^[OR"   undefined-key
    bindkey    "^[OS"   kill-line
fi

if [[ "$TERM" == "gnome" ]] then
    # or gnome terminal F1 - F4
    bindkey -s "^[OP"   "^["
    bindkey    "^[OQ"   undo
    bindkey    "^[OR"   undefined-key
    bindkey    "^[OS"   kill-line
fi
# Function keys F1 - F12
if [[ "$TERM" == "linux" ]] then
    # On console the first five function keys
    bindkey    "^[[[A"   undefined-key
    bindkey    "^[[[B"   undefined-key
    bindkey    "^[[[C"   undefined-key
    bindkey    "^[[[D"   undefined-key
    bindkey    "^[[[E"   undefined-key
else
    # The first five standard function keys
    bindkey    "^[[11~"   undefined-key
    bindkey    "^[[12~"   undefined-key
    bindkey    "^[[13~"   undefined-key
    bindkey    "^[[14~"   undefined-key
    bindkey    "^[[15~"   undefined-key
fi
bindkey    "^[[17~"      undefined-key
bindkey    "^[[18~"      undefined-key
bindkey    "^[[19~"      undefined-key
bindkey    "^[[20~"      undefined-key
bindkey    "^[[21~"      undefined-key
# Note: F11, F12 are identical with Shift_F1 and Shift_F2
bindkey    "^[[23~"      undefined-key
bindkey    "^[[24~"      undefined-key

# Shift Function keys F1  - F12
#      identical with F11 - F22
#
# bindkey   "^[[23~"   undefined-key
# bindkey   "^[[24~"   undefined-key
bindkey    "^[[25~"      undefined-key
bindkey    "^[[26~"      undefined-key
# DEC keyboard: F15=^[[28~ is Help
bindkey    "^[[28~"      undefined-key
# DEC keyboard: F16=^[[29~ is Menu
bindkey    "^[[29~"      undefined-key
bindkey    "^[[31~"      undefined-key
bindkey    "^[[32~"      undefined-key
bindkey    "^[[33~"      undefined-key
bindkey    "^[[34~"      undefined-key

if [[ "$TERM" == "xterm" ]] then
    # Not common
    bindkey    "^[[35~"   undefined-key
    bindkey    "^[[36~"   undefined-key
fi

if [[ "$TERM" == "xterm" ]] then
    # Application keypad and cursor of xterm
    # with NumLock ON
    #
    # Operators
    bindkey -s "^[Oo"   "/"
    bindkey -s "^[Oj"   "*"
    bindkey -s "^[Om"   "-"
    bindkey -s "^[Ok"   "+"
    bindkey -s "^[Ol"   ","
    bindkey -s "^[OM"   "\n"
    bindkey -s "^[On"   "."
    # Numbers
    bindkey -s "^[Op"   "0"
    bindkey -s "^[Oq"   "1"
    bindkey -s "^[Or"   "2"
    bindkey -s "^[Os"   "3"
    bindkey -s "^[Ot"   "4"
    bindkey -s "^[Ou"   "5"
    bindkey -s "^[Ov"   "6"
    bindkey -s "^[Ow"   "7"
    bindkey -s "^[Ox"   "8"
    bindkey -s "^[Oy"   "9"
fi

if [[ "$TERM" == "xterm" ]] then
   bindkey    "^[^[OD"   backward-word
   bindkey    "^[^[OC"   forward-word
   bindkey    "^[^[OA"   up-history
   bindkey    "^[^[OB"   down-history
   bindkey    "^^[OD"   backward-char
   bindkey    "^^[OC"   forward-char
   bindkey    "^^[OA"   up-history
   bindkey    "^^[OB"   down-history
fi

# Standard cursor
bindkey    "^[^[[D"   backward-word
bindkey    "^[^[[C"   forward-word
bindkey    "^[^[[A"   up-history
bindkey    "^[^[[B"   down-history
bindkey    "^^[[D"   backward-char
bindkey    "^^[[C"   forward-char
bindkey    "^^[[A"   up-history
bindkey    "^^[[B"   down-history

# Online help
unalias  run-help 2>/dev/null || true
autoload run-help

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Don't use zsh builtin which
alias which >/dev/null && unalias which

# Common standard keypad and cursor
bindkey    "^[[2~"      yank
bindkey    "^[[3~"      delete-char

#putty
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

if [[ "$(uname -s)" == "Darwin" ]] then
    path=( /usr/local/bin /usr/local/sbin /usr/local/share/python ~/.bin $path )

    bindkey '^[[H'  beginning-of-line       # Home
    bindkey '^[[F'  end-of-line             # End

    alias sublime='open -a "Sublime Text"'
    alias chrome='open -a "Google Chrome"'
    alias skype='open -a "Skype"'
    alias gitx='open -a "GitX"'
    alias vlc='open -a "VLC"'
fi

if test -e $HOME/.rvm/scripts/rvm;
  then source $HOME/.rvm/scripts/rvm
fi

if test -e ~/.bin/functions; then
    for file in ~/.bin/functions/*
        do source $file
    done
fi

if test -e $HOME/.zsh; then source $(find .zsh -depth 1 -type f); fi

export PATH="/usr/local/p/versions/python:$PATH"

# ASchukarev. 09.07.2015 - set NPAPI SDK
export NACL_SDK_ROOT="/home/aschukarev/nacl_sdk/pepper_43"

