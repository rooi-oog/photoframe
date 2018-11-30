`timescale 1ps/1ps

module vgafb_tb;

reg clk = 1; always #5000 clk = ~clk;
reg vga_clk = 1; always #10000 vga_clk = ~vga_clk;
reg rst = 1; initial #200000 rst = 0;

wire fml_stb;
reg fml_ack = 0;
reg fml_ack_r = 0;
reg fml_ack_rr = 0;
reg fml_ack_rrr = 0;

vgafb vgafb (
	.sys_clk	( clk		),
	.sys_rst	( rst		),
		
	.fml_adr	( 			),
	.fml_stb	( fml_stb	),
	.fml_ack	( fml_ack	),
	.fml_di		( 32'hDEADBEEF	),
	
	.vga_clk	( vga_clk	)	
);

always	@(posedge clk) begin
	fml_ack_rrr <= fml_stb & ~fml_ack_rrr & ~fml_ack_rr & ~fml_ack_r & ~fml_ack;
	fml_ack_rr <= fml_ack_rrr;
	fml_ack_r <= fml_ack_rr;
	fml_ack <= fml_ack_r;
end

initial begin
	$dumpfile ("vgafb_tb.vcd");
	$dumpvars;
	#2000000000 $finish;
end


endmodule
