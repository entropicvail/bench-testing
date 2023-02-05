### Overview:
Each tier for testing is defined below, including: the password used for all hashes in the respective tier; bits of entropy per password; hashes or required files for cracking; commands for Hashcat, John the Ripper enhanced with BitCracker, or basic brute force script.

<hr style="border:2px solid gray">

### Tier 1

___
PW (7bits): 
	```12345678```
___
#### **WPA2** ![[ASUS_Test-12345678-01.hcwpax]]
**Hashcat commands:**
```
hashcat -m 22000 hash/ASUS_Test-12345678-01.hcwpax knownpass.txt
```

___
#### **NTLM** ```259745CB123A52AA2E693AAACCA2DB52```

**Hashcat commands:**
```
hashcat -m 1000 259745CB123A52AA2E693AAACCA2DB52 knownpass.txt
```

___
#### **Bitlocker** ![[BLT1_hash_recv_pass.txt]]
#### ![[BLT1_hash_user_pass.txt]]

**John the Ripper commands:**
```
john --format=bitlocker --wordlist=knownpass.txt hash/BLT1_hash_user_pass.txt
```

___
#### **LUKS1** ![[tier1-l1header.luks]]
**Hashcat commands:**
```
hashcat -m 14600 hash/tier1-l1header.luks knownpass.txt
```

___
#### **LUKS2** ![[tier1.l2header.luks]]
**Terminal commands:**
```
sudo ./bruteforce-luks-static-linux-amd64 -f knownpass.txt tier1-l2.img
```

<hr style="border:2px solid gray">

### Tier 2

___
PW(38bits): 
```nf93jfg7```
___
#### **WPA2** ![[ASUS_Test-nf93jfg7-01.hcwpax]]
**Hashcat commands:**
```
hashcat -m 22000 hash/ASUS_Test-nf93jfg7-01.hcwpax knownpass.txt
```

___
#### **NTLM** ```A9C6A0F3B575A9AD1DC3C5CEDDDF0D24```

**Hashcat commands:**
```
hashcat -m 1000 A9C6A0F3B575A9AD1DC3C5CEDDDF0D24 knownpass.txt
```

___
#### **Bitlocker** ![[BLT2_hash_recv_pass.txt]]
#### ![[BLT2_hash_user_pass.txt]]

**John the Ripper commands:**
```
john --format=bitlocker --wordlist=knownpass.txt hash/BLT2_hash_user_pass.txt
```

___

#### **LUKS1**
![[tier2-l1header.luks]]
**Hashcat commands:**
```
hashcat -m 14600 hash/tier2-l1header.luks knownpass.txt
```

___
#### **LUKS2** ![[tier2-l2header.luks]]

**Terminal commands:**
```
sudo ./bruteforce-luks-static-linux-amd64 -f knownpass.txt tier2-l2.img
```

<hr style="border:2px solid gray">

### Tier 3

PW (50bits): 
```k$9TW7o2```
___
#### **WPA2** ![[ASUS_Test-complex-01.hcwpax]]
**Hashcat commands:**
```
hashcat -m 22000 hash/ASUS_Test-complex-01.hcwpax knownpass.txt
```

___
#### **NTLM** ```EA3B371109A949249CE6EFD7E4BA1284```

**Hashcat commands:**
```
hashcat -m 1000 EA3B371109A949249CE6EFD7E4BA1284 knownpass.txt
```

___
#### **Bitlocker** ![[BLT3_hash_recv_pass.txt]]
#### ![[BLT3_hash_user_pass.txt]]

**John the Ripper commands:**
```
john --format=bitlocker --wordlist=knownpass.txt hash/BLT3_hash_user_pass.txt
```

___
#### **LUKS1** ![[tier3-l1header.luks]]
**Hashcat commands:**
```
hashcat -m 14600 hash/tier3-l1header.luks knownpass.txt
```

___
#### **LUKS2** ![[tier3-l2header.luks]]
Terminal commands:**
```
sudo ./bruteforce-luks-static-linux-amd64 -f knownpass.txt tier3-l2.img
```

<hr style="border:2px solid gray">

### Tier 4

PW (102bits): 
```gsg#@Rfhu3rbu@#u323F```
___
#### **WPA2** ``` ```
**Hashcat commands:**
```
hashcat -m 22000 hash/[CAP_FILE_HERE] knownpass.txt
```

___
#### **NTLM** ```730ECF823B0B6997A7A2AE21DE6E4D10```

**Hashcat commands:**
```
hashcat -m 1000 730ECF823B0B6997A7A2AE21DE6E4D10 knownpass.txt
```

___
#### **Bitlocker** ![[BLT4_hash_recv_pass.txt]]
#### ![[BLT4_hash_user_pass.txt]]
**John the Ripper commands:**
```
john --format=bitlocker --wordlist=knownpass.txt hash/BLT4_hash_user_pass.txt
```

___
#### **LUKS1** ![[tier4-l1header.luks]]
**Hashcat commands:**
```
hashcat -m 14600 hash/tier4-l1header.luks knownpass.txt
```

___
#### **LUKS2** ![[tier4-l2header.luks]]
**Terminal commands:**
```
sudo ./bruteforce-luks-static-linux-amd64 -f knownpass.txt tier4-l2.img
```

<hr style="border:2px solid gray">
### Build Notes

- Bitlocker Configuration - Requires BitCracker because HC only supports $bitlocker$1
	- 1G VHD, initialized and with a ~1G NTFS partition
		- Encrypt entire drive
		- Compatible mode 
	- User Pass using $bitlocker$0
	- Recovery Pass using $bitlocker$2
- Veracrypt: removing Veracrypt from the scope; there will not be sufficient time to test against these hashes and they are a lower priority than the rest of the hashes available.
- https://github.com/Diverto/cryptsetup-pwguess/releases