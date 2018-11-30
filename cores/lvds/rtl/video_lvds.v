module video_lvds #(
	parameter	TECHNOLOGY = "ALTERA_LVDS"
)(
	input 		sys_rst,
	
	input 		clk_x1,	
	input		clk_3x5,
	input 		DE,
	input [7:0]	R,
	input [7:0]	G,
	input [7:0]	B,

	output 		rx0,
	output 		rx1,
	output 		rx2,
	output		rx3,
	output 		clk	
);
	wire pixel_clk	= clk_x1;	

generate
	if (TECHNOLOGY == "ALTERA_LVDS") begin
		wire [6:0] rx0_w = {G [0], R [5], R [4], R [3], R [2], R [1], R [0]};
		wire [6:0] rx1_w = {B [1], B [0], G [5], G [4], G [3], G [2], G [1]};
		wire [6:0] rx2_w = {DE,    1'b0,  1'b0,  B [5], B [4], B[3], B[2]};
		wire [6:0] rx3_w = {1'b0, B [7], B [6], G [7], G [6], R [7], R [6]};
		wire [6:0] clk_w = 7'b1100011;
		
		altlvds_tx #(	
			.center_align_msb ( "UNUSED" ),
			.common_rx_tx_pll ( "OFF" ),
			.coreclock_divide_by ( 2 ),
			.deserialization_factor ( 7 ),
			.differential_drive ( 0 ),
			.implement_in_les ( "ON" ),
			.inclock_boost ( 0 ),
			.inclock_data_alignment ( "EDGE_ALIGNED" ),
			.inclock_period ( 20000 ),
			.inclock_phase_shift ( 0 ),
			.lpm_type ( "altlvds_tx" ),
			.number_of_channels ( 5 ),
			.outclock_alignment ( "EDGE_ALIGNED" ),
			.outclock_duty_cycle ( 50 ),
			.outclock_phase_shift ( 0 ),
			.output_data_rate ( 350 ),
			.pll_self_reset_on_loss_lock ( "ON" ),
			.registered_input ( "TX_CORECLK" ),
			.use_external_pll ( "OFF" ),
			.use_no_phase_shift ( "ON" )
		) lvds_tx (
			.pll_areset 	( sys_rst ),
			.tx_in 			( {rx0_w, rx1_w, rx2_w, rx3_w, clk_w} ),
			.tx_inclock 	( pixel_clk ),
			.tx_out 		( {rx0, rx1, rx2, rx3, clk} ),
			.sync_inclock	( 1'b0 ),
			.tx_coreclock 	( ),
			.tx_data_reset 	( 1'b0 ),
			.tx_enable 		( 1'b1 ),
			.tx_locked 		( ),
			.tx_outclock 	( ),
			.tx_pll_enable	( 1'b1 ),
			.tx_syncclock	( 1'b0 )
		);
		
//	lvds_tx lvds_tx (
//		.pll_areset	( sys_rst	),
//		.tx_in		( {rx0_w, rx1_w, rx2_w, rx3_w, clk_w} ),
//		.tx_inclock	( pixel_clk	),
//		.tx_out		( {rx0, rx1, rx2, rx3, clk}	)
//	);

	end else 
	if (TECHNOLOGY == "ALTERA_LVDS") begin		
		wire serial_clk	= clk_3x5;		
		wire [6:0] rx0_w = {R [0], R [1], R [2], R [3], R [4], R [5], G [0]};
		wire [6:0] rx1_w = {G [1], G [2], G [3], G [4], G [5], B [0], B [1]};
		wire [6:0] rx2_w = {B [2], B [3], B [4], B [5], 1'b0,  1'b0,  DE};
		wire [6:0] rx3_w = {R [6], R [7], G [6], G [7], B [6], B [7], 1'b0};
		wire [6:0] clk_w = 7'b1100011;
			
		serializer rx_0 (	
			.sys_rst		( sys_rst		),
			.pixel_clk		( pixel_clk		),
			.serial_clk		( serial_clk	),
			.data			( rx0_w			),
			.out			( rx0			)
		);
		
		serializer rx_1 (	
			.sys_rst		( sys_rst		),
			.pixel_clk		( pixel_clk		),
			.serial_clk		( serial_clk	),
			.data			( rx1_w			),
			.out			( rx1			)
		);
		
		serializer rx_2 (	
			.sys_rst		( sys_rst		),
			.pixel_clk		( pixel_clk		),
			.serial_clk		( serial_clk	),
			.data			( rx2_w			),
			.out			( rx2			)
		);
		
		serializer rx_3 (	
			.sys_rst		( sys_rst		),
			.pixel_clk		( pixel_clk		),
			.serial_clk		( serial_clk	),
			.data			( rx3_w			),
			.out			( rx3			)
		);
		
		serializer clk_0 (	
			.sys_rst		( sys_rst		),
			.pixel_clk		( pixel_clk		),
			.serial_clk		( serial_clk	),
			.data			( clk_w			),
			.out			( clk			)
		);
	end
endgenerate

endmodule
