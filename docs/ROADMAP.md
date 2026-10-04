# OS Roadmap

The project is intentionally incremental. Each phase should leave a bootable artifact and a small, testable piece of new functionality.

## Phase 0 — Boot sector

- [x] Enter at BIOS load address `0x7C00`
- [x] Produce the `0xAA55` boot signature
- [x] Build a 1.44 MiB floppy image
- [x] Boot the image in QEMU

## Phase 1 — Kernel entry

- [ ] Add a second-stage loader
- [ ] Load a kernel image from disk
- [ ] Introduce a C kernel entry point
- [ ] Establish a linker script and predictable memory layout

## Phase 2 — CPU setup

- [ ] Add a GDT
- [ ] Enter protected mode
- [ ] Add a 64-bit long-mode transition
- [ ] Add an IDT and exception handlers

## Phase 3 — Hardware basics

- [ ] Programmable interval timer
- [ ] Keyboard input
- [ ] Serial logging
- [ ] Basic framebuffer/text output

## Phase 4 — Memory

- [ ] Physical frame allocator
- [ ] Page tables
- [ ] Kernel heap
- [ ] Memory diagnostics

## Phase 5 — Scheduling

- [ ] Task representation
- [ ] Context switching
- [ ] Round-robin scheduler
- [ ] Timer-driven preemption

## Phase 6 — Persistence and user mode

- [ ] Filesystem experiments
- [ ] User-mode process
- [ ] System-call interface
- [ ] Minimal shell

## Engineering standards

Every major phase should add:

1. A documented design decision.
2. A reproducible build/run command.
3. Tests or boot-time assertions where practical.
4. A short changelog entry explaining what changed.