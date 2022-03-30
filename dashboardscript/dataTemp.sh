#!/bin/bash
for var in "$@"
do
  response=$(curl -s --location --request GET 'https://diksha.gov.in/api/dataset/v1/request/read/batchtb?requestId='$var'' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJOUHNSQjN5VXlIVUJuSWpsZkRPZzQ4T0EzU3N1YThkZCJ9.5fP8lXHNnb1ZG1SkPsPlPs748lVXiQNlk_RmrfmmLGQ' \
  --header 'X-Channel-Id: 0129894906672087041553')
declare -a urls=($(echo $response|jq -r '.result.downloadUrls|@sh'| tr -d \'))
  echo url -------$urls
  arraylength=${#urls[@]}
  echo $arraylength downloadable urls are fetched from the API
#Do the cleanup and back up if download url is not empty
  if [ $arraylength -gt 0 ]
  then
    echo Removing files from download ---------------------------
    rm -rf ./download/*.zip
    rm -rf ./merge/*
  fi


#set -x
  for (( i=0; i<${arraylength}; i++ ));
  do
    echo "index: $i, value: ${urls[$i]}"
    curl -o ./download/$i.zip ${urls[$i]}
    unzip  -d ./download ./download/$i.zip
  done
done

 rm -rf ./download/*.zip
############
csvFiles=`ls ./download/*.csv|wc -l`
echo $csvFiles are present

 cp ./merge.csv ./merge/
 tail -q -n +2  ./download/*.csv >> ./merge/merge.csv
#fi

