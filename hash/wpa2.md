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

