#!/bin/bash

echo "Create Private Key for Config DS"

openssl genrsa -out configds-sqoopdata-local.key 2048

echo "Create CSR for Config DS"

openssl req -new -key configds-sqoopdata-local.key -config configds.cnf -out configds-sqoopdata-local.csr

echo "Create Certificate for Config DS"

openssl x509 -req -in configds-sqoopdata-local.csr -CA ../root-ca/sqoopdata-root-ca.pem -CAkey ../root-ca/sqoopdata-ca.key -CAcreateserial -out configds-sqoopdata-local.crt -days 1825 -sha256 -extfile configds.ext

echo "Package into PKCS12 Store"

openssl pkcs12 -export -in configds-sqoopdata-local.crt -inkey configds-sqoopdata-local.key -out configds-sqoopdata-local.p12 -name configds.sqoopdata.local -password pass:changeit
