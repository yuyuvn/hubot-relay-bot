let retrys=0
while : ; do
    STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" https://${WEBSITE_SITE_NAME}.azurewebsites.net)
    echo $STATUSCODE
    [[ $retrys -ne 5 ]] || break
    echo $retrys
    ((retrys++))
    [[ $STATUSCODE -ne 200 ]] || break
done
