# Copyright (C) 2024 CERN and UCLouvain.
# Licensed under the GNU Lesser General Public License (version 3 or later).
# Created by: S. Hageboeck for the MG5aMC CUDACPP plugin.

file(GLOB SUBPROCESSES "P[0-9]*")

foreach(SUBDIR ${SUBPROCESSES})
  add_subdirectory(${SUBDIR})
endforeach()