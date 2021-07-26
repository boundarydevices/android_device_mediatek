Flashing only one partition
~~~~~~~~~~~~~~~~~~~~~~~~~~~

To flash just one partition, you can run the following command:

.. prompt:: bash $

   cd ~/src/rita/out/target/product/i300a_pumpkin/
   adb reboot bootloader
   fastboot flash [PARTITION] [FILE]
   fastboot continue

``[PARTITION]`` should be replaced with one of the following:

-  *bootloaders*: for flashing the bootloaders (such as u-boot)
-  *boot*: for flashing the Linux Kernel (``boot.img``).
-  *imageXXX*: for flashing an android image named ``imageXXX.img``

For example, the commands to flash the bootloaders are:

.. prompt:: bash $

   cd ~/src/rita/out/target/product/i300a_pumpkin/
   adb reboot bootloader
   fastboot flash bootloaders fip.bin
   fastboot continue

The commands to flash the kernel are:

.. prompt:: bash $

   cd ~/src/rita/out/target/product/i300a_pumpkin/
   adb reboot fastboot
   fastboot flash boot boot.img
   fastboot flash dtbo dtbo.img
   fastboot flash vendor vendor.img
   fastboot continue
