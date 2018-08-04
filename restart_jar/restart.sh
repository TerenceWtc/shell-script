#!/bin/bash

# replace your JAVA_HOME.
export JAVA_HOME=/home/centos/jdk/jdk1.8.0_181
export PATH=$JAVA_HOME/bin:$PATH

# replace your jar_file_name.
FILENAME=cts-admin-console

DATE=$(date +%Y-%m-%d:%H-%M-%S)

# start java...
echo "starting shell..."
APPDIR=`pwd`
PIDFILE=$APPDIR/app.pid
# if pid exsist, kill the process.
if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE"); then
    echo "already running..."
    echo "stopping..."
    PID="$(cat "$PIDFILE")"
    kill -9 $PID
    rm "$PIDFILE"
    echo "stopped!"
fi
echo "starting..."
# run at background and write the logs into file.
nohup java -jar $APPDIR/$FILENAME.jar > ./logs/$FILENAME/$DATE.log 2>&1 &
# write the process into file.
echo $! > $PIDFILE
echo "starting success!"
echo "waiting to startup..."
