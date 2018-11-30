module serializer (	
	input 		sys_rst,
	input 		pixel_clk,
	input 		serial_clk,
	input [6:0]	data,
	
	output		out
);

	reg [6:0] 	buffer [1:0];	//	14 bits buffer
	reg [1:0] 	shiftdata;

	reg 		datacount; 
	reg [2:0]	outcount;

	reg 		data_in_buffer;
	reg 		send_ok;
	
`ifdef SIMULATION	
	wire [6:0] buf0 = buffer [0];
	wire [6:0] buf1 = buffer [1];
`endif	

	always @(posedge pixel_clk or posedge sys_rst) begin
		if (sys_rst) begin
			buffer [0] 		<= 7'b0000000;
			buffer [1] 		<= 7'b0000000;
			datacount 		<= 'd0;
			data_in_buffer	<= 'd0;
		end else begin
			data_in_buffer <= 1'b1;
			datacount <= datacount + 1'b1;
			buffer [datacount] <= data;			
		end
	end

	always @(posedge serial_clk or posedge sys_rst) begin
		if (sys_rst) begin
			outcount <= 'd0;
			shiftdata <= 'd0;
			send_ok <= 'd0;
		end else begin
			if (outcount == 3'h6)
				outcount <= 'd0;
			else
				outcount <= outcount + 3'b1;
			
			if (data_in_buffer && outcount == 3'h6)
					send_ok <= 1'b1;
				
			if (send_ok) begin
				case (outcount)	// synopsys full_case parallel_case
					0:	shiftdata <= { buffer [0][0], buffer [0][1] };
					1:	shiftdata <= { buffer [0][2], buffer [0][3] };
					2:	shiftdata <= { buffer [0][4], buffer [0][5] };
					3:	shiftdata <= { buffer [0][6], buffer [1][0] };
					4:	shiftdata <= { buffer [1][1], buffer [1][2] };
					5:	shiftdata <= { buffer [1][3], buffer [1][4] };
					6:	shiftdata <= { buffer [1][5], buffer [1][6] };
				endcase
			end
		end
	end
	
`ifndef SIMULATION
	altddio_out	#(
		.lpm_type 	( "altddio_out"	),
		.width		( 1				)
	) ddio (
		.datain_h	( shiftdata [1]	),
		.datain_l	( shiftdata [0]	),
		.outclock	( serial_clk	),
		.dataout 	( out			)
	);
`else
	reg 	ddr_p = 1'b0, ddr_n = 1'b0;	
	always	@(posedge serial_clk) ddr_p <= shiftdata [1];	
	always	@(posedge serial_clk) ddr_n <= shiftdata [0];	
	assign	out = serial_clk ? ddr_p : ddr_n;	
`endif
	
endmodule
