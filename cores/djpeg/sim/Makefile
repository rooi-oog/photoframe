BNAME	:= tb_aq_djpeg
TGT		:= $(BNAME).vcd
BENCH	:= $(BNAME).v
#LIBDIR	:= ../board/de0_nano/rtl/system.v
LIBDIR	+= -y../hdl
INCDIR	:= -I../hdl

all: vcd

vcd: verilog
	vvp $(BNAME) -lxt2
	rm -rf $(BNAME)
	
verilog:
	iverilog -o $(BNAME) -s $(BNAME) -DSIMULATION $(LIBDIR) $(INCDIR) -y. $(BENCH) 

clean:
	rm -rf $(TGT)
	rm -rf $(BNAME)
	
