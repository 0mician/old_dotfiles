# Modules
autoload -U compinit promptinit zcalc colors
compinit
promptinit
colors

##########################
### Completion
##########################

# Faster! (?)
zstyle ':completion::complete:*' use-cache 1

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' completer _oldlist _expand _complete
zstyle ':completion:*' completer _expand _complete _approximate _ignored

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'

# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse

# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

# Egomaniac!
zstyle ':completion:*' list-separator 'fREW'

# complete with a menu for xwindow ids
zstyle ':completion:*:windows' menu on=0
zstyle ':completion:*:expand:*' tag-order all-expansions

# more errors allowed for large words and fewer for small words
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'

# Errors format
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'

# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true

# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd

zstyle ':completion::approximate*:*' prefix-needed false

# kill
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# git, subversion, mercural
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{red}:%f%F{yellow}%r%f'
zstyle ':vcs_info:*' enable git

# noms d'hôtes
local _myhosts
if [ -d ~/.ssh ]; then
  if [ -f ~/.ssh/known_hosts ];then
    _myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
   fi
fi
zstyle ':completion:*' hosts $_myhosts

###############
### Aliases ###
###############


alias ls='ls -F --color=auto'
alias rm='rm -I --preserve-root'
alias grep='grep --color=auto'
alias mv='mv -i'
alias cp='cp -ir'
alias mkdir='mkdir -p'
alias ch='cd ~'
alias es='emacs -nw'
alias ll='ls -la'
alias off='sudo shutdown -h now'
alias rs='redshift -m randr -t 5500K:4500 -l 50.8:4.3'
alias li='sudo /usr/bin/intel_backlight'
alias re='arecord -f cd -q `(date "+%B%d,%Y[%T]")`.wav'

###########
### ENV ###
###########

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

###########
# HISTORY #
###########

HISTFILE=~/.history

# Bumps up history memory

SAVEHIST=10000
HISTSIZE=10000

# Don't overwrite, append!
setopt APPEND_HISTORY

# Write after each command
setopt INC_APPEND_HISTORY

# Killer: share history between multiple shells
setopt SHARE_HISTORY

# If I type cd and then cd again, only save the last one
setopt HIST_IGNORE_DUPS

# Even if there are commands inbetween commands that are the same, still only save the last one
setopt HIST_IGNORE_ALL_DUPS

# Pretty    Obvious.  Right?
setopt HIST_REDUCE_BLANKS

# If a line starts with a space, don't save it.
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# When using a hist thing, make a newline show the change before executing it.
setopt HIST_VERIFY

# Save the time and how long a command ran
setopt EXTENDED_HISTORY

setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

##############
### Prompt ###
##############

setopt prompt_subst

# Detection du type de gestionnaire de version
function prompt_char {
  git branch >/dev/null 2>/dev/null && echo ' ±' && return
  hg root >/dev/null 2>/dev/null && echo ' ☿' && return
  echo 'n' && return
}

# prompt
function precmd {
    if [ `id -u` -eq 0 ]; then # if root
        local dircol="%{${fg_no_bold[red]}%}"
        local sign=" #"
    else
        local dircol="%{${fg_no_bold[green]}%}"
        local sign=">"
    fi

    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '%b%c%u'
    } else {
        zstyle ':vcs_info:*' formats '%b%c%u%f%F{red}●%F{cyan}'
    }

    vcs_info

    if [[ `prompt_char` == "n" ]]; then
        vcs_str=""
    else
        vcs_str="%F{cyan}[${prompt_char}${vcs_info_msg_0_}%F{cyan}]%F{white} "
    fi

    export PS1="${dircol}%}%~%{${reset_color}%}${sign} "
    export RPS1='${virtualenv_str}${vcs_str}%F{white}%F{green}${computername}%f'
}

#swap keys

setxkbmap -option ctrl:swapcaps
setxkbmap -option ctrl:nocaps

