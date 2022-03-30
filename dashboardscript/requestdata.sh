courseProgress=`curl --location --request POST 'https://diksha.gov.in/api/dataset/v1/request/submit' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--header 'X-Channel-Id: 0129894906672087041553' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJOUHNSQjN5VXlIVUJuSWpsZkRPZzQ4T0EzU3N1YThkZCJ9.5fP8lXHNnb1ZG1SkPsPlPs748lVXiQNlk_RmrfmmLGQ' \
--data-raw '{
    "request": {
        "tag": "0129894906672087041553",
        "dataset": "progress-exhaust",
        "datasetConfig": {
            "searchFilter": {
                "request": {
                    "filters": {
                        "contentType": "Course",
                        "channel": "0129894906672087041553"
                    }
                }
            }
        }
    }
}'`

basedir=/home/dashboardscript
now=`date '+%Y-%m-%d'`
logfile=/home/dashboardscript/log/log-$now.log

echo "-------------------------Generating request ID for course exhaust--------------------------" >>$logfile


echo out put is ---------------------------------- $courseProgress >>$logfile

requestId=$(echo $courseProgress | jq -r '.result.requestId')
echo requet Id for course progress is $requestId >>$logfile

now=`date +"%Y-%m-%d"`=$requestId
echo $now >>$logfile
echo $now>>courseprogressrequests.txt

rm -f $basedir/latest.txt
echo latestreqid=$requestId >> latest.txt
echo latestreqdate=`date +"%Y-%m-%d"`>> latest.txt 

echo "-----------------------------------Finished with Generating request id for course exhaust-------------------------------">>$logfile

