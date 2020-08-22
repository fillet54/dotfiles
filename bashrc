. ~/.dotfiles/bash/env
. ~/.dotfiles/bash/config
. ~/.dotfiles/bash/aliases

# Color Escapes
__WHITE="\[\e[37m\]"
__BLACK="\[\e[30m\]"
__RED="\[\e[31m\]"
__BLUE="\[\e[34m\]"
__GREEN="\[\e[32m\]"
__YELLOW="\[\e[33m\]"
__CYAN="\[\e[36m\]"
__BG_RED="\[\e[41m\]"
__BG_BLUE="\[\e[44m\]"
__BG_GREEN="\[\e[42m\]"
__BG_YELLOW="\[\e[43m\]"
__BG_CYAN="\[\e[46m\]"
__BS="\[\e[1D\]"
__RESET="\[\e[0m\]"
__BG_DEFAULT="\[\e[49m\]"

git_status() {
    BRANCH="$(__git_ps1 '%s')"
    STATUS=
    if [[ ! -z $BRANCH ]]; then
        HASH=$(git rev-parse --short HEAD)
        STATUS=$(git status --porcelain --ignore-submodules -unormal | cut -c-2 | uniq)

        COLOR=${__GREEN}
        BG_COLOR=${__BG_GREEN}

        while IFS=$'\n' read -ra STATS; do
            for i in "${STATS[@]}"; do
                if [[ "$i" == " M" || "$i" == " A" || "$i" == " D" ]]; then
                    UNSTAGED=" "
                fi
                if [[ "$i" == "M " || "$i" == "A " || "$i" == "D " ]]; then
                    STAGED=" "
                fi
                if [[ "$i" == "??" ]]; then
                    UNTRACKED=" "
                fi
            done
        done <<< "$STATUS"

        if [[ ! -z $UNSTAGED || ! -z $STAGED || ! -z $UNTRACKED ]]; then
            COLOR=${__YELLOW}
            BG_COLOR=${__BG_YELLOW}
        fi

        echo "${__BS}${BG_COLOR}${__BLACK}   ${HASH}  ${BRANCH}${STAGED}${UNSTAGED}${UNTRACKED} ${__RESET}${COLOR}"
    fi
}

virtualenv_status() {
    if [[ ! -z $VIRTUAL_ENV ]]; then
        echo "${__BS}${__BG_CYAN}${__BLACK}  ${VIRTUAL_ENV} ${__RESET}${CYAN}"
    fi
}

update_ps1() {
   __PS1_WINDOWS="${__WHITE}${__BG_RED}  ${__RESET}${__RED}"
   __PS1_LOCATION="${__BS}${__BG_BLUE}${__BLACK}  \w ${__RESET}${__BLUE}"
   __PS1_GIT_BRANCH=$(git_status)
   __PS1_PYTHON=$(virtualenv_status)
   
   export PS1="${__PS1_WINDOWS}${__PS1_LOCATION}${__PS1_PYTHON}${__PS1_GIT_BRANCH}${__RESET}
▶ " 
}

PROMPT_COMMAND='update_ps1'
