RESTORE='\x1B[0m'
BOLD='\x1B[1m'

RED='\x1B[31m'
GREEN='\x1B[32m'
YELLOW='\x1B[33m'

BLUE='\x1B[00;34m'
PURPLE='\x1B[00;35m'
CYAN='\x1B[36m'
LIGHTGRAY='\x1B[00;37m'

LRED='\x1B[01;31m'
LGREEN='\x1B[01;32m'
LYELLOW='\x1B[01;33m'
LBLUE='\x1B[01;34m'
LPURPLE='\x1B[01;35m'
LCYAN='\x1B[01;36m'
WHITE='\x1B[01;37m'

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
