
set(APP_TARGET "app")

# Create an executable object type
add_executable(${APP_TARGET})

target_link_options(${APP_TARGET}
  PRIVATE
  "-Wl,--gc-sections"
  "-T" "${CMAKE_CURRENT_SOURCE_DIR}/app.ld"
  "-Wl,--print-memory-usage"
  "-Wl,--orphan-handling=warn"
  "-Wl,-Map=$<TARGET_FILE_DIR:${APP_TARGET}>/$<TARGET_NAME:${APP_TARGET}>_$<CONFIG>.map"
)

target_compile_options(${APP_TARGET}
  PRIVATE
)

target_compile_definitions(${APP_TARGET} PRIVATE

)

# Add include paths
target_include_directories(${APP_TARGET} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/
)

# Add sources to executable
target_sources(${APP_TARGET} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/startup_stm32f103xb.S
    ${CMAKE_CURRENT_SOURCE_DIR}/stm32f1xx_it.c
    ${CMAKE_CURRENT_SOURCE_DIR}/main.c
    ${CMAKE_CURRENT_SOURCE_DIR}/console.c
    ${CMAKE_CURRENT_SOURCE_DIR}/fault_trigger.c
)

# Link directories setup
target_link_directories(${APP_TARGET} PRIVATE
    # Add user defined library search paths
)

# Add linked libraries
target_link_libraries(${APP_TARGET} PRIVATE
    cubemx
    ${TOOLCHAIN_LINK_LIBRARIES}
)

# Add the map file to the list of files to be removed with 'clean' target
set_target_properties(${APP_TARGET} PROPERTIES
  ADDITIONAL_CLEAN_FILES "$<TARGET_FILE_DIR:${APP_TARGET}>/$<TARGET_NAME:${APP_TARGET}>_$<CONFIG>.map"
)
