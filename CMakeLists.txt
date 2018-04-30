if(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
    set(toolset "gcc")
elseif(${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
    set(toolset "clang")
else()
    message(SEND_ERROR "Unknown compiler ID: ${CMAKE_CXX_COMPILER_ID}")
endif()

if(${CMAKE_BUILD_TYPE} STREQUAL "Debug")
    set(build "debug")
else()
    set(build "release")
endif()

set(boost-folder boost/1_66_0/${toolset}/${build})

add_library(boost INTERFACE)
target_include_directories(boost INTERFACE ${boost-folder}/include/)

function(boostlib name)
    add_library(boost_${name} SHARED IMPORTED GLOBAL)
    set(so ${CMAKE_CURRENT_SOURCE_DIR}/${boost-folder}/lib/libboost_${name}.so)
    set_property(TARGET boost_${name}
        PROPERTY IMPORTED_LOCATION ${so})
    install(FILES ${so} ${so}.1.66.0 DESTINATION lib)
endfunction()

boostlib(date_time)
boostlib(filesystem)
boostlib(system)

set(toolset ${toolset} PARENT_SCOPE)
