# OS

> Early-stage hobby operating-system project exploring the boot process, x86 protected mode, and a tiny freestanding C kernel.

## Current status

The current image boots through a hand-written 16-bit BIOS boot sector and reaches a minimal 32-bit kernel.

Implemented:

- Boot sector assembled at the BIOS load address `0x7C00`
- Boot signature `0xAA55`
- BIOS disk read of the first **16 sectors** after the boot sector into memory at `0x1000`
- Minimal GDT setup
- Transition from 16-bit real mode to 32-bit protected mode
- Freestanding C kernel entry point
- Direct VGA text-mode output
- 1.44 MiB floppy image generation
- QEMU run target

The kernel image is currently limited by the 16-sector boot-time read. Interrupts, long mode, memory management, drivers, scheduling, filesystems, and user mode are not implemented yet.

## Build and run

### Prerequisites

- NASM
- GNU Make
- GCC with 32-bit support
- GNU binutils
- QEMU with `qemu-system-x86_64`

Build the image:

```bash
make
```

Run it:

```bash
make run
```

The generated disk image is:

```text
build/main_floppy.img
```

Clean generated build files:

```bash
make clean
```

## Repository layout

```text
OS/
├── boot/
│   └── boot.asm
├── kernel/
│   ├── entry.asm
│   ├── kernel.c
│   └── linker.ld
├── docs/
│   ├── ROADMAP.md
│   └── STATUS.md
├── Makefile
└── README.md
```

The `build/` directory is generated locally and is not part of the source tree.

## Architecture

The current boot flow is intentionally small:

```text
BIOS
  ↓
boot.asm (16-bit real mode)
  ↓
load kernel to 0x1000
  ↓
install GDT
  ↓
enter 32-bit protected mode
  ↓
kernel/entry.asm
  ↓
kernel/kernel.c
  ↓
VGA text memory
```

## Engineering notes

This repository documents the implementation as it exists rather than presenting future kernel features as completed. The project is being built incrementally so each step can be reproduced and inspected.

See [docs/STATUS.md](docs/STATUS.md) for the current milestone and [docs/ROADMAP.md](docs/ROADMAP.md) for planned work.

## License

See [LICENSE](LICENSE).
