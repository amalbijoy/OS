# Current Status

The current implementation completes the first kernel bring-up milestone:

- BIOS boot sector loads a fixed-size kernel image.
- A minimal GDT is installed.
- The CPU switches into 32-bit protected mode.
- A freestanding C kernel starts at the linked entry address.
- The kernel writes a message directly to VGA text memory.

Next milestones are long mode, interrupts, hardware input, memory management, and scheduling.