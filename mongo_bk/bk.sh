#!/bin/bash

DB="instance_db"

COLS=("article" "user" "source" "status" "user_action" "user_relation" "feedback")

DT=`date '+%Y%m%d%H%M'`

BKDIR="bk_${DT}"

mkdir $BKDIR

for COL in ${COLS[*]}
do
    fname="./$BKDIR/${DB}.${COL}.json"
    echo "Export ==> ${fname}"
    (mongoexport -d $DB -c $COL -o $fname) >/dev/null 2>&1
done

tar -cvf "${BKDIR}.tar" $BKDIR >/dev/null 2>&1

UU="http://v0.api.upyun.com/safekk/db_back_test/${BKDIR}.tar"

LANG=en_US.UTF-8 

PD=`date -u '+%a, %d %b %Y %T GMT'`
URI="/safekk/db_back_test/${BKDIR}.tar"
FMD=`md5sum ${BKDIR}.tar|cut -d ' ' -f1`

ST="PUT&${URI}&${PD}&${FMD}"

SIGN=`echo -n $ST | openssl sha1 -hmac $UPYP -binary | base64`

curl -X PUT --progress-bar -T "${BKDIR}.tar" $UU \
         -H "Authorization: UPYUN $UPYU:${SIGN}" \
         -H "Date: ${PD}"\
         -H "Content-MD5: $FMD" \
         -H "Content-Secret: $UPYS" \
         --progress-bar | test

