MT7668 E-fuse provisioning
==========================

MT7668 has a dynamic, re-programmable memory on silicon named E-fuse. We
can use the E-fuse to configure a persistent (surviving board re-flash)
MAC address for WiFi and Bluetooth.

For more details of the E-Fuse content, refer to MediaTek's document
named `E-FUSE_Content_Introduction_V11.pdf`

WiFi MAC address
----------------

To provision the WiFi MAC address

``` {.sh}
# wifitest -O
copy from /vendor/firmware/EEPROM_MT7668.bin to /data/misc/wifi/EEPROM_MT7668.bin
/data/misc/wifi/EEPROM_MT7668.bin is ready
```

``` {.sh}
# wifitest -z 'W 00:11:66:66:66:aa'
EFUSE[0x4] = 0x00
EFUSE[0x5] = 0x11
EFUSE[0x6] = 0x66
EFUSE[0x7] = 0x66
EFUSE[0x8] = 0x66
EFUSE[0x9] = 0xAA
(success) Write EFUSE WIFI MAC
```

Then, to verify:

-   reboot the device
-   dump the mac address from Android:

``` {.sh}
# ifconfig wlan0
  wlan0     Link encap:Ethernet  HWaddr 00:11:66:66:66:aa  Driver wlan
            UP BROADCAST MULTICAST  MTU:1500  Metric:1
            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000
            RX bytes:0 TX bytes:0
```

Note: the WiFi driver **won't** configure any "bad" addresses. Always
pick a valid mac address when provisioning.

Bluetooth BDaddress
-------------------

To configure the BDaddr:

``` {.sh}
# wifitest -z 'B 00:0c:e7:55:ff:12'
```

Will display:

    EFUSE[0x384] = 0x00
    EFUSE[0x385] = 0x0C
    EFUSE[0x386] = 0xE7
    EFUSE[0x387] = 0x55
    EFUSE[0x388] = 0xFF
    EFUSE[0x389] = 0x12
    (success) Write EFUSE BT MAC

Then, to verify:

-   reboot the device
-   dump the bdaddr from Android:

``` {.sh}
# dumpsys bluetooth_manager | head -10
Bluetooth Status
  enabled: true
  state: ON
  address: 00:0C:E7:55:FF:12
  name: <omitted>
  time since enabled: 00:20:07.412
```
