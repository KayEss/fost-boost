find_package(Boost 1.62.0)

if(Boost_FOUND AND NOT BOOST_VMINOR)
    add_library(boost INTERFACE)
    target_include_directories(boost INTERFACE ${$Boost_INCLUDE_DIRS})
    function(boostlib name)
        find_package(Boost 1.62.0 COMPONENTS ${name})
        add_library(boost_${name} SHARED IMPORTED GLOBAL)
        set(so ${Boost_LIBRARY_DIRS}/libboost_${name}.so)
        set_property(TARGET boost_${name}
            PROPERTY IMPORTED_LOCATION ${so})
    endfunction()
else()
    if(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
        set(toolset "gcc")
    elseif(${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
        set(toolset "clang")
    else()
        message(SEND_ERROR "Unknown compiler ID: ${CMAKE_CXX_COMPILER_ID}")
    endif()

    if("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
        set(build "release")
    else()
        set(build "debug")
    endif()

    set(BOOST_VMAJOR 1
        CACHE STRING "Major part for Boost version. Always 1")
    set(BOOST_VMINOR 66
        CACHE STRING "Minor part for Boost version. Use 62 to 67")
    set(BOOST_VPATCH 0
        CACHE STRING "Patch part for Boost version. Normally 0")

    if(APPLE)
        set(so-ext dylib)
    else()
        set(so-ext so)
    endif()

    set(boost-ver ${BOOST_VMAJOR}.${BOOST_VMINOR}.${BOOST_VPATCH})
    set(boost-dir boost/${BOOST_VMAJOR}_${BOOST_VMINOR}_${BOOST_VPATCH}/${toolset}/${build})

    if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${boost-dir}/include)
        message(STATUS "Building boost to get " ${boost-dir}/include)
        execute_process(COMMAND ./build ${BOOST_VMINOR} ${BOOST_VPATCH}
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            RESULT_VARIABLE boost_build_status)
    else()
        message(STATUS "Boost already found in " ${boost-dir}/include)
    endif()

    add_library(boost INTERFACE)
    target_include_directories(boost INTERFACE ${boost-dir}/include/)

    function(boostlib name)
        add_library(boost_${name} SHARED IMPORTED GLOBAL)
        set(so ${CMAKE_CURRENT_SOURCE_DIR}/${boost-dir}/lib/libboost_${name}.${so-ext})
        set_property(TARGET boost_${name}
            PROPERTY IMPORTED_LOCATION ${so})
        install(FILES ${so} DESTINATION lib)
        if(NOT APPLE)
            install(FILES ${so}.${boost-ver} DESTINATION lib)
        endif()
    endfunction()

    set(toolset ${toolset} PARENT_SCOPE)
endif()

boostlib(coroutine)
boostlib(date_time)
boostlib(filesystem)
boostlib(system)

