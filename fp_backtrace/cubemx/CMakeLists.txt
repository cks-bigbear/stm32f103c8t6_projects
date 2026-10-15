set(MX_Defines_Syms 
	USE_HAL_DRIVER 
	STM32F103xB
    $<$<CONFIG:Debug>:DEBUG>
)

# STM32CubeMX generated include paths
set(MX_Include_Dirs
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Core/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/CMSIS/Device/ST/STM32F1xx/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/CMSIS/Include
)

# STM32CubeMX generated application sources
set(MX_Application_Src
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Core/Src/gpio.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Core/Src/usart.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Core/Src/stm32f1xx_it.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Core/Src/stm32f1xx_hal_msp.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Core/Src/sysmem.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Core/Src/syscalls.c
)

# STM32 HAL/LL Drivers
set(STM32_Drivers_Src
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Core/Src/system_stm32f1xx.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_uart.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f103c8t6/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c
)

# Drivers Midllewares

# Interface library for includes and symbols
add_library(stm32cubemx INTERFACE)
target_include_directories(stm32cubemx INTERFACE ${MX_Include_Dirs})
target_compile_definitions(stm32cubemx INTERFACE ${MX_Defines_Syms})

# Create STM32_Drivers static library
add_library(STM32_Drivers OBJECT)
target_sources(STM32_Drivers PRIVATE ${STM32_Drivers_Src})
target_link_libraries(STM32_Drivers PUBLIC stm32cubemx)

add_library(cubemx STATIC)
target_sources(cubemx PRIVATE ${MX_Application_Src})

# Add libraries to the project
target_link_libraries(cubemx PUBLIC STM32_Drivers)
