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

