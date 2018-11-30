/*
 * Milkymist SoC
 * Copyright (C) 2007, 2008, 2009, 2010 Sebastien Bourdeauducq
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

module vgafb_pixelfeed (
	input sys_clk,
	/* We must take into account both resets :
	 * VGA reset should not interrupt a pending FML request
	 * but system reset should.
	 */
	input 				sys_rst,
	input 				vga_rst,
	
	input 		[18:0]	nbursts,
	input 		[31:0]	baseaddress,
	output				baseaddress_ack,
	
	output reg	[31:0]	fml_adr,
	output reg 			fml_stb,
	input 				fml_ack,
	input 		[31:0]	fml_di,	

	output				pixel_valid,
	output		[15:0]	pixel,
	input 				pixel_ack
);

/* FIFO that stores the 32-bit bursts and slices it in 16-bit words */
reg [31:0] fifo_di;
reg fifo_stb;
wire can_burst;
wire fifo_valid;

vgafb_fifo32to16 fifo32to16(
	.sys_clk	( sys_clk		),
	.vga_rst	( vga_rst		),
	
	.stb		( fifo_stb		),
	.di			( fifo_di		),
	
	.can_burst	( can_burst		),
	.do_valid	( fifo_valid	),
	.do			( pixel			),
	.next		( pixel_ack		)
);

assign pixel_valid = fifo_valid;

always @(posedge sys_clk) begin
	fifo_stb <= fml_ack;
	fifo_di <= fml_di;
end

always	@(posedge sys_clk or posedge sys_rst) begin
	if (sys_rst) begin
		fml_stb <= 1'b0;		
	end else begin
		if (vga_rst) begin
			fml_stb <= 1'b0;			
		end else begin
			fml_stb <= can_burst;
//			if (can_burst)
//				fml_stb <= 1'b1;				
//			else if (fml_ack) begin
//				fml_stb <= can_burst;				
//			end
		end
	end
end

reg [18:0] bcounter;
reg sof;

assign baseaddress_ack = sof;

always @(posedge sys_clk or posedge vga_rst) begin
	if (vga_rst) begin
		bcounter <= 19'd1;
		sof <= 1'b1;
		fml_adr <= 32'd0;
	end else begin
		if (fml_ack) begin
			if (bcounter == nbursts) begin
				bcounter <= 19'd1;
				fml_adr <= baseaddress;
				sof <= 1'b1;
			end else begin
				bcounter <= bcounter + 19'd1;
				fml_adr <= fml_adr + 32'h4;
				sof <= 1'b0;
			end
		end
	end
end


///* BURST COUNTER */
//reg sof;
//wire counter_en;

//reg [18:0] bcounter;

//always @(posedge sys_clk or posedge vga_rst) begin
//	if(vga_rst) begin
//		bcounter <= 19'd1;
//		sof <= 1'b1;
//	end else begin
//		if(counter_en) begin
//			if(bcounter == nbursts) begin
//				bcounter <= 19'd1;
//				sof <= 1'b1;
//			end else begin
//				bcounter <= bcounter + 19'd1;
//				sof <= 1'b0;
//			end
//		end
//	end
//end

///* FML ADDRESS GENERATOR */
//wire next_address;

//assign baseaddress_ack = sof & next_address;

//reg next_burst;

//assign counter_en = next_burst;
//assign next_address = next_burst;

//always @(posedge sys_clk)
//	next_burst <= fml_ack;
//	
//always @(posedge sys_clk or posedge sys_rst) begin
//	if(sys_rst) begin
//		fml_adr <= 'd0;
//	end else begin
//		if(next_address) begin
//			if(sof)
//				fml_adr <= baseaddress;
//			else
//				fml_adr <= fml_adr + 32'h4;
//		end
//	end
//end

endmodule
