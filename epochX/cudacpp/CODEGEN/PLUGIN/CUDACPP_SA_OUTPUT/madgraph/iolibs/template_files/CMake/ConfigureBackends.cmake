# Copyright (C) 2024 CERN and UCLouvain.
# Licensed under the GNU Lesser General Public License (version 3 or later).
# Created by: S. Hageboeck for the MG5aMC CUDACPP plugin.

###############################################################
# Configure the madgraph backend.
# The following list contains the supported backend names and
# the C++ compiler flags to be set when they are enabled
###############################################################

set(POSSIBLE_BACKENDS
  "native:-march=native"
  "none:"
  "sse4:-march=nehalem"
  "avx2:-march=haswell"
  "avx512y:-march=skylake-avx512 -mprefer-vector-width=256"
  "avx512z:-march=skylake-avx512 -DMGONGPU_PVW512"
  "cuda:"
  )

set(BACKENDS_FILTERED ${POSSIBLE_BACKENDS})
list(FILTER BACKENDS_FILTERED INCLUDE REGEX "^${MG_BACKEND}.*")
list(LENGTH BACKENDS_FILTERED FILTERED_LENGTH)
if(NOT FILTERED_LENGTH EQUAL 1)
  message(STATUS "Supported madgraph backends:")
  foreach(BACKEND ${POSSIBLE_BACKENDS})
    message(STATUS "${BACKEND}")
  endforeach()
  message(FATAL_ERROR "Madgraph backend '${MG_BACKEND}' unknown. Choose from the supported backends above.")
endif()


list(GET BACKENDS_FILTERED 0 SELECTED_BACKEND)
string(REPLACE ":" ";" BACKEND_LIST ${SELECTED_BACKEND})
list(GET BACKEND_LIST 0 BACKEND_NAME)
list(GET BACKEND_LIST 1 BACKEND_FLAGS)
message(STATUS "Configuring madgraph for backend '${BACKEND_NAME}' with flags '${BACKEND_FLAGS}'")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${BACKEND_FLAGS}")

#######################################################
# A bit of backend-specific logic
#######################################################

if(${BACKEND_NAME} STREQUAL "cuda")
  set(MG_ENABLE_LANGUAGE CUDA)
  mark_as_advanced(MG_ENABLE_LANGUAGE)
  enable_language(${MG_ENABLE_LANGUAGE})
elif(${BACKEND_NAME} STREQUAL "hip")
  set(MG_ENABLE_LANGUAGE HIP)
  mark_as_advanced(MG_ENABLE_LANGUAGE)
  enable_language(${MG_ENABLE_LANGUAGE})
endif()

if(MG_CURAND)
  find_package(CUDAToolkit REQUIRED)
endif()

if(MG_HIPRAND)
  find_package(hipRAND REQUIRED)
endif()
#TODO: Write the above for finding hip