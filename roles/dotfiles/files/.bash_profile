HISTSIZE=2222
HISTFILESIZE=999999
HISTTIMEFORMAT="%Y%m%d-%T "
HISTIGNORE="&:pwd:ls:[bf]g:exit:[ \t]*"
shopt -s cmdhist
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
function hs {
grep $1 $HISTFILE
}

TERMNAME=$(echo $TERM_PROGRAM | sed 's/[^a-zA-Z0-9]//g')

if [ -z "$TERM_PROGRAM" ]
    then TERMNAME="unknown"
fi

# If you want to add a env var TERM_PROGRAM for PHP STORM see below
# https://www.jetbrains.com/help/phpstorm/2016.1/path-variables-2.html

# logs all output of session to following directory
#script -F $HOME/terminal/log/$(date +"%Y-%m-%d-t%H-%M-%S")_${TERMNAME}_$(basename $(tty)).log

#autocomplete config and known_hosts
_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh