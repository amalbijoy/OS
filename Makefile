ASM := nasm
CC := gcc
LD := ld
OBJCOPY := objcopy

BUILD_DIR := build
BOOT_BIN := $(BUILD_DIR)/boot.bin
KERNEL_ENTRY_OBJ := $(BUILD_DIR)/kernel_entry.o
KERNEL_OBJ := $(BUILD_DIR)/kernel.o
KERNEL_ELF := $(BUILD_DIR)/kernel.elf
KERNEL_BIN := $(BUILD_DIR)/kernel.bin
IMAGE := $(BUILD_DIR)/main_floppy.img
KERNEL_MAX_BYTES := 8192

.PHONY: all run clean

all: $(IMAGE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BOOT_BIN): boot/boot.asm | $(BUILD_DIR)
	$(ASM) boot/boot.asm -f bin -o $(BOOT_BIN)

$(KERNEL_ENTRY_OBJ): kernel/entry.asm | $(BUILD_DIR)
	$(ASM) kernel/entry.asm -f elf32 -o $(KERNEL_ENTRY_OBJ)

$(KERNEL_OBJ): kernel/kernel.c | $(BUILD_DIR)
	$(CC) -m32 -ffreestanding -fno-pie -fno-stack-protector -O2 -Wall -Wextra -c kernel/kernel.c -o $(KERNEL_OBJ)

$(KERNEL_ELF): $(KERNEL_ENTRY_OBJ) $(KERNEL_OBJ) kernel/linker.ld
	$(LD) -m elf_i386 -T kernel/linker.ld -o $(KERNEL_ELF) $(KERNEL_ENTRY_OBJ) $(KERNEL_OBJ)

$(KERNEL_BIN): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $(KERNEL_ELF) $(KERNEL_BIN)
	@echo "Kernel image generated: $(KERNEL_BIN)"

$(IMAGE): $(BOOT_BIN) $(KERNEL_BIN)
	cat $(BOOT_BIN) > $(IMAGE)
	dd if=/dev/zero bs=512 count=15 >> $(IMAGE)
	dd if=$(KERNEL_BIN) of=$(IMAGE) bs=512 seek=1 conv=notrunc
	truncate -s 1440k $(IMAGE)

run: $(IMAGE)
	qemu-system-x86_64 -drive format=raw,file=$(IMAGE)

clean:
	rm -rf $(BUILD_DIR)
