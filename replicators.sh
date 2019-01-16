

function rucio-replicate-to() {
    # parse inputs
    if [[ $# -lt 1 ]]; then
       echo "No RSE given" >&2
       return 1
    fi
    local DATASETS=""
    if [[ ! -t 0 ]]; then
        DATASETS=$(cat)
    fi
    if [[ ! $DATASETS ]]; then
       echo "Pipe in datasets" >&2
       return 1
    fi

    # now set other things and add rules
    local DS
    local OPTS="--lifetime 1296000 --asynchronous"
    local EX=$(echo $@ | sed -r 's/\s+/|/g')

    for DS in $DATASETS; do
        rucio add-rule $DS 1 $EX $OPTS > /dev/null
        echo $DS
    done
}

function _rucio-replicate-to() {
    local LOCAL_RSE_LIST=~/.rses
    if [[ ! -f $LOCAL_RSE_LIST ]] ; then
        rucio list-rses > $LOCAL_RSE_LIST
    fi
    local DISKS=$(grep 'SCRATCHDISK$' ${LOCAL_RSE_LIST})
    local word=$2
    COMPREPLY=($(compgen -W "$DISKS" -- $word) )
    echo "completing word $COMP_CWORD, words: ${COMP_WORDS[@]}" >> log.txt
    return 0
}
complete -F _rucio-replicate-to rucio-replicate-to
