RESTORE='\e[0m'
BOLD='\e[1m'

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'

BLUE='\e[00;34m'
PURPLE='\e[00;35m'
CYAN='\e[36m'
LIGHTGRAY='\e[00;37m'

LRED='\e[01;31m'
LGREEN='\e[01;32m'
LYELLOW='\e[01;33m'
LBLUE='\e[01;34m'
LPURPLE='\e[01;35m'
LCYAN='\e[01;36m'
WHITE='\e[01;37m'

#  echo -e "${GREEN}Hello ${CYAN}THERE${RESTORE} Restored here ${LCYAN}HELLO again ${RED} Red socks aren't sexy ${BLUE} neither are blue ${RESTORE} "

function error {
    echo -e "${LRED}$1${RESTORE} ";
}

function success {
    echo -e "${LGREEN}$1${RESTORE} ";
}

function warn {
    echo -e "${YELLOW}$1${RESTORE} ";
}
