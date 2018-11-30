BNAME	:= system_tb
TGT		:= $(BNAME).vcd
BENCH	:= $(BNAME).v
LIBDIR	+= -y../cores/wb_sdram_ctrl/rtl/verilog
LIBDIR	+= -y../cores/lvds/rtl
LIBDIR	+= -y../cores/vgafb/rtl
LIBDIR	+= -y../cores/lvds/rtl
LIBDIR	+= -y../cores/asfifo/rtl
LIBDIR	+= -y../cores/spi
LIBDIR	+= -y../cores/lm32/rtl
LIBDIR	+= -y../cores/conbus/rtl
LIBDIR	+= -y../cores/wb_mem/rtl
LIBDIR	+= -y../cores/spi_flash/rtl
LIBDIR	+= -y../cores/csrbrg/rtl
LIBDIR	+= -y../cores/sysctl/rtl
LIBDIR	+= -y../cores/uart/rtl
LIBDIR	+= -y../cores/memcard/rtl
LIBDIR	+= -y../cores/monitor/rtl
LIBDIR	+= ../cores/lm32/rtl/jtag_tap_spartan6.v
LIBDIR	+= ../board/de0-nano/rtl/pframe.v


INCDIR	:= -I../cores/lm32/rtl -I../board/de0-nano/rtl -I../cores/spi_flash/rtl

all: vcd

vcd: verilog
	vvp $(BNAME) -lxt2
	rm -rf $(BNAME)
	
verilog:
	iverilog -o $(BNAME) -s $(BNAME) -DSIMULATION -DDEBUG_UART -DSPEEDSIM -DGENERIC_LVDS $(LIBDIR) $(INCDIR) -y. $(BENCH) 

clean:
	rm -rf $(TGT)
	rm -rf $(BNAME)
	
