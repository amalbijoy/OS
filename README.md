# OS

> Early-stage hobby operating-system project built from a hand-written x86 boot sector and an early freestanding C kernel.

## Current status

The repository contains a BIOS boot sector plus an early freestanding kernel. The boot sector loads the kernel, installs a minimal GDT, enters 32-bit protected mode, and transfers control to the kernel.

This is a learning project: the goal is to progress from the boot process into a small custom kernel, then gradually add interrupts, memory management, drivers, and scheduling.

## What exists today

- 16-bit boot-sector entry point at `0x7C00`
- Boot signature `0xAA55`
- NASM + GCC/ld build
- GDT and 32-bit protected-mode transition
- Freestanding C kernel with direct VGA text output
- 1.44 MiB raw floppy image generation
- QEMU run target

## Project status

See [docs/STATUS.md](docs/STATUS.md) for the current bring-up milestone and [docs/ROADMAP.md](docs/ROADMAP.md) for the longer-term plan.

## Build and run

Prerequisites:

- NASM
- GNU Make
- QEMU (`qemu-system-x86_64`)

    make
    make run

The generated image is `build/main_floppy.img`.

## Repository layout

    OS/
    ├── boot/
    │   └── boot.asm
    ├── build/          # generated locally; ignored by Git
    ├── docs/
    │   └── ROADMAP.md
    ├── Makefile
    └── README.md

## Scope

The README intentionally documents only functionality that is actually implemented. Future kernel features are tracked in the roadmap rather than presented as completed capabilities.

## License

See [LICENSE](LICENSE).