#!/bin/bash

# jdk
export JAVA_HOME=/home/centos/jdk/jdk1.8.0_181

# path
export PATH=$JAVA_HOME/bin:$PATH

DATE=$(date +%Y-%m-%d:%H-%M-%S)
#start java
echo "start shell...."
APPDIR=`pwd`
PIDFILE=$APPDIR/app.pid
if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE"); then
    echo "already running..."
    echo "stopping..."
    PID="$(cat "$PIDFILE")"
    kill -9 $PID
    rm "$PIDFILE"
    echo "stopped!"
fi
echo "starting..."
nohup java -jar $APPDIR/cts-admin-console.jar > ./logs/$DATE.log 2>&1 &
echo $! > $PIDFILE
echo "start success!"
echo "waiting to startup..."
