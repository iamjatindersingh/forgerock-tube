#!/bin/bash

echo "Creating Private Key for Access Manager"

openssl genrsa -out identity-sqoopdata-local.key 2048

echo "Creating CSR for Access Manager"

openssl req -new -key identity-sqoopdata-local.key -config access-manager.cnf -out identity-sqoopdata-local.csr

echo "Create Certificate for Access Manager"

openssl x509 -req -in identity-sqoopdata-local.csr -CA ../root-ca/sqoopdata-root-ca.pem -CAkey ../root-ca/sqoopdata-ca.key -CAcreateserial -out identity-sqoopdata-local.crt -days 700 -sha256 -extfile access-manager.ext

echo "Package into PKCS12 Store"

openssl pkcs12 -export -in identity-sqoopdata-local.crt -inkey identity-sqoopdata-local.key -out identity-sqoopdata-local.p12 -name identity.sqoopdata.local -password pass:changeit

