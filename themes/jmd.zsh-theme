sudo npm install -g jshint# -----------------------------------------------------------------------------
#          FILE: jmd.zsh-theme
#   DESCRIPTION: oh-my-zsh theme file, based on Prose, Remy and SMT.
#        AUTHOR: Jason Doyle (jasonmackdoyle@gmail.com)
#       VERSION: 0.1
# -----------------------------------------------------------------------------

# REFERENCE: https://wiki.archlinux.org/index.php/zsh

# List colors available through OMZ: spectrum_ls
# SYMBOLS:  ⇉ ⇆ ♺ ✚ ✓ ⎄ ⎇ ⤵ ⤼ ⥅ ︎⎇︎⌥ ⑁ ⑂ ⑃ ୮ ᚛᚜ ᚜᚛ ⭌ ≠ ◦ ⎆ ⨂ ⍐ ⍗ ⑆±

MODE_INDICATOR="%{$FG[196]%}❮%{$reset_color%}%{$FG[196]%}❮❮%{$reset_color%}"
local return_status="%{$FG[196]%}%(?..⏎) %{$reset_color%}"

# Variables for left prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}on%{$FG[001]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[112]%} ✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{[$FG[221]]%} ⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$reset_color%} ○︎%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_NOTSTAGED="%{$FG[172]%} ⚠%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$FG[196]%} ⎇⤵%{$reset_color%}"

# Variables for right prompt
ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[112]%} ✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[001]%} ⎄%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[196]%} ⨂%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[196]%} ♺%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[214]%} ⇉%{$reset_color%}"

ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$FG[049]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$FG[196]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$FG[196]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$FG[245]%}"


# Get the name of the server currently logged into
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

# Set the style of the prompt line
function set_prefix {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo '○'
}


# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Only proceed if there is actually a commit.
        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
            # Get the last commit.
            last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
            now=`date +%s`
            seconds_since_last_commit=$((now-last_commit))

            # Totals
            MINUTES=$((seconds_since_last_commit / 60))
            HOURS=$((seconds_since_last_commit/3600))

            # Sub-hours and sub-minutes
            DAYS=$((seconds_since_last_commit / 86400))
            SUB_HOURS=$((HOURS % 24))
            SUB_MINUTES=$((MINUTES % 60))

            if [[ -n $(git status -s 2> /dev/null) ]]; then
                if [ "$MINUTES" -gt 30 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
                elif [ "$MINUTES" -gt 10 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
                else
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
                fi
            else
                COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            fi

            if [ "$HOURS" -gt 24 ]; then
                echo "[$COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}]"
            elif [ "$MINUTES" -gt 60 ]; then
                echo "[$COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%}]"
            else
                echo "[$COLOR${MINUTES}m%{$reset_color%}]"
            fi
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            echo "[$COLOR~]"
        fi
    fi
}



PROMPT='
%{$FG[001]%}%n%{$reset_color%} at %{$FG[001]%}$(box_name)%{$reset_color%} in %{$FG[130]%}${PWD/$HOME/~} %{$FG[001]%}$(git_prompt_info)
$(set_prefix)'

RPROMPT='${return_status}$(git_time_since_commit)$(git_prompt_status)%{$reset_color%}'
