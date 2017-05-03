PROJECT(nvcore)

SET(CORE_SRCS
    nvcore.h
    Array.h
    Debug.h Debug.cpp
    DefsGnucDarwin.h
    DefsGnucLinux.h
    DefsGnucWin32.h
    DefsVcWin32.h
    FileSystem.h FileSystem.cpp
    ForEach.h
    Memory.h Memory.cpp
    Ptr.h
    RefCounted.h
    StrLib.h StrLib.cpp
    Stream.h
    StdStream.h
    TextWriter.h TextWriter.cpp
    Timer.h Timer.cpp
    Utils.h)

IF(UNIX)
    list(APPEND LIBS ${CMAKE_DL_LIBS})
ENDIF(UNIX)
# On NetBSD backtrace() is provided by libexecinfo, not libc.
if (CMAKE_SYSTEM_NAME MATCHES "NetBSD")
    list(APPEND LIBS execinfo)
endif()

# targets
IF(NVCORE_SHARED)
    set(NVCORE_SHARED SHARED)
    set(defs -DNVCORE_SHARED=1)
ELSE(NVCORE_SHARED)
    unset(NVCORE_SHARED)
ENDIF(NVCORE_SHARED)

nv_add_target(nvcore LIBRARY ${NVCORE_SHARED}
    SRCS ${CORE_SRCS}
    DEFS ${defs}
    DEFS_PRIVATE -DNVCORE_EXPORTS
    INC_DIRS include/nvcore
    INC_DIRS_BUILD ${CMAKE_CURRENT_SOURCE_DIR}
    LIBS ${LIBS}
    EXPORT nvttConfig
    )

install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/nvcore
    FILES_MATCHING PATTERN "*.h")
