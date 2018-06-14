# Run geth in docker using docker secrets for key and password

## Build the image
```
docker build -t __imagename__ .
```

## Generate a keyfile using an existing geth
The keyfile will be stored in __datadir__ 
```
geth --datadir __datadir__ account new
```

## Add the key to the docker secrets store
The keyfile is generated in the preveous step
```
secret create geth_key __path_to_keyfile__
```

## Add the key password to the docker secrets store
Enter the password after entering the command and press enter and the CTRL+C
```
secret create geth_key_pswd -
```

## Run the container as a service
The __public key__ is in the keyfile. It is also part of the filename of the keyfile.
```
service create --name geth --secret geth_key_pswd --secret source=geth_key,target=/keystore/geth_key -p 8546:8546 -e pubkey='__pubkey__' __imagename__
```


