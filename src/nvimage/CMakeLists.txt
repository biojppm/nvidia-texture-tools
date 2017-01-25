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
ADD_DEFINITIONS(-DNVIMAGE_EXPORTS)

IF(NVIMAGE_SHARED)
    ADD_LIBRARY(nvimage SHARED ${IMAGE_SRCS})
    target_compile_definitions(nvimage PUBLIC -DNVIMAGE_SHARED=1)
ELSE(NVIMAGE_SHARED)
    ADD_LIBRARY(nvimage ${IMAGE_SRCS})
ENDIF(NVIMAGE_SHARED)

TARGET_LINK_LIBRARIES(nvimage ${LIBS} nvcore posh bc6h bc7 nvmath)

target_include_directories(nvimage
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include/nvimage>
    ${INCS})

INSTALL(TARGETS nvimage
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib/static)
install(DIRECTORY . #${CMAKE_CURRENT_SOURCE_DIRECTORY}
    DESTINATION include/nvimage
    FILES_MATCHING PATTERN "*.h")
