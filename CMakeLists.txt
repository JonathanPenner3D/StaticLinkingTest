# Premable
cmake_minimum_required(VERSION 3.29)
cmake_policy(SET CMP0157 NEW)

set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/swift)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/tests)

project(StaticLinking LANGUAGES Swift)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# The dynamic library
add_library(StaticLinking SHARED StaticLinking.swift)
target_compile_options(StaticLinking PRIVATE "SHELL: -static-stdlib -Xlinker -static-stdlib")

# I noticed that the -Xlinker args in the `target_compile_options`
# wouldn't actually be passed to the link command, so set them here.
# I've expanded the contents of the `static-stdlib-args.lnk` file for convenience here.
set(STATIC_LIB_FLAGS "-static-stdlib -Xlinker '-rpath=$ORIGIN' -ldl -lpthread -lswiftCore -ldispatch -lBlocksRuntime -lstdc++ -lm -Xlinker -export-dynamic -Xlinker --exclude-libs -Xlinker ALL")
set_target_properties(StaticLinking PROPERTIES LINK_FLAGS  ${STATIC_LIB_FLAGS})

install(TARGETS StaticLinking
    LIBRARY DESTINATION .
    INCLUDES DESTINATION .
)
install(
    DIRECTORY ${CMAKE_Swift_MODULE_DIRECTORY}/
    DESTINATION .
)

# Now the executable test target
add_executable(StaticLinkingTests main.swift)
target_link_libraries(StaticLinkingTests PRIVATE StaticLinking)
install(TARGETS StaticLinkingTests DESTINATION .)
