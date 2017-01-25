PROJECT(nvthread)

SET(THREAD_SRCS
	nvthread.h nvthread.cpp
	Atomic.h
	Event.h Event.cpp
	Mutex.h Mutex.cpp
	ParallelFor.h ParallelFor.cpp
	Thread.h Thread.cpp
	ThreadPool.h ThreadPool.cpp)

# targets
ADD_DEFINITIONS(-DNVTHREAD_EXPORTS)

IF(NVTHREAD_SHARED)
    ADD_LIBRARY(nvthread SHARED ${THREAD_SRCS})
    target_compile_definitions(nvthread PUBLIC -DNVTHREAD_SHARED=1)
ELSE(NVTHREAD_SHARED)
    ADD_LIBRARY(nvthread ${THREAD_SRCS})
ENDIF(NVTHREAD_SHARED)

TARGET_LINK_LIBRARIES(nvthread ${LIBS} nvcore)

target_include_directories(nvcore
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include/nvthread>)

INSTALL(TARGETS nvthread
	RUNTIME DESTINATION bin
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib/static)
install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/nvthread
    FILES_MATCHING PATTERN "*.h")
