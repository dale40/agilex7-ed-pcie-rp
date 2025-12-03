SUMMARY = "Intel SoCFPGA Development Kit Linux Kernel layer for PCIe Root Port Example Designs"
DESCRIPTION = "Linux Kernel addons for PCIe Root Port Example Designs on Intel SoCFPGA Development Kits"
SECTION = "kernel"

LICENSE = "MIT & GPL-2.0-only"

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-socfpga-lts:"

SRC_URI:append:agilex7_dk_dev_agm039fes = " \
	${@bb.utils.contains("IMAGE_TYPE", "rped", "file://nvme.scc", "", d)} \
	${@bb.utils.contains("IMAGE_TYPE", "rped", "file://fit_kernel_agilex7_dk_dev_agm039fes_rped.its", "", d)} \
	${@bb.utils.contains("IMAGE_TYPE", "rped", "file://0001-PCI-altera-set-maximum-supported-TLP-data-payload-si.patch", "", d)} \
	${@bb.utils.contains("IMAGE_TYPE", "rped", "file://0002-Reserved-RAM-area-required-by-pcie-rootport-on-FPGA.patch", "", d)} \
	"

SRC_URI:append:agilex7_dk_si_agi027fc = " \
	${@bb.utils.contains("IMAGE_TYPE", "gsrd", "file://nvme.scc", "", d)} \
	${@bb.utils.contains("IMAGE_TYPE", "gsrd", "file://fit_kernel_agilex7_dk_si_agi027fc_gsrd.its", "", d)} \
	${@bb.utils.contains("IMAGE_TYPE", "gsrd", "file://0001-PCI-altera-set-maximum-supported-TLP-data-payload-si.patch", "", d)} \
	${@bb.utils.contains("IMAGE_TYPE", "gsrd", "file://0002-Reserved-RAM-area-required-by-pcie-rootport-on-FPGA.patch", "", d)} \
	"

SRC_URI:append:agilex7_dk_si_agf014eb = " \
	${@bb.utils.contains("IMAGE_TYPE", "gsrd", "file://nvme.scc", "", d)} \
	${@bb.utils.contains("IMAGE_TYPE", "gsrd", "file://fit_kernel_agilex7_dk_si_agf014eb_gsrd.its", "", d)} \
	${@bb.utils.contains("IMAGE_TYPE", "gsrd", "file://0001-PCI-altera-set-maximum-supported-TLP-data-payload-si.patch", "", d)} \
	${@bb.utils.contains("IMAGE_TYPE", "gsrd", "file://0002-Reserved-RAM-area-required-by-pcie-rootport-on-FPGA.patch", "", d)} \
	${@bb.utils.contains("IMAGE_TYPE", "gsrd", "file://0003-DTS-Add-node-to-support-pcie-legacy-interrupts.patch", "", d)} \
	${@bb.utils.contains("IMAGE_TYPE", "gsrd", "file://0004-Add-PCIe-RP-driver-support-for-Legacy-INTx-interrupts.patch", "", d)} \
	"

do_deploy:append() {
	# RPED: start linux-socfpga MACHINE is ${MACHINE} and IMAGE_TYPE is ${IMAGE_TYPE}

	# linux.dtb
	cp ${DTBDEPLOYDIR}/socfpga_agilex7_socdk.dtb ${B}
	cp ${DTBDEPLOYDIR}/socfpga_agilex7_vanilla.dtb ${B}

	# core.rbf
	cp ${DEPLOY_DIR_IMAGE}/${MACHINE}_${IMAGE_TYPE}_ghrd/ghrd.core.rbf ${B}

	cp ${WORKDIR}/sources-unpack/fit_kernel_${MACHINE}_${IMAGE_TYPE}.its ${B}

	# Image
	cp ${LINUXDEPLOYDIR}/Image ${B}
	# Compress Image to lzma format
	xz --format=lzma --force ${B}/Image
	# Generate kernel.itb
	mkimage -f ${B}/fit_kernel_${MACHINE}_${IMAGE_TYPE}.its ${B}/kernel.itb
	# Deploy kernel.its, kernel.itb and Image.lzma
	install -m 744 ${B}/fit_kernel_${MACHINE}_${IMAGE_TYPE}.its ${DEPLOYDIR}
	install -m 744 ${B}/kernel.itb ${DEPLOYDIR}
	install -m 744 ${B}/Image.lzma ${DEPLOYDIR}
	# RPED: end linux-socfpga MACHINE is ${MACHINE} and IMAGE_TYPE is ${IMAGE_TYPE}
	exit 0
}
