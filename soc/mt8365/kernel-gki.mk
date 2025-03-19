#
# Copyright 2025 BayLibre SAS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# commandline
BOARD_KERNEL_CMDLINE += \
    8250.nr_uarts=1 \
    console=ttyS0,921600

# Kernel modules
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += \
    $(MTK_KERNEL_DIST)/mtk_wdt.ko \
    $(MTK_KERNEL_DIST)/reset.ko \
    $(MTK_KERNEL_DIST)/clk-mux.ko \
    $(MTK_KERNEL_DIST)/clk-cpumux.ko \
    $(MTK_KERNEL_DIST)/clk-fhctl.ko \
    $(MTK_KERNEL_DIST)/clk-pll.ko \
    $(MTK_KERNEL_DIST)/clk-pllfh.ko \
    $(MTK_KERNEL_DIST)/clk-gate.ko \
    $(MTK_KERNEL_DIST)/clk-apmixed.ko \
    $(MTK_KERNEL_DIST)/clk-mtk.ko \
    $(MTK_KERNEL_DIST)/clk-mt8365.ko \
    $(MTK_KERNEL_DIST)/clk-mt8365-apmixedsys.ko \
    $(MTK_KERNEL_DIST)/clk-mt8365-apu.ko \
    $(MTK_KERNEL_DIST)/clk-mt8365-cam.ko \
    $(MTK_KERNEL_DIST)/clk-mt8365-mfg.ko \
    $(MTK_KERNEL_DIST)/clk-mt8365-mm.ko \
    $(MTK_KERNEL_DIST)/clk-mt8365-vdec.ko \
    $(MTK_KERNEL_DIST)/clk-mt8365-venc.ko \
    $(MTK_KERNEL_DIST)/irq-mtk-sysirq.ko \
    $(MTK_KERNEL_DIST)/mtk-eint.ko \
    $(MTK_KERNEL_DIST)/pinctrl-mtk-common.ko \
    $(MTK_KERNEL_DIST)/pinctrl-mt8365.ko \
    $(MTK_KERNEL_DIST)/mtk-cmdq-mailbox.ko \
    $(MTK_KERNEL_DIST)/mtk-cmdq-helper.ko \
    $(MTK_KERNEL_DIST)/mtk-infracfg.ko \
    $(MTK_KERNEL_DIST)/mtk-mmsys.ko \
    $(MTK_KERNEL_DIST)/mtk-mutex.ko \
    $(MTK_KERNEL_DIST)/i2c-mt65xx.ko \
    $(MTK_KERNEL_DIST)/mt6359-auxadc.ko \
    $(MTK_KERNEL_DIST)/mt6357-regulator.ko \
    $(MTK_KERNEL_DIST)/mt6397.ko \
    $(MTK_KERNEL_DIST)/mtk-pmic-wrap.ko \
    $(MTK_KERNEL_DIST)/mtk-pm-domains.ko \
    $(MTK_KERNEL_DIST)/mtk-scpsys.ko \
    $(MTK_KERNEL_DIST)/mtk-smi.ko \
    $(MTK_KERNEL_DIST)/8250_mtk.ko \
    $(MTK_KERNEL_DIST)/mediatek-cpufreq.ko \
    $(MTK_KERNEL_DIST)/cqhci.ko \
    $(MTK_KERNEL_DIST)/mtk-sd.ko \
    $(MTK_KERNEL_DIST)/rpmb-core.ko \
    $(MTK_KERNEL_DIST)/mmc_block.ko \
    $(MTK_KERNEL_DIST)/phy-mtk-tphy.ko \
    $(MTK_KERNEL_DIST)/xhci-mtk-hcd.ko \
    $(MTK_KERNEL_DIST)/mtu3.ko \
    $(MTK_KERNEL_DIST)/usb-conn-gpio.ko \
    $(MTK_KERNEL_DIST)/scmi_transport_optee.ko \
    $(MTK_KERNEL_DIST)/tee.ko \
    $(MTK_KERNEL_DIST)/optee.ko \
    $(MTK_KERNEL_DIST)/system_heap.ko \
    $(MTK_KERNEL_DIST)/vkms.ko \
    $(MTK_KERNEL_DIST)/mtk_iommu.ko \
    $(MTK_KERNEL_DIST)/phy-mtk-mipi-dsi-drv.ko \
    $(MTK_KERNEL_DIST)/drm_display_helper.ko \
    $(MTK_KERNEL_DIST)/display-connector.ko \
    $(MTK_KERNEL_DIST)/mediatek-drm.ko \
    $(MTK_KERNEL_DIST)/pwm-mtk-disp.ko \
    $(MTK_KERNEL_DIST)/pwm_bl.ko \
    $(MTK_KERNEL_DIST)/panel-startek-kd070fhfid015.ko
