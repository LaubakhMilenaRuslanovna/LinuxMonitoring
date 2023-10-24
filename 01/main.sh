#!/bin/bash

if [[ $1 =~ ^[0-9]+$ ]]
    then
    echo "Это число"
else
    if ! [ $# -eq 1 ]
    then
        echo "Неправильное значение"
    else
        echo $1
    fi
fi
