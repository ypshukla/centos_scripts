#!/bin/bash

export TIME=`date +%d-%m-%Y_%H.%M`
export STATUS_ACTIVE=`echo "[ ACTIVE ]"`
export STATUS_REFUSED=`echo "[ REFUSED ]"`
export STATUS_INACTIVE=`echo "[ INACTIVE ]"`
export RECIPIENTS="ypshukla55@gmail.com"

rm -rf `pwd`/log/Morning*.html

echo "<!DOCTYPE html>
	<html>
	<head>
   	<title>CONSOLIDATED_AGENT_DATA</title>
	<style>
        table, td, th {font-family: sans-serif; border: 1px solid #c0c0c0; text-align: left; padding: 5px; max-width: 100%;}
        th {background-color: #c0c0c0;}
	tr:nth-child(odd){background-color: #f2f2f2;}
	tr:hover {background-color: #ddd;}
        </style>" | tee -a `pwd`/log/Morning_Success_Log.html `pwd`/log/Morning_Refused_Log.html `pwd`/log/Morning_Failed_Log.html > /dev/null
echo 	"<body><h2>Morning_Success_Log</h2>" | tee -a `pwd`/log/Morning_Success_Log.html > /dev/null
echo	"<body><h2>Morning_Refused_Log</h2>" | tee -a `pwd`/log/Morning_Refused_Log.html > /dev/null
echo 	"<body><h2>Morning_Failed_Log</h2>" | tee -a `pwd`/log/Morning_Failed_Log.html > /dev/null
echo 	"<table>
        <col width="200"><col width="160"><col width="160"><col width="160">
        <tr><th>Date</th><th>Agent_IP</th><th>Port_No</th><th>Status</th></tr>" | tee -a `pwd`/log/Morning_Success_Log.html `pwd`/log/Morning_Refused_Log.html `pwd`/log/Morning_Failed_Log.html > /dev/null
echo	"127.0.0.1 23" | (while read HOST PORT; do
telnet $HOST $PORT </dev/null > `pwd`/log/telnet.out 2>&1 & sleep 1; kill $!;
if grep Connected `pwd`/log/telnet.out >/dev/null;
then
	echo "<tr><td>$TIME</td><td>$HOST</td><td>$PORT</td><td style="font-weight:bold">$STATUS_ACTIVE</td></tr>" | tee -a `pwd`/log/Morning_Success_Log.html >/dev/null;

elif grep refused `pwd`/log/telnet.out >/dev/null;
then
	echo "<tr><td>$TIME</td><td>$HOST</td><td>$PORT</td><td style="font-weight:bold">$STATUS_REFUSED</td></tr>" | tee -a `pwd`/log/Morning_Refused_Log.html >/dev/null;

else
	echo "<tr><td>$TIME</td><td>$HOST</td><td>$PORT</td><td style="font-weight:bold">$STATUS_INACTIVE</td></tr>" | tee -a `pwd`/log/Morning_Failed_Log.html >/dev/null;

fi;
done) 2>&1

echo "</table>
</body>
</head>
</html>" | tee -a `pwd`/log/Morning_Success_Log.html `pwd`/log/Morning_Refused_Log.html `pwd`/log/Morning_Failed_Log.html > /dev/null


FILE1=`pwd`/log/Morning_Success_Log.html
FILE2=`pwd`/log/Morning_Refused_Log.html
FILE3=`pwd`/log/Morning_Failed_Log.html


if [ "`grep -c ACTIVE log/Morning_Success_Log.html`" -gt 0 ];
then
	echo "$FILE1 File exists"
else
	echo "$FILE1 File doesn't exist"
	echo "<html><head><title>CONSOLIDATED_AGENT_DATA</title>
	<body><h2><font color="red">No Data Found</font></h2></body></head></html>" > `pwd`/log/Morning_Success_Log.html
fi;


if [ "`grep -c REFUSED log/Morning_Refused_Log.html`" -gt 0 ];
then
        echo "$FILE2 File exists"
else
        echo "$FILE2 File doesn't exist"
        echo "<html><head><title>CONSOLIDATED_AGENT_DATA</title>
	<body><h2><font color="red">No Data Found</font></h2></body></head></html>" > `pwd`/log/Morning_Refused_Log.html
fi;


if [ "`grep -c INACTIVE log/Morning_Failed_Log.html`" -gt 0 ];
then
        echo "$FILE3 File exists"
else
        echo "$FILE3 File doesn't exist"
        echo "<html><head><title>CONSOLIDATED_AGENT_DATA</title>
	<body><h2><font color="red">No Data Found</font></h2></body></head></html>" > `pwd`/log/Morning_Failed_Log.html
fi;

#(
#echo "Dear Team,"
#echo 
#echo "Pleae find the Morning Agent Status attached with this mail. Note, this email has been sent from an unattended mail box, do not reply to this mail."
#) | mail -a $(find `pwd`/log -type f -name "Morning*") -s "Morning_Agent_Status" "$RECIPIENTS"

