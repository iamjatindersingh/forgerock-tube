# Introduction

In this branch, we discuss and go over the procedure on how to set up an Internal ROOT CA to sign various certificates required and used across different examples on my YouTube Channel @ [IAM jaTinder Singh](https://www.youtube.com/channel/UCncKTrfBUAlPjk0oKQ66rRg/). Using an Internal ROOT CA for these examples instead of individual self-signed certificates allows us to better establish and manage trust, and avoid browser warnings. If we didn’t use this approach, we would have to add those self-signed certificates individually to every trust store in our architecture.

## Quick Set-Up

To avoid having to run individual commands, follow the below steps to quickly set-up certificates.

* Run `./create-root-ca.sh` under `root-ca` to create Internal Root CA.

* Run `./create-am-pkcs12-store.sh` under `am` to create AM certificate.

* Run `./create-userds-pkcs12-store.sh` under `userds` to create User DS certificate.

* Run `./create-configds-pkcs12-store.sh` under `configds` to create Config DS certificate.


**Note**: Password is `changeit` for ROOT CA Private Key.

## Internal ROOT CA

Using the below steps to create Internal ROOT CA keys:

* Create Private Key

`openssl genrsa -des3 -out sqoopdata-ca.key 2048`

* Create Public Key

`openssl req -x509 -new -nodes -key sqoopdata-ca.key -sha256 -days 1825 -out sqoopdata-root-ca.pem`

## Access Manager Certificate

Follow the below steps to create and sign the Access Manager Certificate using the above Internal ROOT CA:

* Create Private Key for Access Manager

`openssl genrsa -out identity-sqoopdata-local.key 2048`

* Create CSR for Access Manager

`openssl req -new -key identity-sqoopdata-local.key -config access-manager.cnf -out identity-sqoopdata-local.csr`

* Create Certificate for Access Manager

`openssl x509 -req -in identity-sqoopdata-local.csr -CA ../root-ca/sqoopdata-root-ca.pem -CAkey ../root-ca/sqoopdata-ca.key -CAcreateserial -out identity-sqoopdata-local.crt -days 700 -sha256 -extfile access-manager.ext`

* Package into PKCS12 Store

`openssl pkcs12 -export -in identity-sqoopdata-local.crt -inkey identity-sqoopdata-local.key -out identity-sqoopdata-local.p12 -name identity.sqoopdata.local -password pass:changeit`

## User DS Certificate

Follow the below steps to create and sign the User DS Certificate using the above Internal ROOT CA:

* Create Private Key for User DS

`openssl genrsa -out userds-sqoopdata-local.key 2048`

* Create CSR for User DS

`openssl req -new -key userds-sqoopdata-local.key -config userds.cnf -out userds-sqoopdata-local.csr`

* Create Certificate for User DS

`openssl x509 -req -in userds-sqoopdata-local.csr -CA ../root-ca/sqoopdata-root-ca.pem -CAkey ../root-ca/sqoopdata-ca.key -CAcreateserial -out userds-sqoopdata-local.crt -days 1825 -sha256 -extfile userds.ext`

* Package into PKCS12 Store

`openssl pkcs12 -export -in userds-sqoopdata-local.crt -inkey userds-sqoopdata-local.key -out userds-sqoopdata-local.p12 -name userds.sqoopdata.local -password pass:changeit`

## Config DS Certificate

Follow the below steps to create and sign the Config DS Certificate using the above Internal ROOT CA:

* Create Private Key for Config DS

`openssl genrsa -out configds-sqoopdata-local.key 2048`

* Create CSR for Config DS

`openssl req -new -key configds-sqoopdata-local.key -config configds.cnf -out configds-sqoopdata-local.csr`

* Create Certificate for Config DS

`openssl x509 -req -in configds-sqoopdata-local.csr -CA ../root-ca/sqoopdata-root-ca.pem -CAkey ../root-ca/sqoopdata-ca.key -CAcreateserial -out configds-sqoopdata-local.crt -days 1825 -sha256 -extfile configds.ext`

* Package into PKCS12 Store

`openssl pkcs12 -export -in configds-sqoopdata-local.crt -inkey configds-sqoopdata-local.key -out configds-sqoopdata-local.p12 -name configds.sqoopdata.local -password pass:changeit`


# Questions

For any questions, feedback or help, you can reach me at jsingh@sqoopdata.com. 

# Disclaimer

The source-code and configuration in this repository is in no way intended for direct production environment, and is provided for the sole purpose to demonstrate and teach various features available within ForgeRock Identity Platform.
