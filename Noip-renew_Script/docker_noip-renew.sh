#!/usr/bin/expect
set username ""
set passwd ""
set timeout 10
spawn docker run --rm -it simaofsilva/noip-renewer
expect "Email:"
send "$username\n"
expect "*assword:"
send "$passwd\n"
interact
