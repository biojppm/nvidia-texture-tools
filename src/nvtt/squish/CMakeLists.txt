PROJECT(squish)

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})

SET(SQUISH_SRCS
	fastclusterfit.cpp
	fastclusterfit.h
	weightedclusterfit.cpp
	weightedclusterfit.h
	colourblock.cpp
	colourblock.h
	colourfit.cpp
	colourfit.h
	colourset.cpp
	colourset.h
	config.h
	maths.cpp
	maths.h
	simd.h
	simd_sse.h
	simd_ve.h)

nv_add_target(squish LIBRARY ${NVSQUISH_SHARED}
    SRCS ${SQUISH_SRCS}
    INC_DIRS include/squish
    INC_DIRS_BUILD ${CMAKE_CURRENT_SOURCE_DIR}
    EXPORT nvttConfig
    )

IF(NOT WIN32)
    IF("${CMAKE_CXX_COMPILER}" MATCHES "clang(\\+\\+)?$" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
	SET(CMAKE_COMPILER_IS_CLANGXX 1)
    ENDIF()
    IF(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_COMPILER_IS_CLANGXX)
	SET_TARGET_PROPERTIES(squish PROPERTIES COMPILE_FLAGS -fPIC)
    ENDIF(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_COMPILER_IS_CLANGXX)
ENDIF(NOT WIN32)

install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/squish
    FILES_MATCHING PATTERN "*.h")
