# Copyright (C) 2020-2024 CERN and UCLouvain.
# Licensed under the GNU Lesser General Public License (version 3 or later).
# Created by: S. Roiser (Feb 2022) for the MG5aMC CUDACPP plugin.
# Further modified by: S. Hageboeck (2024) for the MG5aMC CUDACPP plugin.

# Configure all compiler flags that are independent of the build type.
# This can be language standards, mandatory flags, math options and the like.
# Build flags should be set directly via the CMake command line, e.g.
# cmake -DCMAKE_CXX_FLAGS_RELEASE="-O3 ..." <SourceDir>

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "-Wall -Wextra ${CMAKE_CXX_FLAGS}")

set(CMAKE_Fortran_FLAGS "-ffixed-line-length-132 -fno-align-commons -fbounds-check ${CMAKE_Fortran_FLAGS}")
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules)
set(CMAKE_Fortran_PREPROCESS On)

set(CMAKE_CUDA_FLAGS "-Wall ${CMAKE_CUDA_FLAGS}")

if(MG_FAST_MATH)
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -ffast-math")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ffast-math")
  set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -ffast-math")
endif()

# Add defaults for a new build type "Profile"
set(CMAKE_Fortran_FLAGS_PROFILE "-O2 -g -fno-omit-frame-pointer")
set(CMAKE_CXX_FLAGS_PROFILE "-O2 -g -fno-omit-frame-pointer")
set(CMAKE_CUDA_FLAGS_PROFILE "-O2 -g -fno-omit-frame-pointer -lineinfo")

# Sanitizer and static analysis
if(MG_ASAN)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address")
endif()
if(MG_UBSAN)
  # These flags cannot be set in the general CXX_FLAGS, since FindGTest cannot deal with them:
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} -fsanitize=undefined")
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=undefined")
endif()
if(MG_CLANG_TIDY)
  find_program(CLANG_TIDY clang-tidy REQUIRED)
  set(CMAKE_CXX_CLANG_TIDY ${CLANG_TIDY} -checks=bugprone*,-bugprone-easily-swappable*,clang-analyzer-*)
endif()

# Although empty build types are allowed, that's probably not what the user wanted:
if("${CMAKE_BUILD_TYPE}" STREQUAL "")
  message(WARNING "Please set CMAKE_BUILD_TYPE, unless a multi-config generator is used. Proceeding with Release now.")
  set(CMAKE_BUILD_TYPE "Release")
endif()
string(TOUPPER "${CMAKE_BUILD_TYPE}" BUILD_TYPE_UPPER)
message(STATUS "Compiler configuration:\n${CMAKE_CXX_COMPILER} ${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_${BUILD_TYPE_UPPER}}")