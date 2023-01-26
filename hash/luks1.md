# LUKS1

1.       Create LUKS1 encrypted container on a Linux machine using the following commands:

###### Create an image container
```
dd if=/dev/zero of=encrypted.img bs=1 count=0 seek=1G
```

###### Encrypt the image container and fill a LUKS key-slot with a password
```
sudo cryptsetup luksFormat encrypted.img 
```

###### Verify LUKS version (1) and supported encryption/hash types
```
sudo cryptsetup luksDump encrypted.img
```

###### Note: 
The following hashes/ciphers/modes/key-sizes are supported as of 26JAN2023

##### Hashes:  
-   PBKDF2-HMAC-SHA1  
-   PBKDF2-HMAC-SHA256  
-   PBKDF2-HMAC-SHA512  
-   PBKDF2-HMAC-RipeMD160  

##### Ciphers:  
-   AES  
-   Serpent  
-   Twofish  

##### Modes:  
-   CBC-Plain   
-   CBC-Plain64  
-   CBC-ESSIV  
-   XTS-Plain  
-   XTS-Plain64  

##### Key-sizes:  
-   128  
-   256 
-   512