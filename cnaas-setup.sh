#!/bin/bash

if [ -z "$JWT_AUTH_TOKEN" ] ; then
	echo "You need a JWT token to run this script, try running: . jwtauth.sh"
	exit 1
fi

if [ -z "$CNAASURL" ] ; then
	echo "No CNAASURL env found, trying with https://localhost"
	export CNAASURL="https://localhost"
fi

if ! [ -x "$(command -v curl)" ] ; then
	echo "You must have curl installed to run this script"
	exit 2
fi

if ! [ -x "$(command -v jq)" ] ; then
	echo "You must have jq installed to run this script"
	exit 2
fi

APIVER=`curl -sf ${CNAASURL}/api/v1.0/system/version | jq -r .data.version`
if [ -z "$APIVER" ] ; then
	echo "Unable to get data from NMS API"
	exit 3
else
	echo "Connected to NMS API version: $APIVER"
fi

