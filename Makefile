FWIMAGE            = edgerouterlite.fw

NO_CLEAN          ?= 0
BR_PATH           ?= ./toolchain
ROOT_ARCHIVE      ?= $(BR_PATH)/output/images/rootfs.tar.gz
TOOLCHAIN_DEFCONF ?= northwoodlogic_mips64_defconfig

all: $(FWIMAGE)

$(FWIMAGE) : $(ROOT_ARCHIVE)
	NO_CLEAN=$(NO_CLEAN) BR_PATH=$(BR_PATH) $(BR_PATH)/output/host/bin/fakeroot ./buildfw.sh

$(ROOT_ARCHIVE) :
	$(MAKE) -C toolchain $(TOOLCHAIN_DEFCONF)
	$(MAKE) -C toolchain


clobber :
	make -C toolchain clean
