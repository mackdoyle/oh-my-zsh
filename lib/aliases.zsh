#
# Defines jdoyle specific aliases
#

# PERSONAL WORKFLOW SHORTCUTS
# -----------------------------------------------------
alias sassync="git checkout sites/all/themes/wheretraveler2_desktop_new_mobile/css/global.css sites/all/themes/wheretraveler2_desktop_new_mobile/css/global-blessed1.css sites/all/themes/wheretraveler2_desktop_new_mobile/css/contest.css"

# WEB ENVIRONMENT SERVICES
# -----------------------------------------------------
alias webstart="sudo apachectl start"
alias webstop="sudo apachectl graceful-stop"
alias webrestart="sudo apachectl restart"
alias dbstart="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
alias dbstop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
alias ftpstart="sudo launchctl load /System/Library/LaunchDaemons/ftp.plist"
alias ftpstop="sudo launchctl unload /System/Library/LaunchDaemons/ftp.plist"

# FLUSH DNS
# -----------------------------------------------------
alias flushdns="dscacheutil -flushcache"


# MySQL
# -----------------------------------------------------
alias sqltrace="sudo tail -f /var/log/mysql/error.log"
alias cdmysql="/usr/local/mysql"
alias cdmysqldata="/usr/local/var/mysql"
alias mysqlconf="open /private/etc/my.conf"

# PRETTY PS
# Format the output of the ps command. For example compare:
# $ps axu | grep mysql | prettyps to $ps axu | grep mysql
# -----------------------------------------------------
alias prettyps="~/bash/prettyps.sh"

# DASH
# Bash documentation through Dash
# -----------------------------------------------------
alias dashbash="open dash://bash:{query}"




# OTHER ALIAS BY: Sorin Ionescu <sorin.ionescu@gmail.com>
setopt CORRECT # Correct commands.
setopt auto_cd  # if the current word is not a command but is a dir, then go there

# LS
# -----------------------------------------------------
if (( $+commands[dircolors] )); then
  # GNU core utilities.
  alias ls='ls -hX --group-directories-first'

  if zstyle -t ':omz:alias:ls' color; then
    if [[ -f "$HOME/.dir_colors" ]]; then
      eval $(dircolors "$HOME/.dir_colors")
    fi
    alias ls="$aliases[ls] --color=auto"
  else
    alias ls="$aliases[ls] -F"
  fi
else
  # BSD core utilities.
  if zstyle -t ':omz:alias:ls' color; then
    export LSCOLORS="exfxcxdxbxegedabagacad"
    alias ls="ls -G"
  else
    alias ls='ls -F'
  fi
fi

alias l='ls -la'             # Show files in one column.
alias ll='ls -lh'            # Show human readable.
alias lh='ls -lhA'           # Show hidden files.
alias lx='ls -lhXB'          # Sort by extension.
alias lk='ls -lhSr'          # Sort by size, biggest last.
alias lc='ls -lhtcr'         # Sort by and show change time, most recent last.
alias lu='ls -lhtur'         # Sort by and show access time, most recent last.
alias lt='ls -lhtr'          # Sort by date, most recent last.
alias lm='ls -lha | more'    # Pipe through 'more'.
alias lr='ls -lhR'           # Recursive ls.
alias sl='ls'                # I often screw this up.



# General
# -----------------------------------------------------
alias _='sudo'
alias b="$BROWSER"
alias cd='nocorrect cd'
alias cp='nocorrect cp -i'
alias df='df -kh'
alias du='du -kh'
alias e="$EDITOR"
alias find='noglob find'
alias fc='noglob fc'
alias gcc='nocorrect gcc'
alias history='noglob history'
alias ln='nocorrect ln -i'
alias locate='noglob locate'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir -p'
alias mv='nocorrect mv -i'
alias p="$PAGER"
alias po='popd'
alias pu='pushd'
alias rake='noglob rake'
alias rm='nocorrect rm -i'
alias scp='nocorrect scp'
alias type='type -a'



# Mac OS X
 # -----------------------------------------------------
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
  alias get='curl --continue-at - --location --progress-bar --remote-name'
else
  alias o='xdg-open'
  alias get='wget --continue --progress=bar'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  fi

  if (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi

alias pbc='pbcopy'
alias pbp='pbpaste'



# Top
# -----------------------------------------------------
if (( $+commands[htop] )); then
  alias top=htop
else
  alias topm='top -o vsize'
  alias topc='top -o cpu'
fi

# Diff/Make
# -----------------------------------------------------
if zstyle -t ':omz:alias:diff' color; then
  function diff() {
    if (( $+commands[colordiff] )); then
      "$commands[diff]" --unified "$@" | colordiff --difftype diffu
    elif (( $+commands[git] )); then
      git --no-pager diff --color=auto --no-ext-diff --no-index "$@"
    else
      "$commands[diff]" --unified "$@"
    fi
  }

  function wdiff() {
    if (( $+commands[wdiff] )); then
      "$commands[wdiff]" \
        --avoid-wraps \
        --start-delete="$(print -n $FG[red])" \
        --end-delete="$(print -n $FG[none])" \
        --start-insert="$(print -n $FG[green])" \
        --end-insert="$(print -n $FG[none])" \
        "$@" \
      | sed 's/^\(@@\( [+-][[:digit:]]*,[[:digit:]]*\)\{2\} @@\)$/;5;6m\10m/g'
    elif (( $+commands[git] )); then
      git --no-pager diff --color=auto --no-ext-diff --no-index --color-words "$@"
    else
      print "zsh: command not found: $0" >&2
    fi
  }

  if (( $+commands[colormake] )); then
    alias make='colormake'
    compdef colormake=make
  fi
fi


