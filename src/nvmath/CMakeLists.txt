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
IF(NVMATH_SHARED)
    set(NVMATH_SHARED SHARED)
    set(defs -DNVMATH_SHARED=1)
ELSE(NVMATH_SHARED)
    unset(NVMATH_SHARED)
ENDIF(NVMATH_SHARED)

nv_add_target(nvmath LIBRARY ${NVIMAGE_SHARED}
    SRCS ${MATH_SRCS}
    DEFS ${defs}
    DEFS_PRIVATE -DNVMATH_EXPORTS
    INC_DIRS include/nvmath
    INC_DIRS_BUILD ${CMAKE_CURRENT_SOURCE_DIR}
    LIBS ${LIBS} nvcore
    EXPORT nvttConfig
    )

install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/nvthread
    FILES_MATCHING PATTERN "*.h")
