typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

static volatile uint16_t *const VGA = (uint16_t *)0xB8000;

static void write_string(const char *text) {
    uint32_t i = 0;
    while (text[i] != '\0') {
        VGA[i] = (uint16_t)text[i] | ((uint16_t)0x07 << 8);
        i++;
    }
}

void kernel_main(void) {
    write_string("AmalOS: kernel started in 32-bit protected mode.");
}
