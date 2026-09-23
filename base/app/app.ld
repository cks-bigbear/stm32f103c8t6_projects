ENTRY(Reset_Handler)

MEMORY
{
  RAM (xrw)      : ORIGIN = 0x20000000, LENGTH = 20K
  FLASH (rx)      : ORIGIN = 0x8000000, LENGTH = 64K
}

_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS {
  .isr_vector : ALIGN(4) {
    KEEP(*(.isr_vector))
  } > FLASH

  .text : ALIGN(4) {
    *(.text*)
    *(.rodata*)
  } > FLASH

  .ARM.exidx : ALIGN(4) {
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
  } > FLASH

  .ARM.extab : {
    *(.ARM.extab*)
  } > FLASH

  _sidata = LOADADDR(.data);
  .data : ALIGN(4) {
    _sdata = .;
    *(.data*)
    _edata = .;
  } > RAM AT > FLASH

  .bss (NOLOAD) : ALIGN(4) {
    _sbss = .;
    *(.bss*)
    _ebss = .;
  } > RAM

  .ARM.attributes 0 : { *(.ARM.attributes) }
  .comment        0 : { *(.comment) }

  .debug_info     0 : { *(.debug_info*) }
  .debug_abbrev   0 : { *(.debug_abbrev*) }
  .debug_line     0 : { *(.debug_line*) }
  .debug_str      0 : { *(.debug_str*) }
  .debug_ranges   0 : { *(.debug_ranges*) }
  .debug_frame    0 : { *(.debug_frame*) }
  .debug_aranges  0 : { *(.debug_aranges*) }
  .debug_loc      0 : { *(.debug_loc*) }
  .debug_macro    0 : { *(.debug_macro*) }
  .debug_pubnames 0 : { *(.debug_pubnames*) }
  .debug_pubtypes 0 : { *(.debug_pubtypes*) }
  .debug_addr     0 : { *(.debug_addr*) }
  .debug_rnglists 0 : { *(.debug_rnglists*) }

  .symtab         0 : { *(.symtab) }
  .strtab         0 : { *(.strtab) }
  .shstrtab       0 : { *(.shstrtab) }
}