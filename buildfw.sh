#!/bin/sh

set -e
set -x

: ${BR_PATH="toolchain"}
: ${KERNSRC="kernel"}
: ${ARCHIVE="rootfs.tar.gz"}
: ${ROOT_FS="rootfs"}
: ${FIRMWARE="edgerouterlite.fw"}
: ${KERNCONF="edgerouterlite_octeon_defconfig"}
: ${NO_CLEAN="0"}


BR_PATH=$(realpath ${BR_PATH})
KERNSRC=$(realpath ${KERNSRC})
ARCHIVE=${BR_PATH}/output/images/${ARCHIVE}

export ARCH=mips
export CROSS_COMPILE=mips64-northwoodlogic-linux-gnu-
export PATH=${BR_PATH}/output/host/bin:$PATH

rm -Rf   ${ROOT_FS}
mkdir    ${ROOT_FS}
tar -xvf ${ARCHIVE} -C ${ROOT_FS}

ROOT_FS=$(realpath ${ROOT_FS})
WORKSPACE=$(realpath .)
CPUS=$(nproc)

(
	cd ${KERNSRC}
	if ! [ -e ".config" ] || [ "${NO_CLEAN}" = "0" ]; then
		make clean
		make ${KERNCONF}
		sed -i.bakup -e "s^@workspace@^${WORKSPACE}^g" .config
	fi
	make -j${CPUS} vmlinux
	${CROSS_COMPILE}strip vmlinux
	cp vmlinux ${WORKSPACE}/${FIRMWARE}
)


