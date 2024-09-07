echo "Coverting source to metadata format"
sfdx force:source:convert -d deploy_code -r force-app

echo "Deploying code to org"
# sfdx force:mdapi:deploy -u DevHub -d deploy_code/ -w -1 -l RunLocalTests

echo "Run Specific Test Class to org"
sfdx force:mdapi:deploy -u DevHub -d deploy_code/ -w 33 --testlevel RunSpecifiedTests -r DemoLWCControllerTest,SampleControllerTest -w 33 --verbose --loglevel fatal --outputdir /tmp/artifacts

#sfdx force:apex:test:run -n DemoLWCControllerTest,SampleControllerTest  --testlevel RunSpecifiedTests --outputdir /tmp/artifacts --resultformat tap --targetusername DevHub