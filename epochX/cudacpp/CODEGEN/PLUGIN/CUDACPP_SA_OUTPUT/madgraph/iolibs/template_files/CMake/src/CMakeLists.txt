# Copyright (C) 2024 CERN and UCLouvain.
# Licensed under the GNU Lesser General Public License (version 3 or later).
# Created by: S. Hageboeck for the MG5aMC CUDACPP plugin.

add_library(mg5amc_common Parameters_sm.cc read_slha.cc)
target_include_directories(mg5amc_common PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


if(MG_FPTYPE STREQUAL "d")
  target_compile_definitions(mg5amc_common PUBLIC MGONGPU_FPTYPE_DOUBLE MGONGPU_FPTYPE2_DOUBLE)
elseif(MG_FPTYPE STREQUAL "m")
  target_compile_definitions(mg5amc_common PUBLIC MGONGPU_FPTYPE_DOUBLE MGONGPU_FPTYPE2_FLOAT)
elseif(MG_FPTYPE STREQUAL "f")
  target_compile_definitions(mg5amc_common PUBLIC MGONGPU_FPTYPE_FLOAT MGONGPU_FPTYPE2_FLOAT)
else()
  message(FATAL_ERROR "MG_FPTYPE=${MADGRAPH_FPTYPE} is unknown.")
endif()

if(DEFINED MG_ENABLE_LANGUAGE)
  set_source_files_properties(Parameters_sm.cc PROPERTIES LANGUAGE ${MG_ENABLE_LANGUAGE})
endif()
