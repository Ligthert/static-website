# Lazy man's self-signed certificate
`openssl req -subj "/CN=domain.com/O=My Company Name LTD./C=US" -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout server.key -out server.crt -sha256`

# Check if everything matches up
    $ openssl rsa -in wildcard.domain.key -noout -modulus | openssl md5
    $ openssl x509 -in wildcard.domain.com.crt -noout -modulus | openssl md5
    $ openssl req -in wildcard.domain.com.csr -noout -modulus | openssl md5
