# WPA2 Handshake Files

1.       Set up a target WiFi access point with the desired password and security types (for this iteration I chose WPA2 PSK).

2.       From a Raspberry Pi 4 B, with an Alfa AWUS036ACM USB WiFi card, running Raspbian Buster, and Aircrack suite installed; run the following commands:

###### Identify your SSID and associated BSSID
```
sudo airodump-ng wlan1 –band abg
```

###### Stop the scan and copy the BSSID associated with your MAC address
```
CTRL+C
```

###### Paste your BSSID into the following command and lock your channel to the target
```
sudo airodump-ng wlan1 -c [your channel number here] –bssid [your BSSID here] -w [name your capture file]
```


3.       Connect a wireless device to your target SSID and check your CLI for the term “WPA Handshake Captured”.

###### Stop the scan
```
CTRL+C
```

4.       The capture file will be saved in the current working directory, unless specified elsewhere, this file can be fed into Hashcat’s conversion tool to convert it to an hccwpax and cracked with ‘22000 – WPA-PBKDF2-PMKID+EAPOL’ flag.

# NTLM

1.       Create local user account/s on Windows 10 machine without associating to a Microsoft (cloud) Account.

2.       Log in to each account you want grab hashes from and lock their session (you can have multiple locked sessions at the same time to capture all NTLM hasses at once).

3.       Download the following tool from GitHub (Disable Windows Defender first).

	a.       [https://github.com/ParrotSec/mimikatz](https://github.com/ParrotSec/mimikatz)

4.       Unzip and run mimikatz.exe from the folder corresponding to your system’s architecture (x86 or x64).

5.       In mimikatz, run the following commands:

###### Set current user permission level to Local Administrator
```
privilege::debug
```


###### Scrape hashes and user information from LSASS
```
sekurlsa::logonpasswords
```

6.       Copy the NTLM hashes for the desired users and paste them into a text file with one NTLM hash per line. This text file can be fed directly into Hashcat using the ‘1000 – NTLM’ or ‘5600 – NetNTLMv2’ flags.

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
