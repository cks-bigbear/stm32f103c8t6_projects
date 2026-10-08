set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_PROCESSOR          arm)

set(CMAKE_C_COMPILER_ID Clang)
set(CMAKE_CXX_COMPILER_ID Clang)

set(CMAKE_C_COMPILER                clang)
set(CMAKE_ASM_COMPILER              ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER              clang++)
set(CMAKE_LINKER                    clang)
set(CMAKE_OBJCOPY                   llvm-objcopy)
set(CMAKE_SIZE                      llvm-size)

set(CMAKE_EXECUTABLE_SUFFIX_ASM     ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C       ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX     ".elf")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# MCU specific flags
set(TARGET_FLAGS "--target=thumbv7m-unknown-none-eabi -mfpu=none")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${TARGET_FLAGS}")
set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS} -x assembler-with-cpp -MP")
 
set(CMAKE_C_FLAGS_DEBUG "-Og -g0 -gdwarf-4")
set(CMAKE_C_FLAGS_RELEASE "-Oz -g0")
set(CMAKE_CXX_FLAGS_DEBUG "-Og -g3 -gdwarf-4")
set(CMAKE_CXX_FLAGS_RELEASE "-Oz -g3")

set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -fno-rtti -fno-exceptions -fno-threadsafe-statics")

