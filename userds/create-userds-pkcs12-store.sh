#!/bin/bash

echo "Create Private Key for User DS"

openssl genrsa -out userds-sqoopdata-local.key 2048

echo "Create CSR for User DS"

openssl req -new -key userds-sqoopdata-local.key -config userds.cnf -out userds-sqoopdata-local.csr

echo "Create Certificate for User DS"

openssl x509 -req -in userds-sqoopdata-local.csr -CA ../root-ca/sqoopdata-root-ca.pem -CAkey ../root-ca/sqoopdata-ca.key -CAcreateserial -out userds-sqoopdata-local.crt -days 1825 -sha256 -extfile userds.ext

echo "Package into PKCS12 Store"

openssl pkcs12 -export -in userds-sqoopdata-local.crt -inkey userds-sqoopdata-local.key -out userds-sqoopdata-local.p12 -name userds.sqoopdata.local -password pass:changeit
