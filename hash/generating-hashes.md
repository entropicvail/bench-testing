<hr style="border:2px solid gray">
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

<hr style="border:2px solid gray">
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

<hr style="border:2px solid gray">
# LUKS1

1.       Create LUKS1 encrypted container on a Linux machine using the following commands:

###### Create an image container
```
dd if=/dev/zero of=encrypted.img bs=1 count=0 seek=10M
```

###### Encrypt the image container and fill a LUKS key-slot with a password
```
sudo cryptsetup luksFormat encrypted.img --type=luks1
```

###### Decrypt LUKS1 image container
```
sudo cryptsetup luksOpen encrypted.img myEncryptedVolume
```

###### Format decrypted LUKS1 image container
```
sudo mkfs.ext4 /dev/mapper/myEncryptedVolume
```

###### Make directory to use as mount point
```
mkdir Private
```

###### Mount decrypted LUKS1 image container
```
sudo mount /dev/mapper/myEncryptedVolume $HOME/Private
```

###### Unmount decrypted LUKS1 image container
```
sudo umount $HOME/Private
```

###### Close LUKS1 encrypted image container
```
sudo cryptsetup luksClose myEncryptedVolume
```

###### Add password to Key Slot 1 in LUKS1 encrypted image
```
sudo cryptsetup luksAddKey $HOME/encrypted.img
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

2. Either run Hashcat directly against the encrypted container or snip the headers with the following commands:

###### Snip LUKS1 headers to create a 2MB file that is more portable to crack.
```
dd if=encrypted.img of=header.luks bs=512 count=4097
```

###### Run Hashcat against encrypted.img or header.luks using mode 14600

<hr style="border:2px solid gray">
# LUKS2

###### Note:
As of 26JAN2023, Hashcat does not support cracking LUKS2 default hashes (argon2i). A manual approach is required at a significant cost in the form of time.

###### Reference:
https://diverto.github.io/2019/11/18/Cracking-LUKS-passphrases

###### Test the LUKS2 password manually with the 'password test' function built into cryptsetup.
```
echo "test" | cryptsetup --test-passphrase open encrypted.img UNencrypted
```

###### Test the LUKS2 password with the 'password test' function calling against a dictionary.
```
cat wordlist.txt | xargs -t -P `nproc` -i echo {} | cryptsetup --verbose --test-passphrase open encrypted.img UNencrypted
```

###### Generate dictionary list with Hashcat.
```
hashcat -m 0 --stdout -a 3 ?a?a?a?a | xargs -t -P `nproc` -i echo {} | cryptsetup --test-passphrase open encrypted.img UNencrypted
```

<hr style="border:2px solid gray">
# Bitlocker

###### References:
https://github.com/e-ago/bitcracker

https://threadreaderapp.com/thread/1106528365513752576.html

https://ngolongtech.net/5-ways-to-unlock-bitlocker-encrypted-hard-drives-in-windows-10/#Step_2_Extract_the_hash

###### Create the image of your storage device encrypted with BitLocker using, as an example, the _dd_ command:
```
sudo dd if=/dev/disk2 of=/path/to/imageEncrypted.img conv=noerror,sync
```

Then you need to run the `bitcracker_hash` executable on your `imageEncrypted.img` in order to:

-   check if the image has a valid format and can be attacked by BitCracker
-   check if the the original storage device hash been encrypted with an User Password or a Recovery Password
-   extract the hash describing the image

If the execution completes correctly, `bitcracker_hash` produces 1 or 2 output files:

-   hash_user_pass.txt : if the device was encrypted with a User Password, this file contains the hash you need to start the User Password attack mode.
-   hash_recv_pass.txt : the hash you need to start the Recovery Password attack mode

**BDE encrypted volumes could have different formats for different authentication methods. If `bitcracker_hash` is not able to find the Recovery Password on your encrypted image, please open an issue or contact me**

