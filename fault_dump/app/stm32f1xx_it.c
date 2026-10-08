#include "stm32f1xx_hal.h"
#include "stm32f1xx_it.h"

#include <stdio.h>

__attribute__((noreturn, used))
void fault_dump(uint32_t *sp, uint32_t fault_id)
{
    const char *names[] = {
        [0] = "HardFault",
        [1] = "BusFault",
        [2] = "UsageFault",
        [3] = "MemManage"
    };

    printf("Fault Source: %s\r\n", names[fault_id]);

    uint32_t r0   = sp[0];
    uint32_t r1   = sp[1];
    uint32_t r2   = sp[2];
    uint32_t r3   = sp[3];
    uint32_t r12  = sp[4];
    uint32_t lr   = sp[5];
    uint32_t pc   = sp[6];
    uint32_t psr  = sp[7];

    uint32_t cfsr = SCB->CFSR;
    uint32_t hfsr = SCB->HFSR;
    uint32_t bfar = SCB->BFAR;
    uint32_t mmfar = SCB->MMFAR;

    printf("\r\n========== FAULT ==========\r\n");
    printf("R0   = 0x%08X\r\n", r0);
    printf("R1   = 0x%08X\r\n", r1);
    printf("R2   = 0x%08X\r\n", r2);
    printf("R3   = 0x%08X\r\n", r3);
    printf("R12  = 0x%08X\r\n", r12);
    printf("LR   = 0x%08X\r\n", lr);
    printf("PC   = 0x%08X\r\n", pc);
    printf("PSR  = 0x%08X\r\n", psr);
    
    if (psr & (1u << 9))  printf("  Handler mode (nested exception)\r\n");
    if (psr & (1u << 24)) printf("  Thumb state\r\n");
    else                  printf("  !! Thumb bit=0, stack may be corrupted!!\r\n");

    printf("\r\nHFSR = 0x%08X\r\n", hfsr);
    if (hfsr & (1u << 30)) printf("  FORCED\r\n");
    if (hfsr & (1u << 1))  printf("  VECTTBL\r\n");


    printf("\r\nCFSR = 0x%08X\r\n", cfsr);
    uint8_t mmfsr = cfsr & 0xFF;
    uint8_t bfsr  = (cfsr >> 8) & 0xFF;
    uint16_t ufsr = (cfsr >> 16) & 0xFFFF;

    if (mmfsr) printf("  MMFSR=0x%02X%s%s%s%s%s\r\n", mmfsr,
        (mmfsr & (1<<7)) ? " MMFARVALID" : "",
        (mmfsr & (1<<0)) ? " IACCVIOL" : "",
        (mmfsr & (1<<1)) ? " DACCVIOL" : "",
        (mmfsr & (1<<3)) ? " MUNSTKERR" : "",
        (mmfsr & (1<<4)) ? " MSTKERR" : "");
    if (mmfsr & (1<<7)) printf("    MMFAR=0x%08X\r\n", mmfar);

    if (bfsr) printf("  BFSR=0x%02X%s%s%s%s%s%s\r\n", bfsr,
        (bfsr & (1<<7)) ? " BFARVALID" : "",
        (bfsr & (1<<0)) ? " IBUSERR" : "",
        (bfsr & (1<<1)) ? " PRECISERR" : "",
        (bfsr & (1<<2)) ? " IMPRECISERR" : "",
        (bfsr & (1<<3)) ? " UNSTKERR" : "",
        (bfsr & (1<<4)) ? " STKERR" : "");
    if (bfsr & (1<<7)) printf("    BFAR=0x%08X\r\n", bfar);

    if (ufsr) printf("  UFSR=0x%04X%s%s%s%s%s%s\r\n", ufsr,
        (ufsr & (1<<0)) ? " UNDEFINSTR" : "",
        (ufsr & (1<<1)) ? " INVSTATE" : "",
        (ufsr & (1<<2)) ? " INVPC" : "",
        (ufsr & (1<<3)) ? " NOCP" : "",
        (ufsr & (1<<8)) ? " UNALIGNED" : "",
        (ufsr & (1<<9)) ? " DIVBYZERO" : "");

    printf("===========================\r\n");

    while (1);
}

/******************************************************************************/
/*           Cortex-M3 Processor Interruption and Exception Handlers          */
/******************************************************************************/
/**
 * @brief This function handles Non maskable interrupt.
 */
void NMI_Handler(void) {

    while (1) {
    }
}

/**
 * @brief This function handles Hard fault interrupt.
 */
void HardFault_Handler(void) {

    __asm volatile(
        "mov r1, #0\n"
        "tst lr, #4\n"
        "ite eq\n"
        "mrseq r0, msp\n"
        "mrsne r0, psp\n"
        "b fault_dump\n"
    );
}

/**
 * @brief This function handles Memory management fault.
 */
void MemManage_Handler(void) {

    while (1) {
    }
}

/**
 * @brief This function handles Prefetch fault, memory access fault.
 */
void BusFault_Handler(void) {

    __asm volatile(
        "mov r1, #1\n"
        "tst lr, #4\n"
        "ite eq\n"
        "mrseq r0, msp\n"
        "mrsne r0, psp\n"
        "b fault_dump\n"
    );
}

/**
 * @brief This function handles Undefined instruction or illegal state.
 */
void UsageFault_Handler(void) {

    __asm volatile(
        "mov r1, #2\n"
        "tst lr, #4\n"
        "ite eq\n"
        "mrseq r0, msp\n"
        "mrsne r0, psp\n"
        "b fault_dump\n"
    );
}

/**
 * @brief This function handles System service call via SWI instruction.
 */
void SVC_Handler(void) {}

/**
 * @brief This function handles Debug monitor.
 */
void DebugMon_Handler(void) {}

/**
 * @brief This function handles Pendable request for system service.
 */
void PendSV_Handler(void) {}

/**
 * @brief This function handles System tick timer.
 */
void SysTick_Handler(void) { HAL_IncTick(); }
