#!/bin/sh
if ! [ -f ./src/boa ]; then
    echo Please compile the code.
    exit 1;
fi
mkdir /etc/boa /var/log/boa /var/www /usr/lib/cgi-bin /usr/lib/boa
cp ./src/boa /usr/bin
cp ./src/boa_indexer /usr/lib/boa
cp ./boa.conf /etc/boa

if ! [ -f /etc/mime.types ]; then
    cp ./mime.types /etc
fi

if [ -d /lib/systemd/system ]; then
    cp ./boa.service /lib/systemd/system
    systemctl daemon-reload

    echo If you want boa to start automatically, use
    echo 
    echo     systemctl enable boa
    echo
fi
