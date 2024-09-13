echo "Coverting source to metadata format"
sfdx force:source:convert -d deploy_code -r force-app

set SFDX_LOG_LEVEL=DEBUG
echo "Deploying code to org"
# sfdx force:mdapi:deploy -u DevHub -d deploy_code/ -w -1 -l RunLocalTests

echo "Run Specific Test Class to org"
sfdx force:mdapi:deploy -u DevHub -d deploy_code/ -w 33  -w 33 --verbose --loglevel DEBUG -r DemoLWCControllerTest,SampleControllerTest --testlevel RunSpecifiedTests > /tmp/artifacts/deployResult.txt

#sfdx force:apex:test:run -n DemoLWCControllerTest,SampleControllerTest  --testlevel RunSpecifiedTests --outputdir /tmp/artifacts --resultformat tap --targetusername DevHub