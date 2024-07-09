# Copyright (C) 2024 CERN and UCLouvain.
# Licensed under the GNU Lesser General Public License (version 3 or later).
# Created by: S. Hageboeck for the MG5aMC CUDACPP plugin.

cmake_minimum_required(VERSION 3.20)

get_filename_component(PROCESS ${CMAKE_CURRENT_SOURCE_DIR} NAME)
project(${PROCESS}
  LANGUAGES Fortran CXX)

#######################################################
# Options to configure from the user side
#######################################################
option(MG_FAST_MATH "Use fast math for C++ and fortran" ON)
option(MG_TESTING "Build tests using CTest and Googletest" OFF)
option(MG_CURAND "Enable cuRAND support (CUDA toolkit needs to be installed)" OFF)
option(MG_HIPRAND "Enable hipRAND support (hip needs to be installed)" OFF)
option(MG_ASAN "Enable address sanitizer in C++ builds" OFF)
option(MG_UBSAN "Enable undefined behaviour sanitizer in C++ builds" OFF)
option(MG_CLANG_TIDY "Enable clang-tidy checks for C++ builds" OFF)
set(MG_BACKEND "native" CACHE STRING "The backend to be used to compute matrix elements.")
set(MG_FPTYPE "m" CACHE STRING "Floating-point type to be used: d (double), m (mixed), f (float)")

#######################################################
# Configure (build-type-agnostic) compiler flags
#######################################################
include(CMake/Compilers.cmake)

#######################################################
# Configure matrix-element backend
#######################################################
include(CMake/ConfigureBackends.cmake)

#######################################################
# Configure tests if enabled
#######################################################
if(MG_TESTING)
  include(CTest)
  find_package(GTest REQUIRED)
endif()


#######################################################
# Add all directories to be compiled
#######################################################
add_subdirectory(Source)
add_subdirectory(src)
add_subdirectory(SubProcesses)
