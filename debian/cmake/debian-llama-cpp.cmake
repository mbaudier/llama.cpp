# GGML dependencies
# libggml-base as external library
find_library(GGML_BASE_LOCATION ggml-base)
message (STATUS "Found GGML base library: ${GGML_BASE_LOCATION}") 
add_library(ggml-base SHARED IMPORTED GLOBAL)
set_target_properties(ggml-base PROPERTIES IMPORTED_LOCATION ${GGML_BASE_LOCATION})

# libggml as external library
# defines GGML as target so that it is disabled in llama.cpp build
find_library(GGML_LOCATION ggml)
message (STATUS "Found GGML library: ${GGML_LOCATION}") 
add_library(ggml SHARED IMPORTED GLOBAL)
set_target_properties(ggml PROPERTIES IMPORTED_LOCATION ${GGML_LOCATION})
# transitive dependency
target_link_libraries(ggml INTERFACE ${GGML_BASE_LOCATION})

add_compile_definitions(NDEBUG)

install(DIRECTORY ${CMAKE_BINARY_DIR}/common/ DESTINATION lib/${CMAKE_LIBRARY_ARCHITECTURE}/llama.cpp/common FILES_MATCHING PATTERN "*.a" )
install(DIRECTORY ${CMAKE_SOURCE_DIR}/common/ DESTINATION include/llama.cpp/common FILES_MATCHING PATTERN "*.h" )

# build number, in line with changelog
set(BUILD_NUMBER 5318)

