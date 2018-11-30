BNAME	:= vgafb_tb
TGT		:= $(BNAME).vcd
BENCH	:= $(BNAME).v
LIBDIR	+= -y../rtl
LIBDIR	+= -y../asfifo/rtl

INCDIR	:= -I../rtl 

all: vcd

vcd: verilog
	vvp $(BNAME) -lxt2
	rm -rf $(BNAME)
	
verilog:
	iverilog -o $(BNAME) -s $(BNAME) -DSIMULATION -DDEBUG_UART -DSPEEDSIM $(LIBDIR) $(INCDIR) -y. $(BENCH) 

clean:
	rm -rf $(TGT)
	rm -rf $(BNAME)
	
