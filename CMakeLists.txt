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
    CACHE STRING "Minor part for Boost version. Use 59, or 61 to 67")
set(BOOST_VPATCH 0
    CACHE STRING "Patch part for Boost verison. Normally 0")

set(boost-ver ${BOOST_VMAJOR}.${BOOST_VMINOR}.${BOOST_VPATCH})
set(boost-dir boost/${BOOST_VMAJOR}_${BOOST_VMINOR}_${BOOST_VPATCH}/${toolset}/${build})

add_library(boost INTERFACE)
target_include_directories(boost INTERFACE ${boost-dir}/include/)

function(boostlib name)
    add_library(boost_${name} SHARED IMPORTED GLOBAL)
    set(so ${CMAKE_CURRENT_SOURCE_DIR}/${boost-dir}/lib/libboost_${name}.so)
    set_property(TARGET boost_${name}
        PROPERTY IMPORTED_LOCATION ${so})
    install(FILES ${so} ${so}.${boost-ver} DESTINATION lib)
endfunction()

boostlib(date_time)
boostlib(filesystem)
boostlib(system)

set(toolset ${toolset} PARENT_SCOPE)
