# Copyright (C) 2024 CERN and UCLouvain.
# Licensed under the GNU Lesser General Public License (version 3 or later).
# Created by: S. Hageboeck for the MG5aMC CUDACPP plugin.

file(GLOB HELAS_FILES "DHELAS/*.f")

add_library(Source STATIC
  StringCast.f
  DiscreteSampler.f
  dsample.f
  ranmar.f
  alfas_functions.f
  transpole.f
  invarients.f
  hfill.f
  pawgraphs.f
  ran1.f
  rw_events.f
  rw_routines.f
  kin_functions.f
  open_file.f
  basecode.f
  setrun.f
  run_printout.f
  dgauss.f
  readgrid.f
  getissud.f
  ${HELAS_FILES}
  PDF/opendata.f
  PDF/PhotonFlux.f
  PDF/ElectroweakFlux_dummy.f
  PDF/Ctq6Pdf.f
  PDF/pdfwrap.f
  PDF/pdf.f
  PDF/pdg2pdf.f
  PDF/NNPDFDriver.f
  PDF/eepdf.f
  PDF/gridpdfaux.f
  PDF/dfint.f
  PDF/kerset.f
  PDF/gammaUPC/gammaUPC_dummy.f
  MODEL/couplings.f
  MODEL/lha_read.f
  MODEL/printout.f
  MODEL/rw_para.f
  MODEL/model_functions.f
  MODEL/couplings1.f
  MODEL/couplings2.f
  CERNLIB/abend.f
  CERNLIB/dlsqp2.f
  CERNLIB/lenocc.f
  CERNLIB/mtlprt.f
  CERNLIB/mtlset.f
  CERNLIB/radmul.f
  BIAS/dummy/dummy.f
)
target_include_directories(Source PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
