#!/usr/bin/env bash

parallel() {
    local workers="$1" handler="$2" w i
    shift 2
    local elements=("$@")
    for ((w = 0;w < workers;++w))
    do
        for (( i = w ;i < ${#elements[@]} ;i += workers ))
        do
            exec "$handler" "${elements[i]}"
        done &
    done
    wait
}

# Example:
#   parallel 5 md5 *.txt
