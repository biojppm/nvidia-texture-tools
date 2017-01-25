
#find_file(STB_DXT_H stb_dxt.h REQUIRED PATH_SUFFIXES stb)
#find_file(STB_IMAGE_H stb_image.h REQUIRED PATH_SUFFIXES stb)
#get_filename_component(STB_INCLUDE_DIR ${STB_DXT_H} DIRECTORY)
#message(STATUS "Found stb: ${STB_INCLUDE_DIR}")

#find_file(POSH_H posh.h REQUIRED)
#get_filename_component(POSH_INCLUDE_DIR ${POSH_H} DIRECTORY)
#message(STATUS "Found posh: ${POSH_INCLUDE_DIR}")

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})
#include_directories(${STB_INCLUDE_DIR})
#include_directories(${POSH_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${NV_SOURCE_DIR}/extern/poshlib)
INCLUDE_DIRECTORIES(${NV_SOURCE_DIR}/extern/stb)

list(APPEND CMAKE_MODULE_PATH ${NV_CMAKE_DIR})
#list(APPEND CMAKE_INCLUDE_PATH ${NV_CMAKE_DIR})

ADD_SUBDIRECTORY(nvcore)
ADD_SUBDIRECTORY(nvmath)
ADD_SUBDIRECTORY(nvimage)
ADD_SUBDIRECTORY(nvthread)
ADD_SUBDIRECTORY(nvtt)
ADD_SUBDIRECTORY(bc6h)
ADD_SUBDIRECTORY(bc7)

# OpenGL
find_package(OpenGL)
IF(OPENGL_FOUND)
        MESSAGE(STATUS "Looking for OpenGL - found")
ELSE(OPENGL_FOUND)
        MESSAGE(STATUS "Looking for OpenGL - not found")
ENDIF(OPENGL_FOUND)

# GLUT
find_package(GLUT)
IF(GLUT_FOUND)
        MESSAGE(STATUS "Looking for GLUT - found")
ELSE(GLUT_FOUND)
        MESSAGE(STATUS "Looking for GLUT - not found")
ENDIF(GLUT_FOUND)

# DirectX
find_package(DirectX)
IF(DX10_FOUND)
        MESSAGE(STATUS "Looking for DirectX - found")
ELSE(DX10_FOUND)
        MESSAGE(STATUS "Looking for DirectX - not found")
ENDIF(DX10_FOUND)

# GLEW
find_package(GLEW)
IF(GLEW_FOUND)
        MESSAGE(STATUS "Looking for GLEW - found")
ELSE(GLEW_FOUND)
        MESSAGE(STATUS "Looking for GLEW - not found")
ENDIF(GLEW_FOUND)

# Cg
find_package(Cg)
IF(CG_FOUND)
        MESSAGE(STATUS "Looking for Cg - found")
ELSE(CG_FOUND)
        MESSAGE(STATUS "Looking for Cg - not found")
ENDIF(CG_FOUND)

# CUDA
find_package(CUDA)
IF(CUDA_FOUND)
    IF(MINGW)
        MESSAGE(STATUS "Looking for CUDA - not supported on MinGW")
        UNSET(CUDA_FOUND)
    ENDIF(MINGW)
    IF(CUDA_FOUND)
        SET(HAVE_CUDA ${CUDA_FOUND} CACHE BOOL "Set to TRUE if CUDA is found, FALSE otherwise")
        MESSAGE(STATUS "Looking for CUDA - found")
    ENDIF(CUDA_FOUND)
ELSE(CUDA_FOUND)
    MESSAGE(STATUS "Looking for CUDA - not found")
ENDIF(CUDA_FOUND)

# Maya
find_package(Maya)
IF(MAYA_FOUND)
        SET(HAVE_MAYA ${MAYA_FOUND} CACHE BOOL "Set to TRUE if Maya is found, FALSE otherwise")
        MESSAGE(STATUS "Looking for Maya - found")
ELSE(MAYA_FOUND)
        MESSAGE(STATUS "Looking for Maya - not found")
ENDIF(MAYA_FOUND)

# FreeImage
find_package(FreeImage)
IF(FREEIMAGE_FOUND)
        SET(HAVE_FREEIMAGE ${FREEIMAGE_FOUND} CACHE BOOL "Set to TRUE if FreeImage is found, FALSE otherwise")
        MESSAGE(STATUS "Looking for FreeImage - found")
ELSE(FREEIMAGE_FOUND)
        MESSAGE(STATUS "Looking for FreeImage - not found")
ENDIF(FREEIMAGE_FOUND)

# JPEG
find_package(JPEG REQUIRED)
IF(JPEG_FOUND)
        SET(HAVE_JPEG ${JPEG_FOUND} CACHE BOOL "Set to TRUE if JPEG is found, FALSE otherwise")
        MESSAGE(STATUS "Looking for JPEG - found  ${JPEG_LIBRARIES}")
ELSE(JPEG_FOUND)
        MESSAGE(FATAL_ERROR "Looking for JPEG - not found")
ENDIF(JPEG_FOUND)

# PNG
find_package(PNG REQUIRED)
IF(PNG_FOUND)
        SET(HAVE_PNG ${PNG_FOUND} CACHE BOOL "Set to TRUE if PNG is found, FALSE otherwise")
        MESSAGE(STATUS "Looking for PNG - found ${PNG_LIBRARIES}")
ELSE(PNG_FOUND)
        MESSAGE(FATAL_ERROR "Looking for PNG - not found")
ENDIF(PNG_FOUND)

# TIFF
SET(TIFF_NAMES libtiff)
find_package(TIFF REQUIRED)
IF(TIFF_FOUND)
        SET(HAVE_TIFF ${TIFF_FOUND} CACHE BOOL "Set to TRUE if TIFF is found, FALSE otherwise")
        MESSAGE(STATUS "Looking for TIFF - found ${TIFF_LIBRARIES}")
ELSE(TIFF_FOUND)
        MESSAGE(FATAL_ERROR "Looking for TIFF - not found")
ENDIF(TIFF_FOUND)

# OpenEXR
find_package(OpenEXR REQUIRED)
IF(OPENEXR_FOUND)
        SET(HAVE_OPENEXR ${OPENEXR_FOUND} CACHE BOOL "Set to TRUE if OpenEXR is found, FALSE otherwise")
        MESSAGE(STATUS "Looking for OpenEXR - found ${OPENEXR_LIBRARIES}")
ELSE(OPENEXR_FOUND)
        MESSAGE(FATAL_ERROR "Looking for OpenEXR - not found")
ENDIF(OPENEXR_FOUND)

# OpenMP
INCLUDE(FindOpenMP)
IF(OPENMP_FOUND)
	SET(HAVE_OPENMP ${OPENMP_FOUND} CACHE BOOL "Set to TRUE if OpenMP is found, FALSE otherwise")
	MESSAGE(STATUS "Looking for OpenMP - found")
	SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
ELSE(OPENMP_FOUND)
	MESSAGE(STATUS "Looking for OpenMP - not found")
ENDIF(OPENMP_FOUND)

# Threads
FIND_PACKAGE(Threads REQUIRED)
MESSAGE(STATUS "Use thread library: ${CMAKE_THREAD_LIBS_INIT}")
SET(LIBS ${LIBS} ${CMAKE_THREAD_LIBS_INIT})

# configuration file
INCLUDE(CheckIncludeFiles)

CHECK_INCLUDE_FILES("unistd.h" HAVE_UNISTD_H)
CHECK_INCLUDE_FILES("stdarg.h" HAVE_STDARG_H)
CHECK_INCLUDE_FILES("signal.h" HAVE_SIGNAL_H)
CHECK_INCLUDE_FILES("execinfo.h" HAVE_EXECINFO_H)
CHECK_INCLUDE_FILES("malloc.h" HAVE_MALLOC_H)
CHECK_INCLUDE_FILES("dispatch/dispatch.h" HAVE_DISPATCH_H)

CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/nvconfig.h.in ${CMAKE_CURRENT_BINARY_DIR}/nvconfig.h)

INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/nvconfig.h DESTINATION include)
