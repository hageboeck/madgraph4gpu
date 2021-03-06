CUARCHNUM=70
LIBDIR=../lib
CXXFLAGS= -O3 -I. -DUSE_NVTX -Wall -Wshadow 
###CXXFLAGS= -O2 -I. -DUSE_NVTX -Wall -Wshadow 
CUARCHFLAGS= -arch=compute_$(CUARCHNUM)
CUFLAGS= -O3 -I. -DUSE_NVTX $(CUARCHFLAGS) -use_fast_math -lineinfo
CUINC=/usr/local/cuda/targets/x86_64-linux/include
NVCC=nvcc
CXX=g++

# Assuming uname is available, detect if architecture is power
UNAME_P := $(shell uname -p)
ifeq ($(UNAME_P),ppc64le)
    CUFLAGS+= -Xcompiler -mno-float128
endif

target=$(LIBDIR)/libmodel_sm.a
cxx_objects=Parameters_sm.o read_slha.o rambo.o 
cu_objects= # NB grambo.cu must be included by gcheck.cu (no rdc)

all: $(target)

debug: CXXFLAGS:=$(filter-out -O3,$(CXXFLAGS))
debug: CUFLAGS:=$(filter-out -lineinfo,$(CUFLAGS))
debug: CXXFLAGS += -g -O0 -DDEBUG2
debug: CUFLAGS += -G
debug: $(target)

# NB: cuda includes are needed in the C++ code for curand.h
%.o : %.cc *.h
	$(CXX)  $(CPPFLAGS) $(CXXFLAGS) -I$(CUINC) -c $< -o $@

#%.o : %.cu *.h
#	$(NVCC) $(CPPFLAGS) $(CUFLAGS) -c $< -o $@

$(target): $(cxx_objects) $(cu_objects)
	if [ ! -d $(LIBDIR) ]; then mkdir $(LIBDIR); fi
	$(AR) cru $@ $(cxx_objects) $(cu_objects)
	ranlib $(target)

.PHONY: clean

clean:
	rm -f $(target)
	rm -f $(cxx_objects) $(cu_objects)
