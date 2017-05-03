PROJECT(bc6h)

SET(BC6H_SRCS
	bits.h
	shapes_two.h
	tile.h
	zoh_utils.cpp
	zoh_utils.h
	zoh.cpp
	zoh.h
	zohone.cpp
	zohtwo.cpp)

nv_add_target(bc6h LIBRARY
    SRCS ${BC6H_SRCS}
    INC_DIRS include/bc6h
    INC_DIRS_BUILD ${CMAKE_CURRENT_SOURCE_DIR}
    EXPORT nvttConfig
    )

IF(NOT WIN32)
    IF(CMAKE_COMPILER_IS_GNUCXX)
        SET_TARGET_PROPERTIES(bc6h PROPERTIES COMPILE_FLAGS -fPIC)
    ENDIF(CMAKE_COMPILER_IS_GNUCXX)
ENDIF(NOT WIN32)

install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/bc6h
    FILES_MATCHING PATTERN "*.h")
