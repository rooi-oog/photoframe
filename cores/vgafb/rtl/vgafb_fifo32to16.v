/*
 * Milkymist SoC
 * Copyright (C) 2007, 2008, 2009 Sebastien Bourdeauducq
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

module vgafb_fifo32to16(
	input sys_clk,
	input vga_rst,
	
	input stb,
	input [31:0] di,
	
	output can_burst,
	output do_valid,
	output reg [15:0] do,
	input next /* should only be asserted when do_valid = 1 */
);

/*
 * FIFO can hold 8 64-bit words
 * that is 32 16-bit words.
 */

reg [31:0] storage [0:15];
reg [3:0] produce; /* in 32-bit words */
reg [4:0] consume; /* in 16-bit words */
/*
 * 16-bit words stored in the FIFO, 0-32 (33 possible values)
 */
reg [6:0] level;

wire [31:0] do32;
assign do32 = storage [consume [4:1]];

always @(*) begin
	case(consume[0])
		2'd0: do <= do32 [31:16];
		2'd1: do <= do32 [15:0];		
	endcase
end

always @(posedge sys_clk) begin
	if(vga_rst) begin
		produce = 4'd0;
		consume = 5'd0;
		level = 7'd0;
	end else begin
		if(stb) begin
			storage [produce] = di;
			produce = produce + 4'd1;
			level = level + 7'd2;
		end
		if(next) begin /* next should only be asserted when do_valid = 1 */
			consume = consume + 5'd1;
			level = level - 7'd1;
		end
	end
end

assign do_valid = ~(level == 7'd0);
assign can_burst = level <= 7'd26;

endmodule
