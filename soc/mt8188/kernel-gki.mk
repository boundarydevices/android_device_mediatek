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
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtk_wdt.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/reset.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-mux.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-cpumux.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-fhctl.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-pll.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-pllfh.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-gate.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-apmixed.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-mtk.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-mt8188-apmixedsys.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-mt8188-topckgen.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-mt8188-infra_ao.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-mt8188-peri_ao.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/clk-mt8188-imp_iic_wrap.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtk-eint.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/pinctrl-mtk-common-v2.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/pinctrl-paris.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/pinctrl-mt8188.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtk-cmdq-mailbox.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtk-cmdq-helper.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtk-infracfg.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtk-mmsys.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtk-mutex.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/i2c-mt65xx.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mt6359-auxadc.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/rtc-mt6397.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mt6359-regulator.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mt6397.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtk-pmic-wrap.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtk-pm-domains.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtk-scpsys.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/8250_mtk.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mediatek-cpufreq-hw.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/cqhci.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtk-sd.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/rpmb-core.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mmc_block.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/phy-mtk-tphy.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/xhci-mtk-hcd.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/mtu3.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/scmi_transport_optee.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/tee.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/optee.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/system_heap.ko \
    vendor/mediatek/prebuilts/kernel/$(TARGET_KERNEL_USE)/mtk/vkms.ko
