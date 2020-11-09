#!/bin/bash
CHECK_CMD="docker exec vnstatd vnstat"
INPUT_CMD="docker exec -it vnstatd sh"
until
        echo "Please enter your choise:(1-5)"
        echo "1.check vnstat date"
        echo "2.check vnstat -q"
        echo "3.check vnstat hour"
        echo "4.check vnstat month"
        echo "5.check vnstat top/10day"
#        echo "6.enter the container"
        echo "0.exit menu"
        read input
        test $input = 7
        do
                case $input in
                1) -d;;
                2)CHECK_CMD -q;;
                3)CHECK_CMD vnstat -h;;
                4)CHECK_CMD vnstat -m;;
                5)CHECK_CMD vnstat -t;;
#                6)INPUT_CMD;;
                0)exit;;
                esac
                done
