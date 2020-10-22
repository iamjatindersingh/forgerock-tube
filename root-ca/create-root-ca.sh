#!/bin/bash

echo "Creating Internal ROOT CA Private Key"

openssl genrsa -des3 -out sqoopdata-ca.key 2048

echo "Creating Internal ROOT CA Public Key"

openssl req -x509 -new -nodes -key sqoopdata-ca.key -sha256 -days 1825 -out sqoopdata-root-ca.pem
