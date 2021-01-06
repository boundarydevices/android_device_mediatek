# A/B OTA testing procedure

## Generate an OTA package

The standard AOSP procedure using `make dist` is used. Please refer to
the [official
documentation](https://source.android.com/devices/tech/ota/tools)

## Apply OTA via adb

    $ adb root
    $ adb reboot sideload
    $ adb wait-for-sideload
    $ adb sideload dist_output/innocomm_sb30-ota-eng.${USER}.zip
    $ adb reboot

## Apply OTA via `SystemUpdaterSample` app

1.  Run the SystemUpdaterSample app
    once:

    ```
     $ adb shell am start com.example.android.systemupdatersample/com.example.android.systemupdatersample.ui.MainActivity
    ```

2.  Generate json config with:

    ```
     $ cd ~/src/mediatek/
     $ source build/envsetup.sh
     $ lunch innocomm_sb30-userdebug
     $ PYTHONPATH=$ANDROID_BUILD_TOP/build/make/tools/releasetools:$PYTHONPATH \
         bootable/recovery/updater_sample/tools/gen_update_config.py \
         --ab_install NON_STREAMING \
         dist_output/innocomm_sb30-ota-eng.${USER}.zip \
         dist_output/innocomm_sb30-ota-eng.${USER}.json \
         file:///data/user/0/com.example.android.systemupdatersample/files/packages/innocomm_sb30-ota-eng.${USER}.zip
    ```

3.  Push the files on the board:

    ```
     $ adb root
     $ adb shell mkdir /data/user/0/com.example.android.systemupdatersample/files/configs
     $ adb shell mkdir /data/user/0/com.example.android.systemupdatersample/files/packages
     $ adb push dist_output/innocomm_sb30-ota-eng.${USER}.json /data/user/0/com.example.android.systemupdatersample/files/configs/
     $ adb push dist_output/innocomm_sb30-ota-eng.${USER}.zip /data/user/0/com.example.android.systemupdatersample/files/packages/
    ```

4.  Run the update on the UI:

      - Tap on `RELOAD` to load the config
      - Tap on `APPLY` to apply the OTA
      - Tap `OK` to confirm application
      - Wait for progress bar to complete
      - Tap on `SWITCH SLOT` to finish update

5.  Reboot the device
    with:

    ```
     $ adb shell svc power reboot
    ```

## More links/information

  - [bootable/recovery/updater\_sample/README.md](https://android.googlesource.com/platform/bootable/recovery/+/refs/heads/master/updater_sample/README.md)
  - [AOSP
    website](https://source.android.com/devices/tech/ota/ab#overview)
