#!/bin/sh

if ! test -z "$1"
then
    HOST="$1"
else
    HOST="localhost"
fi

if [ $# -ge 2 ] ; then
    if ! test -z "$2"
    then
        BASEPORT="$2"
    else
        BASEPORT="80"
    fi
fi

ENABLER_NAME="TAL SE"

echo "Entering $ENABLER_NAME smoke test sequence. $ENABLER_NAME validation procedure engaged. Target host: $HOST, port: $BASEPORT"


REQUEST_URL=/
echo "Run smoke test for $REQUEST_URL"

# During the first test we will tollerate some retries because the server
# may not be immediately available.
n=0
retry=1
until [ $n -ge 8 ]
do
    ITEM_RESULT=`curl -s --connect-timeout 5 -o /dev/null -w "%{http_code}" http://"$HOST:$BASEPORT$REQUEST_URL"`
    if [ "$ITEM_RESULT" -eq "200" ]; then
	break
    fi
    n=$(($n+1))
    sleep $retry
    retry=$(($retry*2))
done
if [ "$ITEM_RESULT" -ne "200" ]; then
        echo "Curl command for $REQUEST_URL failed. Validation procedure terminated."
        echo "Debug information: HTTP code $ITEM_RESULT instead of expected 200 from $HOST:$BASEPORT"
        exit 1;
else
        echo "Curl command for $REQUEST_URL OK."
fi

echo "Smoke test completed. $ENABLER_NAME validation procedure succeeded. Over."
