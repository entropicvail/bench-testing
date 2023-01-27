# LUKS2

###### Note:
As of 26JAN2023, Hashcat does not support cracking LUKS2 default hashes (argon2i). A manual approach is required at a significant cost in the form of time.

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