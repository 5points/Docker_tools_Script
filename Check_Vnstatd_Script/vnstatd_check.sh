#!/bin/bash
until
        echo "Please enter your choise:(1-5)"
        echo "1.check vnstat date"
        echo "2.check vnstat -q"
        echo "3.check vnstat hour"
        echo "4.check vnstat month"
        echo "5.check vnstat top/10day"
        echo "0.exit menu"
        read input
        test $input = 6
        do
                case $input in
                1)docker exec vnstatd vnstat -d;;
                2)docker exec vnstatd vnstat -q;;
                3)docker exec vnstatd vnstat -h;;
                4)docker exec vnstatd vnstat -m;;
                5)docker exec vnstatd vnstat -t;;
                0)exit;;
                esac
                done
