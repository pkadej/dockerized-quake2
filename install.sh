#!/bin/bash
DEFAULT_PORT=27910
DEFAULT_DIR=/opt/q2pro
read -p "Installation dir: [$DEFAULT_DIR]: " INSTALLDIR
read -p "Enter server port [$DEFAULT_PORT]: " PORT
PORT="${PORT:-$DEFAULT_PORT}"
INSTALLDIR="${INSTALLDIR:-$DEFAULT_DIR}"

echo Installation dir: $INSTALLDIR
echo Server port: $PORT

if [ -d "$INSTALLDIR/$PORT" ]; then
    echo $INSTALLDIR/$PORT already exist
    exit 1;
fi

sudo mkdir -p $INSTALLDIR/$PORT 
sudo chown 7878:7878 -R $INSTALLDIR
docker run -d -v $INSTALLDIR/$PORT:/home/quake2/.q2pro --name q2pro-$PORT -it -p $PORT:27910/udp quake2/dockerized
