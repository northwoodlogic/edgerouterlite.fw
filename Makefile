
ROOT_ARCHIVE ?= toolchain/output/images/rootfs.tar.gz
TOOLCHAIN_DEFCONF ?= northwoodlogic_mips64_defconfig

all: $(ROOT_ARCHIVE)

$(ROOT_ARCHIVE) :
	$(MAKE) -C toolchain $(TOOLCHAIN_DEFCONF)
	$(MAKE) -C toolchain


clobber :
	make -C toolchain clean
