org 0x7C00
bits 16

KERNEL_LOAD_SEGMENT equ 0x100
KERNEL_SECTORS     equ 16

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov [boot_drive], dl

    ; Load the first 16 sectors after the boot sector to 0x1000.
    mov bx, 0x1000
    mov ah, 0x02
    mov al, KERNEL_SECTORS
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [boot_drive]
    int 0x13
    jc disk_error

    ; Load a flat GDT and switch to 32-bit protected mode.
    cli
    lgdt [gdt_descriptor]

    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:protected_mode

disk_error:
    mov si, disk_error_message
.print:
    lodsb
    test al, al
    jz .halt
    mov ah, 0x0E
    mov bh, 0
    int 0x10
    jmp .print

.halt:
    cli
    hlt
    jmp .halt

bits 32
protected_mode:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov esp, 0x90000

    ; The kernel binary is linked to 0x1000 and begins with _start.
    call 0x1000

.hang:
    cli
    hlt
    jmp .hang

align 8
gdt_start:
    dq 0x0000000000000000
    dq 0x00CF9A000000FFFF
    dq 0x00CF92000000FFFF
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_start + 8 - gdt_start
DATA_SEG equ gdt_start + 16 - gdt_start

boot_drive db 0
disk_error_message db "Disk read failed.", 0

times 510-($-$$) db 0
dw 0xAA55
