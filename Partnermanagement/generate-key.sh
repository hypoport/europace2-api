openssl genrsa 2048 > rsa.private
openssl pkcs8 -topk8 -inform PEM -outform PEM -in rsa.private  -nocrypt > private-key.pem
openssl rsa -inform PEM -in rsa.private -pubout > public-key.pem
rm rsa.private