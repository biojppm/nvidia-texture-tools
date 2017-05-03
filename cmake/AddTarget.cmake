include(CMakeParseArguments)

macro(nv_add_target target_name)

    set(options0arg
        EXECUTABLE
        LIBRARY
        SHARED
        NO_INSTALL
    )
    set(options1arg
        EXPORT
        RUNTIME_DEST
        LIBRARY_DEST
        ARCHIVE_DEST
        INCLUDES_DEST
    )
    set(optionsnarg
        SRCS
        DEFS
        DEFS_PRIVATE
        FLAGS
        FLAGS_PRIVATE
        INC_DIRS               # install interface
        INC_DIRS_PRIVATE       # install interface
        INC_DIRS_BUILD         # build interface
        INC_DIRS_BUILD_PRIVATE # build interface
        #LIB_DIRS
        #LIB_DIRS_PRIVATE
        DEPS         # to specify modules that this module depends on
        DEPS_PRIVATE # to specify modules that this module depends on
        LIBS
        LIBS_PRIVATE
        DLLS
        DLLS_PRIVATE
    )

    cmake_parse_arguments(_nvat "${options0arg}" "${options1arg}" "${optionsnarg}" ${ARGN})

    if(_nvat_EXECUTABLE)
        add_executable(${target_name} ${_nvat_SRCS})
    else()
        if(NOT _nvat_LIBRARY)
            message(FATAL_ERROR "${target_name}: must be either executable or library")
        endif()
        if(_nvat_SHARED)
            add_library(${target_name} SHARED ${_nvat_SRCS})
        else()
            add_library(${target_name} ${_nvat_SRCS})
        endif()
    endif()

    target_compile_definitions(${target_name}
        PUBLIC  ${_nvat_DEFS}
        PRIVATE ${_nvat_DEFS_PRIVATE})

    target_compile_options(${target_name}
        PUBLIC  ${_nvat_FLAGS}
        PRIVATE ${_nvat_FLAGS_PRIVATE})

    target_include_directories(${target_name}
        PUBLIC  $<BUILD_INTERFACE:${_nvat_INC_DIRS_BUILD}>
                $<INSTALL_INTERFACE:${_nvat_INC_DIRS}>
        PRIVATE $<BUILD_INTERFACE:${_nvat_INC_DIRS_BUILD_PRIVATE}>
                $<INSTALL_INTERFACE:${_nvat_INC_DIRS_PRIVATE}>)

    target_link_libraries(${target_name}
        PUBLIC  ${_nvat_DEPS}
                ${_nvat_LIBS}
                ${_nvat_DLLS}
        PRIVATE ${_nvat_DEPS_PRIVATE}
                ${_nvat_LIBS_PRIVATE}
                ${_nvat_DLLS_PRIVATE})

    if(NOT ${_nvat_NO_INSTALL})
        if(_nvat_EXPORT)
            set(_nvat_export_dest EXPORT ${_nvat_EXPORT})
        endif()

        if(NOT _nvat_RUNTIME_DEST)
            set(_nvat_RUNTIME_DEST bin)
        endif()

        if(NOT _nvat_LIBRARY_DEST)
            set(_nvat_LIBRARY_DEST lib)
        endif()

        if(NOT _nvat_ARCHIVE_DEST)
            if(WIN32)
                set(_nvat_ARCHIVE_DEST lib/static)
            else()
                set(_nvat_ARCHIVE_DEST lib)
            endif()
        endif()

        if(NOT _nvat_INCLUDES_DEST)
            set(_nvat_INCLUDES_DEST lib)
        endif()

        install(TARGETS ${target_name}
            ${_nvat_export_dest}
            RUNTIME DESTINATION ${_nvat_RUNTIME_DEST}
            LIBRARY DESTINATION ${_nvat_LIBRARY_DEST}
            ARCHIVE DESTINATION ${_nvat_ARCHIVE_DEST}
            INCLUDES DESTINATION ${_nvat_INCLUDES_DEST})
    endif(NOT ${_nvat_NO_INSTALL})

endmacro(nv_add_target)
