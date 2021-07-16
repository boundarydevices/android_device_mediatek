# Kernel Source Code organization

In order to ease the maintenance of the kernel, and to follow Google
recommendations, we are using a common kernel which targets all SoC from
mediatek.

This design choice has the following advantages:

  - scale across many different customers and products
  - provide a sane way to deliver updates from our internal trees to
    downstream customer trees
  - protect customer IP & product-specific customizations from being
    shared with the wrong party

This implies few design policies to respect to make it work:

  - the device tree for customer’s product has to be placed in a
    separate folder
  - all the drivers written for a customer must be modules

## Kernel sources

The common kernel sources, the external modules, the product device tree
and drivers are located in `~/src/mediatek-kernel/`.

  - `src`: The common kernel sources. This supports some SoC from
    mediatek, and their evaluation boards.
  - `prebuilts`, `prebuilts-master/`: Contains the toolchains. This used
    to build the kernel, the modules and the dtb and some binaries. By
    using this, we can ensure that binaries will build and works
    whatever is the host used to build them.
  - `build`: Contains a set of scripts used to build the kernel and the
    modules. For more details, please see
    <https://source.android.com/setup/build/building-kernels>.
  - `out`: Created by the build system, this contains all the temporary
    files and the output files: kernel, modules, dtb, etc.
  - `innocomm_sb30`: If this folder exists, then it contains the device tree for
    the product, and, the drivers for this product.
  - `<external modules>`: If they exist, these folders contain kernel
    drivers from third party, usually Bluetooth and WiFi kernel drivers.

### Common kernel

The common kernel is a Linux kernel 4.19 updated to support Android and
mediatek SoC. This is a LTS (long term support) kernel which means it
will receive for a couple of years all the security and bug fixes. In
addition, this kernel includes many changes required by Android to work
properly. The goal of the common kernel is to have only one kernel
binary that could work on all mediatek SoC. All the changes required for
a specific product will be kept separated (external kernel modules) and
loaded at runtime.

#### Build configuration

The kernel is built using some script from AOSP. To configure the
behavior of the build system, we have to use a build configuration file.
The common kernel provides two configuration files:

  - `build.config.mtk`: Configured to build the common kernel, all the
    modules and device tree required for the mediatek evaluation boards.
    This also provides many helpers that could used by product kernel
    build configuration files.
  - `build.config.mtk.menuconfig`: Could be used to change the kernel
    configuration. This updates `mtk_android_defconfig`.

### Product kernel sources

If a product need a specific driver or device tree, this should go here,
in the product kernel folder. This is usually in organized in this way:

  - `Makefile`: This provides the expected rules required by the build
    script to build the device tree and the drivers. This also allows to
    write Makefile using same rules as the kernel.
  - `build.config.mtk`: This inherits from `build.config.mtk`, and
    should be used to build the common kernel, and every thing else
    needed for the product.
  - `dts`: Contains sources of device tree. Actually, this not really a
    device tree, but a device tree overlay, that will be applied to the
    SoC device tree file coming from the common kernel.
  - `drivers`: Contains all the drivers for the product, built as
    modules.
