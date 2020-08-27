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
    # Set to 1 if you want to remove dirty checks. This improves performance
    __DISABLE_GIT_STATUS=

    BRANCH="$(__git_ps1 '%s')"
    STATUS=
    if [[ ! -z $BRANCH ]]; then
        HASH=$(git rev-parse --short HEAD)

        if [[ -z $__DISABLE_GIT_STATUS ]]; then
           STATUS=$(git status --porcelain --ignore-submodules -unormal | cut -c-2 | uniq)
        fi

        COLOR=${__GREEN}
        BG_COLOR=${__BG_GREEN}

        while IFS=$'\n' read -ra STATS; do
            for i in "${STATS[@]}"; do
                if [[ "$i" == " M" || "$i" == " A" || "$i" == " D" ]]; then
                    UNSTAGED=" "
                fi
                if [[ "$i" == "M " || "$i" == "A " || "$i" == "D " || "$i" == "R " || "$i" == "C " ]]; then
                    STAGED=" "
                fi
                if [[ "$i" == "??" ]]; then
                    UNTRACKED=" "
                fi
            done
        done <<< "$STATUS"

        if [[ ! -z $UNSTAGED || ! -z $STAGED ]]; then
            COLOR=${__YELLOW}
            BG_COLOR=${__BG_YELLOW}
        fi

        echo "${__BS}${BG_COLOR}${__BLACK}   ${HASH}  ${BRANCH}${STAGED}${UNSTAGED}${UNTRACKED} ${__RESET}${COLOR}"
    fi
}

update_python_env() {
   # Cached version
   if [[ ! -z $VIRTUAL_ENV && "$VIRTUAL_ENV" != "$__PS1_VIRTUAL_ENV" ]]; then
      export __PS1_VIRTUAL_ENV="$VIRTUAL_ENV"
      export __PS1_PYTHON_VERSION="$(python -V)"
      export __PS1_PYTHON_BASEDIR="$(basename $VIRTUAL_ENV)"
   elif [[ -z $VIRTUAL_ENV && "$PATH" != "$__PS1_PATH" ]]; then
      export __PS1_PATH="$PATH"
      export __PS1_PYTHON_VERSION="$(python -V)"
      WHICH_PATH=$(which python)
      if [[ "$WHICH_PATH" == "/c/Python38/python" ]]; then
         export __PS1_PYTHON_BASEDIR="System"
      else
         export __PS1_PYTHON_BASEDIR="$(basename $WHICH_PATH)"
      fi
   fi
}

virtualenv_status() {

   if [[ ! -z $__PS1_PYTHON_VERSION ]]; then
      echo "${__BS}${__BG_CYAN}${__BLACK}  ${__PS1_PYTHON_VERSION} (${__PS1_PYTHON_BASEDIR}) ${__RESET}${CYAN}"
   fi
}

update_ps1() {
   __PS1_WINDOWS="${__WHITE}${__BG_RED}  ${__RESET}${__RED}"
   __PS1_LOCATION="${__BS}${__BG_BLUE}${__BLACK}  \w ${__RESET}${__BLUE}"
   __PS1_GIT_BRANCH="$(git_status)"

   # This function exports variables so cannot be run inline
   update_python_env
   __PS1_PYTHON="$(virtualenv_status)"
   
   export PS1="${__PS1_WINDOWS}${__PS1_LOCATION}${__PS1_PYTHON}${__PS1_GIT_BRANCH}${__RESET}
▶ " 
}

export PROMPT_COMMAND=update_ps1
