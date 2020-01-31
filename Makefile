.PHONY: all run clean submit

RUNELF=./prog1.o

TRACE?=--trace
HAVETLB=n

VFILES=$(wildcard *.sv)
CFILES=$(wildcard *.cpp)

all: obj_dir/Vtop

obj_dir/Vtop: obj_dir/Vtop.mk
	$(MAKE) -j5 -C obj_dir/ -f Vtop.mk CXX="ccache g++"

obj_dir/Vtop.mk: $(VFILES) $(CFILES) 
	verilator -Wall -Wno-LITENDIAN -Wno-lint -O3 $(TRACE) --no-skip-identical --cc top.sv \
	--exe $(CFILES) /home/aakshintala/comp590/DRAMSim2/libdramsim.so \
	-CFLAGS -I/home/aakshintala/comp590 -CFLAGS -std=c++11 -CFLAGS -g3 \
	-LDFLAGS -Wl,-rpath=/home/aakshintala/comp590/DRAMSim2 \
	-LDFLAGS -lncurses -LDFLAGS -lelf -LDFLAGS -lrt

run: obj_dir/Vtop
	cd obj_dir/ && env HAVETLB=$(HAVETLB) ./Vtop $(RUNELF)

clean:
	rm -rf obj_dir/ dramsim2/results trace.vcd core 

SUBMITTO=/submit
SUBMIT_POINTS=-50
SUBMIT_SUFFIX=-wp1$(SUBMIT_POINTS)
submit: clean
	rm -f $(USER).tgz
	tar -czvf $(USER).tgz --exclude=.*.sw? --exclude=$(USER).tgz* --exclude=*~ --exclude=.git *
	mv -v $(USER).tgz $(SUBMITTO)/$(USER)$(SUBMIT_SUFFIX)=`date +%F=%T`.tgz
