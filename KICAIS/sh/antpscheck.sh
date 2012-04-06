#!/bin/sh
while true; do
        ISRUNNING=`ps -ef | grep /work/bass/tomcat | grep java | wc -l`
        if [ $ISRUNNING = "1" ]; then
                echo "Tomcat Server is running"
        else
                echo "Tomcat Server was stoped"
                exit
        fi
        sleep 2
done