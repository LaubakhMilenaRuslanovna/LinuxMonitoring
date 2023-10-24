#!/bin/bash

#Обозначения цветов: (1 - white, 2 - red, 3 - green, 4 - blue, 5 – purple, 6 - black)
#Параметр 1 - это фон названий значений (HOSTNAME, TIMEZONE, USER и т.д.)
#Параметр 2 - это цвет шрифта названий значений (HOSTNAME, TIMEZONE, USER и т.д.)
#Параметр 3 - это фон значений (после знака '=')
#Параметр 4 - это цвет шрифта значений (после знака '=')

if ! [ $# -eq 4 ]
then
    echo "ожидаю 4 значения, перезапусти скрипт"
else
    var="^[1-6]$"
    if ! [[ $1 =~ $var && $2 =~ $var && $3 =~ $var && $4 =~ $var ]]
    then
        echo "нужно использовать цифры от 1 до 6, перезапусти скрипт"
    else
        if [[ $1 -eq $2 || $3 -eq $4 ]]
        then
            echo "Значения 1 и 2 позиции не должны совпадать, тоже замое с 3 и 4, перезапусти скрипт"
        else
                end='\033[0m'
                case $1 in
                    "1") p1='\033[107m';;
                    "2") p1='\033[41m';; 
                    "3") p1='\033[42m';;
                    "4") p1='\033[46m';;
                    "5") p1='\033[45m';;
                    "6") p1='\033[40m';;
                esac

                case $2 in
                    "1") p2='\033[97m';; 
                    "2") p2='\033[31m';; 
                    "3") p2='\033[32m';; 
                    "4") p2='\033[36m';; 
                    "5") p2='\033[35m';; 
                    "6") p2='\033[30m';;
                esac

                case $3 in
                    "1") p3='\033[107m';;
                    "2") p3='\033[41m';; 
                    "3") p3='\033[42m';;
                    "4") p3='\033[46m';;
                    "5") p3='\033[45m';;
                    "6") p3='\033[40m';;
                esac

                case $4 in
                    "1") p4='\033[97m';; 
                    "2") p4='\033[31m';; 
                    "3") p4='\033[32m';; 
                    "4") p4='\033[36m';; 
                    "5") p4='\033[35m';; 
                    "6") p4='\033[30m';;
                esac

        echo -e $p1$p2 HOSTNAME$end = $p3$p4$HOSTNAME$end
        echo -e $p1$p2 TIMEZONE$end = $p3$p4$(cat /etc/timezone) $(date +%Z) $(date "+%z")$end
        echo -e $p1$p2 USER$end = $p3$p4$(whoami)$end
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
            fi
        fi
    fi
