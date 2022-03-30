#This a wrapper script to be configured in a cron job

# Generating yestersday date as cron will run on current date and API request will be subitted a day before
#Reading the request id save from the response of the submit request from a file
. latest.txt

basedir=/home/dashboardscript
now=`date '+%Y-%m-%d'`
logfile=/home/dashboardscript/log/log-$now.log
echo "Igot script started................" >>$logfile
yesterday=`date -d "yesterday" '+%Y-%m-%d'`
echo yesterday date is $yesterday  >>$logfile
echo requestId for course progress to be read is for the date  $yesterday  >>$logfile
#read req_$yesterday < courseprogressrequests.txt
echo requestId for course progress read from file  is $latestreqid  >>$logfile
echo requestIddate for course progress read from file  is $latestreqdate  >>$logfile

#requestId=`echo $requestId | cut -f2 -d"="`
#echo requestId after splitting  is $requestId  >>./log/$logfile


## if request Id is balnk then we will not run frther

if [ ! -z $latestreqid ] && [ $yesterday == $latestreqdate ]
then
	echo Request Id recieved from the response file ....... >>$logfile
else
	echo No request id generated. We will not execute futher >>$logfile
fi
