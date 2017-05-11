PROJECT(nvthread)

SET(THREAD_SRCS
	nvthread.h nvthread.cpp
	Atomic.h
	Event.h Event.cpp
	Mutex.h Mutex.cpp
	ParallelFor.h ParallelFor.cpp
	Thread.h Thread.cpp
	ThreadPool.h ThreadPool.cpp)

# http://stackoverflow.com/questions/1620918/cmake-and-libpthread
find_package(Threads REQUIRED)
set(THREADS_PREFER_PTHREAD_FLAG ON)
list(APPEND LIBS Threads::Threads)

# targets
IF(NVTHREAD_SHARED)
    set(NVTHREAD_SHARED SHARED)
    set(defs -DNVTHREAD_SHARED=1)
ELSE(NVTHREAD_SHARED)
    unset(NVTHREAD_SHARED)
ENDIF(NVTHREAD_SHARED)

nv_add_target(nvthread LIBRARY ${NVTHREAD_SHARED}
    SRCS ${THREAD_SRCS}
    DEFS ${defs}
    DEFS_PRIVATE -DNVTHREAD_EXPORTS
    INC_DIRS include/nvthread
    INC_DIRS_BUILD ${CMAKE_CURRENT_SOURCE_DIR}
    LIBS ${LIBS} nvcore
    EXPORT nvttConfig
    )

install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/nvthread
    FILES_MATCHING PATTERN "*.h")
