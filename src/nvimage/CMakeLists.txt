PROJECT(nvimage)

SET(IMAGE_SRCS
    nvimage.h
    BlockDXT.h BlockDXT.cpp
    ColorBlock.h ColorBlock.cpp
    DirectDrawSurface.h DirectDrawSurface.cpp
    ErrorMetric.h ErrorMetric.cpp
    Filter.h Filter.cpp
    FloatImage.h FloatImage.cpp
    Image.h Image.cpp
    ImageIO.h ImageIO.cpp
    #KtxFile.h KtxFile.cpp
    NormalMap.h NormalMap.cpp
    PixelFormat.h
    PsdFile.h
    TgaFile.h)

set(INCS ${CMAKE_CURRENT_SOURCE_DIR})

IF(PNG_FOUND)
    list(APPEND LIBS ${PNG_LIBRARIES})
    list(APPEND INCS ${PNG_INCLUDE_DIR})
ENDIF(PNG_FOUND)

IF(JPEG_FOUND)
    list(APPEND LIBS ${JPEG_LIBRARIES})
    list(APPEND INCS ${JPEG_INCLUDE_DIR})
ENDIF(JPEG_FOUND)

IF(TIFF_FOUND)
    list(APPEND LIBS ${TIFF_LIBRARIES})
    list(APPEND INCS ${TIFF_INCLUDE_DIR})
ENDIF(TIFF_FOUND)

IF(OPENEXR_FOUND)
    list(APPEND LIBS ${OPENEXR_LIBRARIES})
    list(APPEND INCS ${OPENEXR_INCLUDE_PATHS})
ENDIF(OPENEXR_FOUND)

IF(FREEIMAGE_FOUND)
    list(APPEND LIBS ${FREEIMAGE_LIBRARIES})
    list(APPEND INCS ${FREEIMAGE_INCLUDE_PATH})
ENDIF(FREEIMAGE_FOUND)

# targets
IF(NVIMAGE_SHARED)
    set(NVIMAGE_SHARED SHARED)
    set(defs -DNVIMAGE_SHARED=1)
ELSE(NVIMAGE_SHARED)
    unset(NVIMAGE_SHARED)
ENDIF(NVIMAGE_SHARED)

nv_add_target(nvimage LIBRARY ${NVIMAGE_SHARED}
    SRCS ${IMAGE_SRCS}
    DEFS ${defs}
    DEFS_PRIVATE -DNVIMAGE_EXPORTS
    INC_DIRS include/nvimage
    INC_DIRS_BUILD ${CMAKE_CURRENT_SOURCE_DIR}
    LIBS ${LIBS} nvcore posh bc6h bc7 nvmath
    EXPORT nvttConfig
    )

install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/nvimage
    FILES_MATCHING PATTERN "*.h")
