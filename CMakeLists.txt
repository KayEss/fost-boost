cmake_minimum_required(VERSION 3.6)
project(fost-boost)

find_package(Boost 1.62.0)

if(Boost_FOUND AND NOT BOOST_VMINOR)
    add_library(boost INTERFACE)
    target_include_directories(boost INTERFACE ${$Boost_INCLUDE_DIRS})
    function(boostlib name)
        if(NOT TARGET boost_${name})
            message(STATUS "Searching system for boost_${name}")
            find_package(Boost 1.62.0 COMPONENTS ${name})
            add_library(boost_${name} SHARED IMPORTED GLOBAL)
            set(so ${Boost_LIBRARY_DIRS}/libboost_${name}.so)
            set_property(TARGET boost_${name}
                PROPERTY IMPORTED_LOCATION ${so})
        endif()
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
        CACHE STRING "Minor part for Boost version. Use 62 and up")
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
        execute_process(COMMAND ./download ${BOOST_VMAJOR} ${BOOST_VMINOR} ${BOOST_VPATCH}
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
        execute_process(COMMAND ./bootstrap ${BOOST_VMAJOR} ${BOOST_VMINOR} ${BOOST_VPATCH}
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
        execute_process(COMMAND ./compile ${BOOST_VMAJOR} ${BOOST_VMINOR} ${BOOST_VPATCH} ${toolset} ${build}
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
    else()
        message(STATUS "Locally built Boost already found in " ${boost-dir})
    endif()

    add_library(boost INTERFACE)
    target_include_directories(boost INTERFACE ${boost-dir}/include/)
    target_compile_definitions(boost INTERFACE BOOST_NO_AUTO_PTR=1)

    set(boost-cmake-dir ${CMAKE_CURRENT_SOURCE_DIR})

    function(boostlib name)
        if(NOT TARGET boost_${name})
            add_library(boost_${name} SHARED IMPORTED GLOBAL)
            target_link_libraries(boost_${name} INTERFACE boost)
            set(so ${boost-cmake-dir}/${boost-dir}/lib/libboost_${name}.${so-ext})
            set_property(TARGET boost_${name}
                PROPERTY IMPORTED_LOCATION ${so})
            install(FILES ${so} DESTINATION lib)
            if(NOT APPLE)
                install(FILES ${so}.${boost-ver} DESTINATION lib)
            endif()
        endif()
    endfunction()
endif()

boostlib(atomic)
boostlib(chrono)
boostlib(context)
boostlib(coroutine)
boostlib(date_time)
boostlib(filesystem)
boostlib(system)
boostlib(thread)

