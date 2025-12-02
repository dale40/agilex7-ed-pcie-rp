# Intel® Agilex™ 7 PCIe Root Port System Example Design Build Scripts

This directory contains the Quartus Project for the Intel® Agilex™ 7 PCIe Root Port System Example Design.

# Dependency

- Intel® Quartus Prime (See Release Notes for the supported version)
- Supported Board:
  - (https://www.altera.com/products/devkit/a1jui0000061r0pmaq/agilex-7-fpga-f-series-transceiver-soc-development-kit-p-tile-and-e-tile)

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
    quartus_pfg -c -o hps=on -o hps_path=../../../sw/artifacts/ag7f014_devkit/u-boot-spl-dtb.hex output_files/top.sof output_files/top.rbf
    ```
