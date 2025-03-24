#
# Copyright 2024 BayLibre SAS
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
    $(MTK_KERNEL_DIST)/clk-mt8188-apmixedsys.ko \
    $(MTK_KERNEL_DIST)/clk-mt8188-topckgen.ko \
    $(MTK_KERNEL_DIST)/clk-mt8188-infra_ao.ko \
    $(MTK_KERNEL_DIST)/clk-mt8188-peri_ao.ko \
    $(MTK_KERNEL_DIST)/clk-mt8188-mfg.ko \
    $(MTK_KERNEL_DIST)/clk-mt8188-imp_iic_wrap.ko \
    $(MTK_KERNEL_DIST)/clk-mt8188-vdo0.ko \
    $(MTK_KERNEL_DIST)/clk-mt8188-vdo1.ko \
    $(MTK_KERNEL_DIST)/clk-mt8188-vpp0.ko \
    $(MTK_KERNEL_DIST)/clk-mt8188-vpp1.ko \
    $(MTK_KERNEL_DIST)/mtk-eint.ko \
    $(MTK_KERNEL_DIST)/pinctrl-mtk-common-v2.ko \
    $(MTK_KERNEL_DIST)/pinctrl-paris.ko \
    $(MTK_KERNEL_DIST)/pinctrl-mt8188.ko \
    $(MTK_KERNEL_DIST)/mtk-cmdq-mailbox.ko \
    $(MTK_KERNEL_DIST)/mtk-cmdq-helper.ko \
    $(MTK_KERNEL_DIST)/mtk-infracfg.ko \
    $(MTK_KERNEL_DIST)/mtk-mmsys.ko \
    $(MTK_KERNEL_DIST)/mtk-socinfo.ko \
    $(MTK_KERNEL_DIST)/mtk-regulator-coupler.ko \
    $(MTK_KERNEL_DIST)/mtk-mutex.ko \
    $(MTK_KERNEL_DIST)/i2c-mt65xx.ko \
    $(MTK_KERNEL_DIST)/mt6359-auxadc.ko \
    $(MTK_KERNEL_DIST)/rtc-mt6397.ko \
    $(MTK_KERNEL_DIST)/mt6315-regulator.ko \
    $(MTK_KERNEL_DIST)/mt6359-regulator.ko \
    $(MTK_KERNEL_DIST)/mt6397.ko \
    $(MTK_KERNEL_DIST)/spmi-mtk-pmif.ko \
    $(MTK_KERNEL_DIST)/mtk-pmic-wrap.ko \
    $(MTK_KERNEL_DIST)/mtk-pm-domains.ko \
    $(MTK_KERNEL_DIST)/mtk-scpsys.ko \
    $(MTK_KERNEL_DIST)/mtk-smi.ko \
    $(MTK_KERNEL_DIST)/8250_mtk.ko \
    $(MTK_KERNEL_DIST)/mediatek-cpufreq-hw.ko \
    $(MTK_KERNEL_DIST)/cqhci.ko \
    $(MTK_KERNEL_DIST)/mtk-sd.ko \
    $(MTK_KERNEL_DIST)/rpmb-core.ko \
    $(MTK_KERNEL_DIST)/mmc_block.ko \
    $(MTK_KERNEL_DIST)/phy-mtk-tphy.ko \
    $(MTK_KERNEL_DIST)/xhci-mtk-hcd.ko \
    $(MTK_KERNEL_DIST)/mtu3.ko \
    $(MTK_KERNEL_DIST)/scmi_transport_optee.ko \
    $(MTK_KERNEL_DIST)/tee.ko \
    $(MTK_KERNEL_DIST)/optee.ko \
    $(MTK_KERNEL_DIST)/system_heap.ko \
    $(MTK_KERNEL_DIST)/vkms.ko \
    $(MTK_KERNEL_DIST)/nvmem_mtk-efuse.ko \
    $(MTK_KERNEL_DIST)/mtk_iommu.ko \
    $(MTK_KERNEL_DIST)/phy-mtk-mipi-dsi-drv.ko \
    $(MTK_KERNEL_DIST)/drm_display_helper.ko \
    $(MTK_KERNEL_DIST)/mediatek-drm.ko \
    $(MTK_KERNEL_DIST)/pwm-mtk-disp.ko \
    $(MTK_KERNEL_DIST)/pwm_bl.ko \
    $(MTK_KERNEL_DIST)/goodix_ts.ko \
    $(MTK_KERNEL_DIST)/panel-startek-kd070fhfid078.ko \
    $(MTK_KERNEL_DIST)/panel-startek-kd070fhfid015.ko

# Graphics modules
ifeq ($(TARGET_GPU_BACKEND), mesa)
BOARD_VENDOR_KERNEL_MODULES += \
    $(MTK_KERNEL_DIST)/gpu-sched.ko \
    $(MTK_KERNEL_DIST)/panfrost.ko
else ifeq ($(TARGET_GPU_BACKEND), mali)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += \
    $(MTK_KERNEL_DIST)/mali_mt8183_corex.ko \
    $(MTK_KERNEL_DIST)/mali_kbase.ko
endif
