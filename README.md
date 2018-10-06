# Boost for CMake

This repository contains a simple way to make use of Boost in your CMake C++ projects. To use it simply add it as a sub-module and then use `add_subdirectory`.

    add_subdirectory(fost-boost)

The build (if needed) is done during CMake configuration so it does not impact builds of your project.


## Configuration

It will use CMake's `find_package` to try to find a suitable version of Boost, which must be at least 1.62.0. If none is found then it will download the official distribution and build the configuration that you are using (clang or gcc, release or debug) using the Boost build system. Currently it defaults to Boost 1.66.0.

You can also specify a Boost version to use by setting:

* `BOOST_VMAJOR` (defaults to `1`).
* `BOOST_VMINOR` (defaults to `66`).
* `BOOST_VPATCH` (defaults to `0`).

You can force it to download and build a Boost version even if you have a pre-packaged one by setting a value for `BOOST_VMINOR` during your cmake configuration run.


### Boost build configuration

See the file (`compile`)[./compile] for the `bjam` invocation. The following environment variables are used:

* `CXXSTD` -- Defaults to `c++17`
* `OPTIONS` -- Other `bjam` options. See (`compile`)[./compile] for the current options.
* `EXTRA_OPTS` -- Defaults to an empty string. Can be used to send extra arguments to `bjam`.
* `CLANG_OPTS` -- Defaults to an empty string. Used to pass extra options for clang only.


## Supported Boost versions

We test with the following versions:

* 1.62.0 -- Ubuntu
* 1.63.0 -- Ubuntu
* 1.64.0 -- Ubuntu
* 1.65.0 -- Ubuntu, Mac
* 1.65.1 -- Ubuntu, Mac
* 1.66.0 -- Ubuntu, Mac
* 1.67.0 -- Ubuntu, Mac
* 1.68.0 -- Ubuntu, Mac

On Ubuntu Bionic (18.04) it will find and use 1.65.1 when installed. It will also find and use 1.67.0 on the Mac when it is installed with Brew.


## Installation

When it builds Boost itself it will add the following Boost libraries to the `lib` installation target directory:

* atomic
* chrono
* context
* coroutine
* date_time
* filesystem
* system
* thread

