let retrys=0
while : ; do
    STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" https://${WEBSITE_SITE_NAME}.azurewebsites.net)
    sleep 30
done
