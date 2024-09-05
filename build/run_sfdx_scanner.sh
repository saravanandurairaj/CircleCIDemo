echo "Installing JDK"
#sudo apt-get install openjdk-8-jdk

echo "Install SFDX Scanner"
#echo -e 'y/n' | sfdx plugins:install @salesforce/sfdx-scanner@latest

npm cache clean --force
npm install -g yarn

##echo "Running SFDX Scanner"
npx sfdx scanner:run --target "**/default/**" --format "csv" --outfile "sfdxScannerAnalysis.csv" --violations-cause-error