PROJECT(nvmath)

SET(MATH_SRCS
    nvmath.h
    Box.h Box.inl
    Color.h Color.inl
    Fitting.h Fitting.cpp
    Half.h Half.cpp
    Matrix.h
    Plane.h Plane.inl Plane.cpp
    SphericalHarmonic.h SphericalHarmonic.cpp
    SimdVector.h SimdVector_SSE.h SimdVector_VE.h
    Vector.h Vector.inl)

# targets
ADD_DEFINITIONS(-DNVMATH_EXPORTS)

IF(NVMATH_SHARED)
    ADD_LIBRARY(nvmath SHARED ${MATH_SRCS})
    target_compile_definitions(nvmath PUBLIC -DNVCORE_SHARED=1)
ELSE(NVMATH_SHARED)
    ADD_LIBRARY(nvmath ${MATH_SRCS})
ENDIF(NVMATH_SHARED)

TARGET_LINK_LIBRARIES(nvmath ${LIBS} nvcore)

target_include_directories(nvcore
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include/nvmath>)

INSTALL(TARGETS nvmath
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib/static)
install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/nvthread
    FILES_MATCHING PATTERN "*.h")
