PROJECT(bc7)

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})

SET(BC7_SRCS
	avpcl.cpp
	avpcl.h
	avpcl_mode0.cpp
	avpcl_mode1.cpp
	avpcl_mode2.cpp
	avpcl_mode3.cpp
	avpcl_mode4.cpp
	avpcl_mode5.cpp
	avpcl_mode6.cpp
	avpcl_mode7.cpp
	bits.h
	endpts.h
	shapes_three.h
	shapes_two.h
	tile.h
	avpcl_utils.cpp
	avpcl_utils.h)

nv_add_target(bc7 LIBRARY
    SRCS ${BC7_SRCS}
    INC_DIRS include/bc7
    INC_DIRS_BUILD ${CMAKE_CURRENT_SOURCE_DIR}
    EXPORT nvttConfig
    )

IF(NOT WIN32)
    IF(CMAKE_COMPILER_IS_GNUCXX)
        SET_TARGET_PROPERTIES(bc7 PROPERTIES COMPILE_FLAGS -fPIC)
    ENDIF(CMAKE_COMPILER_IS_GNUCXX)
ENDIF(NOT WIN32)

install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/bc7
    FILES_MATCHING PATTERN "*.h")
