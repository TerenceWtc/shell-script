#!/bin/bash

DIR=`pwd`

# lookup the tar file from the same directory
TAR_FILE=$(ls -l $DIR | awk '/^-.*tar.gz$/ {print $NF}')

# you can also replace the tar file manually
#TAR_FILE=jdk-8u144linux-x64.tar.gz

# unzip tar file if exist
if [ -f "$TAR_FILE" ]; then
	echo 'found tar file!'
	sleep 1
	echo 'unzipping...'
	tar -zxvf $TAR_FILE
	echo 'unzipped!'
	echo 'removing tar file...'
	rm -rf $TAR_FILE
	echo 'removed!'
else
	echo 'tar file not found!'
fi

# write jdk path into ~/.bashrc file
JDK_FOLDER=$(ls -l $DIR | awk '/^d.*jdk*/ {print $NF}')
if [ -d "$JDK_FOLDER" ]; then
	echo 'found jdk folder!'
	echo 'writing jdk configuration into system file...'
  # here document
	(
		cat <<EOF
# jdk configuration
JAVA_HOME=$DIR/$JDK_FOLDER
JRE_HOME=$DIR/$JDK_FOLDER/jre
CLASS_PATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar:\$JRE_HOME/lib
PATH=\$PATH:\$JAVA_HOME/bin:\$JRE_HOME/bin
export JAVA_HOME JRE_HOME CLASS_PATH PATH
EOF
) >> ~/.bashrc 
	echo 'wrote!'
	source ~/.bashrc
	java -version
else
	echo 'jdk folder not found!'
fi
