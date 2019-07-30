import common

def FullOTA_Assertions(params):
    if params.info_dict['has_dtbo'] != 'true':
        assert False, "target build has no dtbo partition"

def FullOTA_InstallBegin(params):
    print('WARNING: temporary disabling treble to bypass compatibility check')
    params.info_dict['build.prop']['ro.treble.enabled'] = 'false'

def FullOTA_InstallEnd(params):
    # add dtbo.img to the ota package
    print('Adding dtbo.img to the ota package')
    dtbo_img = params.input_zip.read("IMAGES/dtbo.img")
    common.ZipWriteStr(params.output_zip, "dtbo.img", dtbo_img)

    params.script.WriteRawImage("/dtbo", "dtbo.img")

    print('WARNING: re-enabling treble after bypass compatibility check')
    params.info_dict['build.prop']['ro.treble.enabled'] = 'true'
