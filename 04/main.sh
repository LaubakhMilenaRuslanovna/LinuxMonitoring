#!/bin/bash

if  [ $# -ne 0 ]
then
    echo "слишком много аргументов"
else
    source config.cfg
    export L_f=$column1_background
    export L_t=$column1_font_color
    export R_f=$column2_background
    export R_t=$column2_font_color

    if [[ $L_f == "" ]]
    then
    column1_background="default"
    L_f=6 
    fi

    if [[ $L_t == "" ]]
    then
    column1_font_color="default"
    L_t=1
    fi

    if [[ $R_f == "" ]]
    then
    column2_background="default"
    R_f=2
    fi

    if [[ $R_t == "" ]]
    then
    column2_font_color="default"
    R_t=4
    fi

    re='(^[1-6]$)'
    if ! [[ $L_f =~ $re ]] && [[ $L_t =~ $re ]] && [[ $R_f =~ $re ]] && [[ $R_t =~ $re ]]
    then
        echo "нужно использовать цифры от 1 до 6"
    else
        if [[ $L_t -eq $L_f || $R_f -eq $R_t ]]
        then
            echo "Почти все, значения 1 и 2 позиции не должны совпадать, тоже замое с 3 и 4"
        else
        
            end='\033[0m'
            case $L_f in
                    "1") p1='\033[107m'; L_f_wr='white';;
                    "2") p1='\033[41m'; L_f_wr='red';;
                    "3") p1='\033[42m'; L_f_wr='green';;
                    "4") p1='\033[46m'; L_f_wr='blue';;
                    "5") p1='\033[45m'; L_f_wr='purple';;
                    "6") p1='\033[40m'; L_f_wr='black';;
                    
            esac

            case $L_t in
                    "1") p2='\033[97m'; L_t_wr='white';;
                    "2") p2='\033[31m'; L_t_wr='red';;
                    "3") p2='\033[32m'; L_t_wr='green';;
                    "4") p2='\033[36m'; L_t_wr='blue';;
                    "5") p2='\033[35m'; L_t_wr='purple';;
                    "6") p2='\033[30m'; L_t_wr='black';;
                     
            esac

            case $R_f in
                    "1") p3='\033[107m'; R_f_wr='white';;
                    "2") p3='\033[41m'; R_f_wr='red';;
                    "3") p3='\033[42m'; R_f_wr='green';;
                    "4") p3='\033[46m'; R_f_wr='blue';;
                    "5") p3='\033[45m'; R_f_wr='purple';;
                    "6") p3='\033[40m'; R_f_wr='black';;
                    
            esac

            case $R_t in
                    "1") p4='\033[97m'; R_t_wr='white';;
                    "2") p4='\033[31m'; R_t_wr='red';;
                    "3") p4='\033[32m'; R_t_wr='green';;
                    "4") p4='\033[36m'; R_t_wr='blue';;
                    "5") p4='\033[35m'; R_t_wr='purple';;
                    "6") p4='\033[30m'; R_t_wr='black';;
            esac
            
                echo -e $p1$p2 HOSTNAME$end = $p3$p4$HOSTNAME$end
                echo -e $p1$p2 TIMEZONE$end = $p3$p4$(cat /etc/timezone) $(date +%Z) $(date "+%z")$end
                echo -e $p1$p2 USER$end = $p3$p4$USER$end
                echo -e $p1$p2 OS$end = $p3$p4$(cat /etc/issue|awk '{print $1,$2,$3}')$end
                echo -e $p1$p2 DATE$end = $p3$p4$(date +"%d %b %Y %T")$end
                echo -e $p1$p2 UPTIME$end = $p3$p4$(uptime -p)$end
                echo -e $p1$p2 UPTIME_SEC$end = $p3$p4$(awk '{ print $1 }' /proc/uptime)$end
                echo -e $p1$p2 IP$end = $p3$p4$(hostname -I)$end
                echo -e $p1$p2 MASK$end = $p3$p4$(ifconfig | grep -m1 netmask | awk '{ print $4 }')$end
                echo -e $p1$p2 GATEWAY$end = $p3$p4$(ip rout show | grep default | awk '{ print $3 }')$end
                echo -e $p1$p2 RAM_TOTAL$end = $p3$p4$(free -t -m | grep Total: | awk '{ printf "%.3f GB", $2/1024}')$end
                echo -e $p1$p2 RAM_USED$end = $p3$p4$(free -t -m | grep Total: | awk '{ printf "%.3f GB", $3/1024}')$end
                echo -e $p1$p2 RAM_FREE$end = $p3$p4$(free -t -m | grep Total: | awk '{ printf "%.3f GB", $4/1024}')$end
                echo -e $p1$p2 SPACE_ROOT$end = $p3$p4$(df -hk | grep "\/$" | awk '{printf "%.2f\n MB", $2/1024}')$end
                echo -e $p1$p2 SPACE_ROOT_USED$end = $p3$p4$(df -hk | grep "\/$" | awk '{printf "%.2f\n MB", $3/1024}')$end
                echo -e $p1$p2 SPACE_ROOT_FREE$end = $p3$p4$(df -hk | grep "\/$" | awk '{printf "%.2f\n MB", $4/1024}')$end
                echo ""
                echo "Column 1 background = $column1_background ($L_f_wr)"
                echo "Column 1 font color = $column1_font_color ($L_t_wr)"
                echo "Column 2 background = $column2_background ($R_f_wr)"
                echo "Column 2 font color = $column2_font_color ($R_t_wr)"
            fi
        fi
    fi
