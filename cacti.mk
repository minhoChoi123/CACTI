TARGET = cacti
SHELL = /bin/sh
.PHONY: all depend clean
.SUFFIXES: .cc .o

ifndef NTHREADS
  NTHREADS = 8
endif


LIBS = 
INCS = -lm

ifeq ($(TAG),gdb)
  GDB = -g  -msse2 -mfpmath=sse -DNTHREADS=$(NTHREADS)
  OPT = 
else
  GDB = -ggdb -g -O0 -DNTHREADS=1  -gstabs+
  OPT = -Wall 
endif

#CXXFLAGS = -Wall -Wno-unknown-pragmas -Winline $(GDB) $(OPT) 
CXXFLAGS = -Wno-unknown-pragmas $(GDB) $(OPT) 
CXX = g++ -m64
CC  = gcc -m64

SRCS  = area.cc bank.cc mat.cc main.cc Ucache.cc io.cc technology.cc basic_circuit.cc parameter.cc \
		decoder.cc component.cc uca.cc subarray.cc wire.cc htree2.cc extio.cc extio_technology.cc \
		cacti_interface.cc router.cc nuca.cc crossbar.cc arbiter.cc powergating.cc TSV.cc memorybus.cc \
		memcad.cc memcad_parameters.cc
		

OBJS = $(patsubst %.cc,obj_$(TAG)/%.o,$(SRCS))
PYTHONLIB_SRCS = $(patsubst main.cc, ,$(SRCS)) obj_$(TAG)/cacti_wrap.cc
PYTHONLIB_OBJS = $(patsubst %.cc,%.o,$(PYTHONLIB_SRCS)) 
INCLUDES       = -I /usr/include/python2.4 -I /usr/lib/python2.4/config

all: obj_$(TAG)/$(TARGET)
	cp -f obj_$(TAG)/$(TARGET) $(TARGET)

obj_$(TAG)/$(TARGET) : $(OBJS)
	$(CXX) $(OBJS) -o $@ $(INCS) $(CXXFLAGS) $(LIBS) -pthread

#obj_$(TAG)/%.o : %.cc
#	$(CXX) -c $(CXXFLAGS) $(INCS) -o $@ $<

obj_$(TAG)/%.o : %.cc
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	-rm -f *.o _cacti.so cacti.py $(TARGET)


