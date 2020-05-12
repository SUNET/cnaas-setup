#!/bin/bash

if [ -z "$CNAASURL" ]
then
	echo "No CNAASURL env found, trying with https://localhost"
	export CNAASURL="https://localhost"
fi

echo -n "CNaaS JWT auth, enter your username: "
read USERNAME

TOKEN=`curl -sf ${CNAASURL}/api/v1.0/auth -X POST -u $USERNAME -p | jq -r .access_token`
if [ -z "$TOKEN" ] ; then
	echo "unable to log in"
else
	echo "export JWT_AUTH_TOKEN=$TOKEN"
	export JWT_AUTH_TOKEN=$TOKEN
fi

