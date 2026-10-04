ASM := nasm
SRC_DIR := boot
BUILD_DIR := build
IMAGE := $(BUILD_DIR)/main_floppy.img
BIN := $(BUILD_DIR)/main.bin

.PHONY: all run clean

all: $(IMAGE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BIN): $(SRC_DIR)/boot.asm | $(BUILD_DIR)
	$(ASM) $(SRC_DIR)/boot.asm -f bin -o $(BIN)

$(IMAGE): $(BIN)
	cp $(BIN) $(IMAGE)
	truncate -s 1440k $(IMAGE)

run: $(IMAGE)
	qemu-system-x86_64 -drive format=raw,file=$(IMAGE)

clean:
	rm -rf $(BUILD_DIR)