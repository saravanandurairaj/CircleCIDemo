##"C:\Program Files\Git\usr\bin\openssl"

## Consumer Key     3MVG9eMnfmfDO5NDZEwCCcjcdkSvvcujYxznMyrcV4yAq1kvvMXa50GZQ1Xf5mv5a3yG82DstnMzObtAfrExj

## Login: saravanan.durairaj@crossmark.com.oh.sandev

echo "Generating certificates for use with CircleCI, press enter to continue"
read check1
openssl genrsa -des3 -passout pass:mypassword1 -out server.pass.key 2048 algorithm:RS256

openssl rsa -passin pass:mypassword1 -in server.pass.key -out server.key
rm server.pass.key
echo "We will now generate the server key, when promoted for a password, press enter"
echo "press enter to continue"
read check2
openssl req -new -key server.key -out server.csr
echo "we will now generate the certificates, press enter to continue"
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
echo "the key will now be encoded in BASE64 and displayed, use the output for the value of SFDC_SERVER_KEY enviornment variable"
echo "/n"
echo "press enter to continue"
read check4
#certutil -encode server.key encodedkey.txt
base64 server.key
echo "we will now clean up, keys will be deleted"
echo "press enter to continue"
read check4
rm server.csr
rm server.key
echo "certificate and key generateion complete, please add server.crt to your OAuth connected app in salesforce"
