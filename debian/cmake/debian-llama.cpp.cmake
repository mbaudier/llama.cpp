cmake_minimum_required(VERSION 3.14) # for add_link_options and implicit target directories.

# GGML dependencies
find_library(GGML_BASE_LOCATION ggml-base)

# define GGML as target so that it is disabled in llama.cpp build
find_library(GGML_LOCATION ggml)
message (STATUS "Found GGML library: ${GGML_LOCATION}") 
add_library(ggml SHARED IMPORTED GLOBAL)
set_target_properties(ggml PROPERTIES IMPORTED_LOCATION ${GGML_LOCATION})

# quite a few examples require direct reference to ggml-cpu
# search for oldest one
find_library(GGML_CPU_LOCATION ggml-cpu-sandybridge)
find_library(GGML_RPC_LOCATION ggml-rpc)

# make sure all libraries are available since we cannot refine per target
link_libraries(${GGML_LOCATION} ${GGML_BASE_LOCATION} ${GGML_CPU_LOCATION} ${GGML_RPC_LOCATION})

#add_compile_definitions(NDEBUG)

install(DIRECTORY ${CMAKE_BINARY_DIR}/common/ DESTINATION lib/${CMAKE_LIBRARY_ARCHITECTURE}/llama.cpp/common FILES_MATCHING PATTERN "*.a" )
install(DIRECTORY ${CMAKE_SOURCE_DIR}/common/ DESTINATION include/llama.cpp/common FILES_MATCHING PATTERN "*.h" )

