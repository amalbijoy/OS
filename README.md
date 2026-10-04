# OS

> Early-stage hobby operating-system project built from a hand-written x86 boot sector.

## Current status

The repository currently contains a **boot-sector prototype** written in x86 assembly. The boot sector is assembled into a 1.44 MiB floppy image and currently halts intentionally after BIOS loads it.

This is a learning project: the goal is to progress from the boot process into a small custom kernel, then gradually add interrupts, memory management, drivers, and scheduling.

## What exists today

- 16-bit boot-sector entry point at `0x7C00`
- Boot signature `0xAA55`
- NASM-based build
- 1.44 MiB raw floppy image generation
- QEMU run target

## Roadmap

See [docs/ROADMAP.md](docs/ROADMAP.md) for the implementation plan.

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