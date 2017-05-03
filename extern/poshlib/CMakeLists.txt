
SET(POSHLIB_SRCS
	posh.c
	posh.h)

nv_add_target(posh LIBRARY
    SRCS ${POSHLIB_SRCS}
    INC_DIRS include
    INC_DIRS_BUILD ${CMAKE_CURRENT_SOURCE_DIR}
    EXPORT nvttConfig
    )
install(FILES posh.h DESTINATION include)
