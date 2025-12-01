# Intel® Agilex™ 7 PCIe Root Port System Example Design Build Scripts

This directory contains the Quartus Project for the Intel® Agilex™ 7 PCIe Root Port System Example Design.

# Dependency

- Intel® Quartus Prime (See Release Notes for the supported version)
- Supported Board:
  - [Intel® Agilex™ 7 FPGA M-Series Development Kit - HBM2e Edition (3x F-Tile & 1x R-Tile)](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/agm039.html)

# Build Steps

 1. Compile design and generate configuration file:

    ```
    cd syn/
	make all
    ```

# Programming Files Generation Steps

 1. Generate `top.{core,hps}.rbf` including U-Boot SPL:

    ```
    cd syn/
    quartus_pfg -c -o hps=on -o hps_path=../../../sw/artifacts/ag7m039_devkit/u-boot-spl-dtb.hex output_files/top.sof output_files/top.rbf
    ```
