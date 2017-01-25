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

# targets
ADD_DEFINITIONS(-DNVCORE_EXPORTS)

IF(NVCORE_SHARED)
    ADD_LIBRARY(nvcore SHARED ${CORE_SRCS})
    target_compile_definitions(nvcore PUBLIC -DNVCORE_SHARED=1)
ELSE(NVCORE_SHARED)
    ADD_LIBRARY(nvcore ${CORE_SRCS})
ENDIF(NVCORE_SHARED)

IF(UNIX)
    list(APPEND LIBS ${CMAKE_DL_LIBS})
ENDIF(UNIX)
# On NetBSD backtrace() is provided by libexecinfo, not libc.
if (CMAKE_SYSTEM_NAME MATCHES "NetBSD")
    list(APPEND LIBS execinfo)
endif()

TARGET_LINK_LIBRARIES(nvcore ${LIBS})

target_include_directories(nvcore
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include/nvcore>)

INSTALL(TARGETS nvcore
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib/static)
install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/nvcore
    FILES_MATCHING PATTERN "*.h")
