#!/usr/bin/env bash

IFS=$'\n'

for l in `terraform output`; do
    if [[ $( echo ${l}  ) =~ "login_url" ]]; then
        echo "${l}"
    fi
    if [[ $( echo ${l}  ) =~ "username" ]]; then
        echo "${l}"
    fi
    if [[ $( echo ${l}  ) =~ "password_cmd" ]]; then
        cmd=`echo $l | sed 's/password_cmd = //g'`
        echo "password = `eval "${cmd}"`"
        echo ""
    fi
done