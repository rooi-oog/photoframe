# Main system clock (50 Mhz)
create_clock -name "clk50_pad" -period 20.000ns [get_ports {clk50_pad}]
#create_clock -name "pbus_cmd_pad" -period 20.000ns [get_ports {clk50_pad}]
#create_clock -name "c0" -period 20.000ns [get_nets {pll_x1|altpll_component|auto_generated|wire_pll1_clk[0]}]

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

# Ignore timing on the reset input
set_false_path -from [get_ports {rst_n_pad}]	
