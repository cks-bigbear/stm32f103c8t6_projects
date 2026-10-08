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

  .ARM.attributes : { *(.ARM.attributes) }
  .comment        : { *(.comment) }

  .debug_info     : { *(.debug_info*) }
  .debug_abbrev   : { *(.debug_abbrev*) }
  .debug_line     : { *(.debug_line*) }
  .debug_str      : { *(.debug_str*) }
  .debug_ranges   : { *(.debug_ranges*) }
  .debug_frame    : { *(.debug_frame*) }
  .debug_aranges  : { *(.debug_aranges*) }
  .debug_loc      : { *(.debug_loc*) }
  .debug_macro    : { *(.debug_macro*) }
  .debug_pubnames : { *(.debug_pubnames*) }
  .debug_pubtypes : { *(.debug_pubtypes*) }
  .debug_addr     : { *(.debug_addr*) }
  .debug_rnglists : { *(.debug_rnglists*) }

  .symtab         : { *(.symtab) }
  .strtab         : { *(.strtab) }
  .shstrtab       : { *(.shstrtab) }
}