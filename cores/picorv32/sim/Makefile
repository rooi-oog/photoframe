BNAME	:= picorv32_tb
TGT		:= $(BNAME).vcd
BENCH	:= $(BNAME).v
LIBDIR	:= ../rtl/picorv32.v
LIBDIR	+= -y../rtl
INCDIR	:= -I../rtl

all: vcd

vcd: verilog
	vvp $(BNAME) -lxt2
	rm -rf $(BNAME)
	
verilog:
	iverilog -o $(BNAME) -s $(BNAME) -DSIMULATION $(LIBDIR) $(INCDIR) -y. $(BENCH) 

clean:
	rm -rf $(TGT)
	rm -rf $(BNAME)
	
