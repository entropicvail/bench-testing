## Setup

### 1: Connect to testing environment
```
ssh USER@RHOST:PORT
```

### 2: Copy test files to testing environment (separate session)
```
scp -r LOCAL_PATH USER@RHOST:PORT/REMOTE_PATH
```

### 3: Configure John the Ripper
```
sudo nano PATH_TO_JTR/run/john.conf
```

### Add the following to the Incremental section
```
# Digits only - lim 9 length
[Incremental:Tier1BL]
File = $JOHN/digits.chr
MinLen = 1
MaxLen = 9
CharCount = 10

# Digits and lowercase only - lim 9 length
[Incremental:Tier2BL]
File = $JOHN/lowernum.chr
MinLen = 1
MaxLen = 9
CharCount = 36

# Digits, uppercase, lowercase, special char - lim 9 length
[Incremental:Tier3BL]
File = $JOHN/lm_ascii.chr
MinLen = 1
MaxLen = 9
CharCount = 69

# Digits, uppercase, lowercase, special char - lim 30 length
[Incremental:Tier4BL]
File = $JOHN/lm_ascii.chr
MinLen = 1
MaxLen = 21
CharCount = 69
```

### Save and Exit
```
CTRL+x
y
ENTER
```
___
## Testing Tier1

### 1: Tier1 WPA2 (digits only, min length=8, max length=pass+1)
```
hashcat -a 3 -m 22000 -i --increment-min=8 hash/ASUS_Test-12345678-01.hcwpax ?d?d?d?d?d?d?d?d?d
```

### 2: Tier1 NTLM (digits only, max length=pass+1)
```
hashcat -a 3 -m 1000 259745CB123A52AA2E693AAACCA2DB52 ?d?d?d?d?d?d?d?d?d
```

### 3: Tier1 Bitlocker (digits only, max length=pass+1)
```
john --format=bitlocker --incremental:Tier1BL hash/BLT1_hash_user_pass.txt
```

### 4: Tier1 LUKS1 (digits only, max length=pass+1)
```
hashcat -a 3 -m 14600 hash/tier1-l1header.luks ?d?d?d?d?d?d?d?d?d
```
___
## Testing Tier2

### 1: Tier2 WPA2 (digits and lowercase only, min length=8, max length=pass+1)
```
hashcat -a 3 -m 22000 -i --increment-min=8 hash/ASUS_Test-nf93jfg7-01.hcwpax ?ld?ld?ld?ld?ld?ld?ld?ld?ld
```

### 2: Tier2 NTLM (digits and lowercase only, max length=pass+1)
```
hashcat -a 3 -m 1000 A9C6A0F3B575A9AD1DC3C5CEDDDF0D24 ?ld?ld?ld?ld?ld?ld?ld?ld?ld
```

### 3: Tier2 Bitlocker (digits and lowercase only, max length=pass+1)
```
john --format=bitlocker --incremental:Tier2BL hash/BLT2_hash_user_pass.txt
```

### 4: Tier2 LUKS1 (digits and lowercase only, max length=pass+1)
```
hashcat -a 3 -m 14600 hash/tier2-l1header.luks ?ld?ld?ld?ld?ld?ld?ld?ld?ld
```
___
## Testing Tier3

### 1: Tier3 WPA2 (min length=8, max length=pass+1)
```
hashcat -a 3 -m 22000 -i --increment-min=8 hash/ASUS_Test-complex-01.hcwpax ?a?a?a?a?a?a?a?a?a
```

### 2: Tier3 NTLM (max length=pass+1)
```
hashcat -a 3 -m 1000 EA3B371109A949249CE6EFD7E4BA1284 ?a?a?a?a?a?a?a?a?a
```

### 3: Tier3 Bitlocker (max length=pass+1)
```
john --format=bitlocker --incremental:Tier3BL hash/BLT3_hash_user_pass.txt
```

### 4: Tier3 LUKS1 (max length=pass+1)
```
hashcat -a 3 -m 14600 hash/tier3-l1header.luks ?a?a?a?a?a?a?a?a?a
```
___
## Testing Tier4

### 1: Tier4 WPA2 (min length=8, max length=pass+1)
```
hashcat -a 3 -m 22000 -i --increment-min=8 hash/ASUS_Test-impossible-01.hcwpax ?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a
```

### 2: Tier4 NTLM (max length=pass+1)
```
hashcat -a 3 -m 1000 730ECF823B0B6997A7A2AE21DE6E4D10 ?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a
```

### 3: Tier4 Bitlocker (max length=pass+1)
```
john --format=bitlocker --incremental:Tier4BL hash/BLT4_hash_user_pass.txt
```

### 4: Tier4 LUKS1 (max length=pass+1)
```
hashcat -a 3 -m 14600 hash/tier4-l1header.luks ?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a
```