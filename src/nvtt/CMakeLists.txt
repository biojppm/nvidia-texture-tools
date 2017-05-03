PROJECT(nvtt)

set(defs)

add_subdirectory(squish)

SET(NVTT_SRCS
    nvtt.h nvtt.cpp
    nvtt_wrapper.h nvtt_wrapper.cpp
    ClusterFit.h ClusterFit.cpp
    Compressor.h
    BlockCompressor.h BlockCompressor.cpp
    CompressorDX9.h CompressorDX9.cpp
    CompressorDX10.h CompressorDX10.cpp
    CompressorDX11.h CompressorDX11.cpp
    CompressorDXT1.h CompressorDXT1.cpp
    CompressorDXT5_RGBM.h CompressorDXT5_RGBM.cpp
    CompressorRGB.h CompressorRGB.cpp
    Context.h Context.cpp
    QuickCompressDXT.h QuickCompressDXT.cpp
    OptimalCompressDXT.h OptimalCompressDXT.cpp
    SingleColorLookup.h SingleColorLookup.cpp
    CompressionOptions.h CompressionOptions.cpp
    InputOptions.h InputOptions.cpp
    OutputOptions.h OutputOptions.cpp
    TaskDispatcher.h TaskDispatcher.cpp
    Surface.h Surface.cpp
    CubeSurface.h CubeSurface.cpp
    cuda/CudaUtils.h cuda/CudaUtils.cpp
    cuda/CudaMath.h
    cuda/BitmapTable.h
    cuda/CudaCompressorDXT.h cuda/CudaCompressorDXT.cpp)

IF (CUDA_FOUND)
    list(APPEND defs -DHAVE_CUDA)
    cuda_compile(CUDA_SRCS cuda/CompressKernel.cu)
    list(APPEND NVTT_SRCS ${CUDA_SRCS})
    list(APPEND LIBS ${CUDA_LIBRARIES})
    list(APPEND INCS ${CUDA_INCLUDE_DIRS})
ENDIF (CUDA_FOUND)

list(APPEND INCS ${CMAKE_CURRENT_SOURCE_DIR})

# targets
IF(NVTT_SHARED)
    set(NVTT_SHARED SHARED)
    set(defs -DNVTT_SHARED=1)
ELSE(NVTT_SHARED)
    unset(NVTT_SHARED)
ENDIF(NVTT_SHARED)

nv_add_target(nvtt LIBRARY ${NVTT_SHARED}
    SRCS ${NVTT_SRCS}
    DEFS ${defs}
    DEFS_PRIVATE -DNVTT_EXPORTS
    INC_DIRS include/nvtt
    INC_DIRS_BUILD ${CMAKE_CURRENT_SOURCE_DIR}
    LIBS ${LIBS} nvcore nvimage nvthread squish bc6h bc7 nvmath
    EXPORT nvttConfig
    )

install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/nvtt
    FILES_MATCHING PATTERN "*.h")

ADD_SUBDIRECTORY(tools)
if(BUILD_TESTS)
    ADD_SUBDIRECTORY(tests)
endif()
