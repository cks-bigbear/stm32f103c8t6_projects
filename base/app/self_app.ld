ENTRY(Reset_Handler)

MEMORY
{
    RAM (xrw)      : ORIGIN = 0x20000000, LENGTH = 20K
    FLASH (rx)      : ORIGIN = 0x8000000, LENGTH = 64K
}

_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS {
    .isr_vector : {
      KEEP(*(.isr_vector))
    } > FLASH
    .text : {
      *(.text) 
      *(.text*)
    } > FLASH
    .rodata : {
      *(.rodata)
      *(.rodata*)
    } > FLASH

    _sidata = LOADADDR(.data);
    .data : {
      _sdata = .; 
      *(.data) 
      *(.data*) 
      _edata = .;
    }  > RAM AT > FLASH

    .bss (NOLOAD) : {
      _sbss = .; 
      *(.bss)
      *(.bss*)
      _ebss = .; 
    } > RAM
}