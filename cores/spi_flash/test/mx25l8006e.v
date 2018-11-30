///////////////////////////////////////////////////////////////////////////////
//  File name : mx25l8006e.v
///////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2010 Free Model Foundry; http://www.FreeModelFoundry.com
//
//  MODIFICATION HISTORY :
//
//  version: | author:         |   mod date:  | changes made:
//    V1.0    R.Prokopovic        10 May 18      Initial
//            
///////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:    FLASH
//  Technology: FLASH MEMORY
//  Part:       MX25L8006E
//
//  Description: 8 Megabit Serial Flash Memory
//
//////////////////////////////////////////////////////////////////////////////
//  Comments :
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ps/1 ps

module mx25l8006e
    (
        // Data Inputs/Outputs
        SI      ,
        SO      ,
        // Controls
        SCLK    ,
        CSNeg   ,
        HOLDNeg ,
        WPNeg  
);

///////////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
///////////////////////////////////////////////////////////////////////////////

    inout   SI            ;
    output  SO            ;

    input   SCLK          ;
    input   CSNeg         ;
    input   HOLDNeg       ;
    input   WPNeg         ;

    // interconnect path delay signals
    wire  SCLK_ipd           ;
    wire  SI_ipd            ;

    wire  SI_in             ;
    assign SI_in = SI_ipd   ;

    wire  SI_out            ;
    assign SI_out = SI      ;

    wire  CSNeg_ipd    ;
    wire  HOLDNeg_ipd  ;
    wire  WPNeg_ipd     ;
    wire  SO_ipd       ;

    wire   HOLDNeg_in                ;
    assign HOLDNeg_in = HOLDNeg_ipd  ;

    wire   WPNeg_in                  ;
    assign WPNeg_in = WPNeg_ipd      ;

    wire  SOut              ;
    assign SOut = SO        ;
    ///////////////////////////////////////////////////////////////////////////
    // internal delays
    reg DP_in      ;
    reg DP_out     ;
    reg RES_in     ;
    reg RES_out    ;
    ///////////////////////////////////////////////////////////////////////////

    reg  SOut_zd = 1'bZ        ;
    reg  SOut_z  = 1'bZ        ;

    wire SI_z                  ;
    wire SO_z                  ;

    reg  SIOut_zd = 1'bZ       ;
    reg  SIOut_z  = 1'bZ       ;

    assign SI_z = SIOut_z;
    assign SO_z = SOut_z;
    ///////////////////////////////////////////////////////////////////////////
    // event control registers

    reg rising_edge_RES_out  = 1'b0;
    reg rising_edge_CSNeg_ipd  = 1'b0;
    reg falling_edge_CSNeg_ipd = 1'b0;
    reg rising_edge_SCLK_ipd    = 1'b0;
    reg falling_edge_SCLK_ipd   = 1'b0;

    ///////////////////////////////////////////////////////////////////////////

    parameter UserPreload       = 1;
    parameter mem_file_name     = "none"; //"mx25l8006e.mem";
    parameter otp_file_name     = "none"; //mx25l8006eOTP.mem";//"none";

    parameter TimingModel   = "DefaultTimingModel";

    parameter  PartID         = "mx25l8006e";
    parameter  MaxData        = 255;
    parameter  MemSize        = 20'hFFFFF;
    parameter  SecSize_4      = 4095;
    parameter  PageNum        = 12'hFFF;
    parameter  Blk64Num       = 15;
    parameter  Blk4Num        = 255;
    parameter  Blk64Size      = 16'hFFFF;
    parameter  Blk4Size       = 12'hFFF;
    parameter  AddrRANGE      = 20'hFFFFF;
    parameter  OTPLoAddr      = 8'h00;
    parameter  OTPHiAddr      = 8'h3F;
    parameter  BYTE           = 8;
    //***********************************************************************//

    // Manufacturer Identification
    parameter  Manuf_ID        = 8'hC2;  // for REMS (90h) command
    parameter  Device_ID       = 8'h13; // for REMS (90h) command

    // Electronic Signature
    parameter  ElectronicID    = 8'h13; // for RES (ABh) command
    //Manufacturer Identification && Memory Type && Memory Density
    parameter  Jedec_DeviceID  = 8'hC2;  // only for RDID (9Fh) command
    parameter  Jedec_MemTypeID = 8'h20;  // only for RDID (9Fh) command
    parameter  Jedec_MemDensity = 8'h14;  // only for RDID (9Fh) command
    //***********************************************************************//
    // If speedsimulation is needed uncomment following line

//        `define SPEEDSIM;

    // powerup
    reg PoweredUp;

    // FSM control signals
    reg PDONE     ;
    reg PSTART    ;

    reg WDONE     ;
    reg WSTART    ;

    reg EDONE     ;
    reg ESTART    ;

    // Programming buffer
    integer WByte[0:255];

    integer AddrLo;
    integer AddrHi;

    // OTP Memory Array
    integer OTPMem[OTPLoAddr:OTPHiAddr];
    // Flash Memory Array
	integer Mem[0:AddrRANGE];


    // Registers
    // Status Register 1
    reg[7:0] Status_reg       = 8'h00;
    reg[7:0] Status_reg_in    = 8'h00;
    
    reg[7:0] Security_reg     = 8'h00;
    reg[7:0] Security_reg_in  = 8'h00;

    wire SRWD     ;
    wire [2:0] BP ;
    wire WEL      ;
    wire WIP      ;
    assign SRWD = Status_reg[7];
    assign BP   = Status_reg[4:2];
    assign WEL  = Status_reg[1];
    assign WIP  = Status_reg[0];

    wire LDSO; 
    wire SEC_OTP;
    assign LDSO     = Security_reg[1];
    assign SEC_OTP  = Security_reg[0];

    reg  hold_mode;

    ///////////////////////////////////////////////////////////////////////////
    // Command Register
    reg write;
    reg read_out;
    reg slow_read;
    reg dual_read;
    reg fast_read;

    wire rd_normal;
    assign rd_normal = slow_read;
    wire rd_dual;
    assign rd_dual = dual_read;
    wire rd_fast;  // this condition is not only for FAST_READ, 
    //it's also for PP,SE,BE,CE,DP,RES,RDP,WREN,WRDI,RDID,RDSR,WRR
    assign rd_fast = fast_read;
    wire any_read;
    assign any_read = (slow_read || dual_read || fast_read);
    wire any_prog;
    assign any_prog = write;

    wire deg_sin;
    wire power;

    wire wr_prot;
    assign wr_prot = SRWD && WEL;

    reg deq_sin;
    always @(SI_in, SIOut_z)
    begin
      if (SI_in==SIOut_z)
        deq_sin=1'b0;
      else
        deq_sin=1'b1;
    end
    assign deg_sin = deq_sin && (~any_read);

    //Sector Protection Status
    reg [Blk64Num:0] Block_Prot = 16'b0; // 

    integer SA          = 0;         // 0 TO SecNum+1
    integer Byte_number = 0;
    integer blck;

    reg  change_BP = 0;

    //Address
    integer Address = 0;         // 0 - AddrRANGE
    reg  change_addr;

    integer read_cnt = 0;
    integer read_addr = 0;
    reg[7:0] data_out;
    reg[23:0] ident_out;
    reg[15:0] ident_out2;

    reg oe = 1'b0;
    event oe_event;

    reg[7:0]  old_bit, new_bit;
    integer old_int, new_int;
    integer wr_cnt;
    integer cnt;

    // timing check violation
    reg Viol = 1'b0;

    // DMC array
    integer DMC_array[8'h00:8'h37];
    reg [303:0] DMC_array_tmp;
    reg [7:0] DMC_tmp;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////
    buf   (SCLK_ipd, SCLK);
    buf   (SI_ipd, SI);
    
    buf   (SO_ipd,      SO);
    buf   (CSNeg_ipd,   CSNeg);
    buf   (HOLDNeg_ipd, HOLDNeg);
    buf   (WPNeg_ipd,   WPNeg);

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
    nmos   (SI,     SI_z,        1);
    nmos   (SO,     SO_z,        1);

    //VHDL VITAL CheckEnable equivalents

specify
    // tipd delays: interconnect path delays , mapped to input port delays.
    // In Verilog is not necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file
    // With all the other delays real delays would be taken from SDF file

    // tpd delays
    specparam           tpd_SCLK_SO            =1;   // tCLQV, tCLQX
    specparam           tpd_CSNeg_SO           =1;   // tSHQZ
    specparam           tpd_HOLDNeg_SO         =1;   // tHLQZ, tHHQZ

    // tsetup values: setup times
    specparam           tsetup_SI_SCLK         =1;   // tDVCH
    specparam           tsetup_CSNeg_SCLK      =1;   // tSLCH, tSHCH
    specparam           tsetup_HOLDNeg_SCLK    =1;   // tHLCH, tHHCH
    specparam           tsetup_WPNeg_CSNeg     =1;   // tWHSL

    // thold values: hold times                      
    specparam           thold_SI_SCLK          =1;   // tCHDX
    specparam           thold_CSNeg_SCLK       =1;   // tCHSL, tCHSH
    specparam           thold_HOLDNeg_SCLK     =1;   // tCHHL, tCHHH
    specparam           thold_WPNeg_CSNeg      =1;   // tSHWL

    // tpw values: pulse width
    specparam           tpw_SCLK_fast_posedge  =1;   // tCH, f=86MHz
    specparam           tpw_SCLK_fast_negedge  =1;   // tCL, f=86MHz
    specparam           tpw_SCLK_dual_posedge  =1;   // tCH, f=80MHz
    specparam           tpw_SCLK_dual_negedge  =1;   // tCL, f=80MHz
    specparam           tpw_SCLK_norm_posedge  =1;   // tCH, f=33MHz
    specparam           tpw_SCLK_norm_negedge  =1;   // tCL, f=33MHz
    specparam           tpw_CSNeg_read_posedge =1;   // tSHSL (tCSH)    
    specparam           tpw_CSNeg_pgm_posedge  =1;   // tSHSL (tCSH)

    // tperiod min (calculated as 1/max freq)
    specparam           tperiod_SCLK_fast      =1;   // fSCLK = 86 MHz
    specparam           tperiod_SCLK_norm      =1;   // fSCLK = 33 MHz
    specparam           tperiod_SCLK_dual      =1;   // fSCLK = 80 MHz

    //CS# High to Deep Power Down Mode -- tDP
    specparam           tdevice_DP            = 10e6; // 10 us
    // CS# High to Standby mode without Electronic Signature Read
    specparam           tdevice_RES           = 88e5; // 8.8 us
    // VCC (min) to CS# Low; device can accept only read commands
    specparam           tdevice_PU             = 2e8;// tVSL 200 us
	
    // tdevice values: values for internal delays
    `ifdef SPEEDSIM
        // Page Program Time
        specparam   tdevice_PP     = 5e1; //5e7; // 50 us

        // Byte Program Time 
        specparam   tdevice_BP     = 3e6; // 3 us

        // Write Status Register Cycle Time
        specparam   tdevice_WRR    = 1e9; // 1 ms

        // Sector Erase Cycle Time 4KB
        specparam   tdevice_SE4    = 3e8; // 300 us

        // Block Erase (64KB) Cycle Time 
        specparam   tdevice_SE64   = 2e9; // 2 ms

        //Chip Erase Cycle Time
        specparam   tdevice_BE     = 15e9; // 15 ms

    `else
        // Page Program Time
        specparam   tdevice_PP     = 5e9; // 5ms

        // Byte Program Time 
        specparam   tdevice_BP     = 3e8; // 300us

        // Write Status Register Cycle Time
        specparam   tdevice_WRR    = 1e11; // 100 ms

        // Sector Erase Cycle Time 4KB
        specparam   tdevice_SE4    = 3e11; // 300 ms

        // Block Erase (64KB) Cycle Time 
        specparam   tdevice_SE64   = 2e12; // 2 s

        //Chip Erase Cycle Time
        specparam   tdevice_BE     = 15e12; // 15 s

    `endif//SPEEDSIM
///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
    (SCLK    => SO) = tpd_SCLK_SO;
    (HOLDNeg => SO) = tpd_HOLDNeg_SO;
    if (CSNeg) (CSNeg   => SO) = tpd_CSNeg_SO;
    if (dual_read) (HOLDNeg => SI) = tpd_HOLDNeg_SO;
    if (dual_read) (SCLK => SI) = tpd_SCLK_SO;
    if (CSNeg && dual_read) (CSNeg => SI) = tpd_CSNeg_SO;
///////////////////////////////////////////////////////////////////////////////

        $setup (SI            ,posedge SCLK  &&& deg_sin,
                                                tsetup_SI_SCLK       ,Viol);
        $setup (CSNeg         ,posedge SCLK  &&& power,
                                                tsetup_CSNeg_SCLK    ,Viol);
        $setup (WPNeg         ,negedge CSNeg &&& WPNeg,
                                                tsetup_WPNeg_CSNeg   ,Viol);
        $setup (HOLDNeg       ,posedge SCLK  &&& power,
                                                tsetup_HOLDNeg_SCLK  ,Viol);

        $hold  (posedge SCLK  &&& deg_sin,        SI    ,
                                                 thold_SI_SCLK       ,Viol);
        $hold  (posedge SCLK  &&& power,     CSNeg    ,
                                                 thold_CSNeg_SCLK    ,Viol);
        $hold  (posedge SCLK  &&& power,   HOLDNeg    ,
                                                 thold_HOLDNeg_SCLK  ,Viol);
        $hold  (posedge CSNeg &&& wr_prot,negedge WPNeg ,
                                                 thold_WPNeg_CSNeg   ,Viol);

        $width ( posedge SCLK &&& rd_normal      ,tpw_SCLK_norm_posedge);
        $width ( negedge SCLK &&& rd_normal      ,tpw_SCLK_norm_negedge);
        $width ( posedge SCLK &&& rd_dual        ,tpw_SCLK_dual_posedge);
        $width ( negedge SCLK &&& rd_dual        ,tpw_SCLK_dual_negedge);
        $width ( posedge SCLK &&& rd_fast        ,tpw_SCLK_fast_posedge);
        $width ( negedge SCLK &&& rd_fast        ,tpw_SCLK_fast_negedge);
        $width ( posedge CSNeg &&& any_read      ,tpw_CSNeg_read_posedge);
        $width ( posedge CSNeg &&& any_prog      ,tpw_CSNeg_pgm_posedge);

        $period ( posedge SCLK &&& rd_normal     ,tperiod_SCLK_norm);
        $period ( posedge SCLK &&& rd_dual       ,tperiod_SCLK_dual);
        $period ( posedge SCLK &&& rd_fast       ,tperiod_SCLK_fast);

endspecify

///////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                       //
///////////////////////////////////////////////////////////////////////////////
// FSM states
 parameter IDLE            =4'd0;
 parameter WRITE_SR        =4'd1;
 parameter DP_DOWN         =4'd2;
 parameter SECTOR_ER       =4'd3;
 parameter BLOCK_ER        =4'd4;
 parameter CHIP_ER         =4'd5;
 parameter PAGE_PG         =4'd6;
 parameter SECURE_OTP      =4'd7;
 parameter SC_OTP_PG       =4'd8; 

 reg [3:0] current_state;
 reg [3:0] next_state;

// Instructions
    parameter NONE            = 5'd0;
    parameter WREN            = 5'd1; 
    parameter WRDI            = 5'd2;
    parameter RDID            = 5'd3;
    parameter RDSR            = 5'd4;
    parameter WRR             = 5'd5;
    parameter READ            = 5'd6;
    parameter FAST_READ       = 5'd7;
    parameter DUAL_READ       = 5'd8;
    parameter SE              = 5'd9;
    parameter BE64            = 5'd10;
    parameter CE              = 5'd11;
    parameter PP              = 5'd12;
    parameter DP              = 5'd13;
    parameter RES_RD_ES       = 5'd14;
    parameter REMS            = 5'd15;
    parameter ENSO            = 5'd16;
    parameter EXSO            = 5'd17;
    parameter RDSCUR          = 5'd18;
    parameter WRSCUR          = 5'd19;
    parameter RDDMC           = 5'd20;

    reg [4:0] Instruct;

//Bus cycle states
    parameter STAND_BY        = 3'd0;
    parameter OPCODE_BYTE     = 3'd1;
    parameter ADDRESS_BYTES   = 3'd2;
    parameter DUMMY_BYTES     = 3'd3;
    parameter DATA_BYTES      = 3'd4;

    reg [2:0] bus_cycle_state;
///////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    // Initial 
    initial
    begin : Init

        write       = 1'b0;
        read_out    = 1'b0;
        Address     = 0;
        change_addr = 1'b0;

        PDONE       = 1'b1;
        PSTART      = 1'b0;

        EDONE       = 1'b1;
        ESTART      = 1'b0;

        WDONE       = 1'b1;
        WSTART      = 1'b0;

        DP_in       = 1'b0;
        DP_out      = 1'b0;
        RES_in      = 1'b0;
        RES_out     = 1'b0;
        Instruct    = NONE;

        bus_cycle_state = STAND_BY;
        current_state   = IDLE;
        next_state      = IDLE;
    end

    // initialize memory and load preload files if any
    initial
    begin: InitMemory
        integer i;

        for (i=0;i<=AddrRANGE;i=i+1)
        begin
            Mem[i] = MaxData;
        end

        if ((UserPreload) && !(mem_file_name == "none"))
        begin
           // Memory Preload
           //mx25l8006e.mem, memory preload file
           //  @aaaaaa - <aaaaaa> stands for address
           //  dd      - <dd> is byte to be written at Mem(aaaaaa++)
           // (aaaaaa is incremented at every load)
           $readmemh (mem_file_name, Mem);           
        end
        
        for (i=OTPLoAddr;i<=OTPHiAddr;i=i+1)
        begin
            OTPMem[i] = MaxData;
        end

        if (UserPreload && !(otp_file_name == "none"))
        begin
        //mx25l8006e_otp memory file
        //   /       - comment
        //   @aaaaaa     - <aaaaaa> stands for address within last defined
        //   sector
        //   dd      - <dd> is byte to be written at OTPMem(aaa++)
        //   (aa is incremented at every load)
        //   only first 1-4 columns are loaded. NO empty lines !!!!!!!!!!!!!!!!
           $readmemh(otp_file_name,OTPMem);
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    // DMC - Discoverable Memory Capabilities
    initial
    begin: InitDMC
    integer i;
    integer j;
        // SPI Flash Discoverability Parameters (DMC) Signature
        DMC_array[8'h00] = 8'h53;
        DMC_array[8'h01] = 8'h46;
        DMC_array[8'h02] = 8'h44;
        DMC_array[8'h03] = 8'h50;
        // DMC Revision
        DMC_array[8'h04] = 8'h00; // Minor Revison
        DMC_array[8'h05] = 8'h01; // Major Revision
  
        DMC_array[8'h06] = 8'h02; // Number of Parameter Header 

        DMC_array[8'h08] = 8'h00; // Parameter ID(0)
        DMC_array[8'h09] = 8'h00;  // Parameter Minor revision
        DMC_array[8'h0A] = 8'h01;  // Parameter Major revision
        DMC_array[8'h0B] = 8'h02;  // Paramter Length (in DW)
        // Parameter Table Pointer - 0Eh:0Ch = 000020
        DMC_array[8'h0C] = 8'h20;
        DMC_array[8'h0D] = 8'h00;
        DMC_array[8'h0E] = 8'h00;

        DMC_array[8'h10] = 8'h01;  // Parameter ID(1)
        DMC_array[8'h11] = 8'h00;  // Parameter Minor Revision
        DMC_array[8'h12] = 8'h01;  // Parameter Major Revision

        DMC_array[8'h18] = 8'h02;  // Parameter ID(2)
        DMC_array[8'h19] = 8'h00;  // Parameter Minor Revision
        DMC_array[8'h1A] = 8'h01;  // Parameter Major Revision
        DMC_array[8'h1B] = 8'h02;  // Paramter Length (in DW)
        // Parameter Table Pointer - 1Eh:1Ch = 000030
        DMC_array[8'h1C] = 8'h30;
        DMC_array[8'h1D] = 8'h00;
        DMC_array[8'h1E] = 8'h00;

        // Parameter ID(0)
        DMC_array[8'h20] = 5'b00101;
        DMC_array[8'h21] = 8'h20;  // 4KB Erase Opcode
        DMC_array[8'h22] = 6'b000001;

        // Flash Size in bits 24h:27h = 007FFFFFh
        DMC_array[8'h24] = 8'h00;
        DMC_array[8'h25] = 8'h7F;
        DMC_array[8'h26] = 8'hFF;
        DMC_array[8'h27] = 8'hFF;
         // Parameter ID(1)  RESERVED

        // Parameter ID(2)
        // VCC Supply Maximum Voltage 31h:30h = 3600h; 3600h (=) 3.60 V
        DMC_array[8'h30] = 8'h00;
        DMC_array[8'h31] = 8'h36;
        // VCC Supply Minimum Voltage 33h:32h = 2700h; 2700h (=) 2.70 V
        DMC_array[8'h32] = 8'h00;
        DMC_array[8'h33] = 8'h27;
        DMC_array[8'h34] = 6'b100000;
        DMC_array[8'h35] = 8'h38; // binary: 0011 1000
        DMC_array[8'h36] = 2'b01;
        DMC_array[8'h37] = 8'hFF; // RESERVED
        begin
            for (i=37;i>=31;i=i-1)
            begin
                DMC_tmp = DMC_array[8'h00-i+37];
                for(j=7;j>=0;j=j-1)
                begin
                    DMC_array_tmp[8*i+j] = DMC_tmp[j];
                end
            end
            for (i=30;i>=24;i=i-1)
            begin
                DMC_tmp = DMC_array[8'h08-i+30];
                for(j=7;j>=0;j=j-1)
                begin
                    DMC_array_tmp[8*i+j] = DMC_tmp[j];
                end
            end
            for (i=23;i>=21;i=i-1)
            begin
                DMC_tmp = DMC_array[8'h10-i+23];
                for(j=7;j>=0;j=j-1)
                begin
                    DMC_array_tmp[8*i+j] = DMC_tmp[j];
                end
            end
            for (i=20;i>=14;i=i-1)
            begin
                DMC_tmp = DMC_array[8'h18-i+20];
                for(j=7;j>=0;j=j-1)
                begin
                    DMC_array_tmp[8*i+j] = DMC_tmp[j];
                end
            end
            for (i=13;i>=11;i=i-1)
            begin
                DMC_tmp = DMC_array[8'h20-i+13];
                for(j=7;j>=0;j=j-1)
                begin
                    DMC_array_tmp[8*i+j] = DMC_tmp[j];
                end
            end
            for (i=10;i>=7;i=i-1)
            begin
                DMC_tmp = DMC_array[8'h24-i+10];
                for(j=7;j>=0;j=j-1)
                begin
                    DMC_array_tmp[8*i+j] = DMC_tmp[j];
                end
            end
            for (i=6;i>=0;i=i-1)
            begin
                DMC_tmp = DMC_array[8'h30-i+6];
                for(j=7;j>=0;j=j-1)
                begin
                    DMC_array_tmp[8*i+j] = DMC_tmp[j];
                end
            end
        end
    end
    ///////////////////////////////////////////////////////////////////////////

    //Power Up time;
    initial
    begin
        PoweredUp = 1'b0;
        #tdevice_PU PoweredUp = 1'b1;
    end

    assign power = PoweredUp;

   always @(posedge DP_in)
   begin:TDPr
     #tdevice_DP DP_out = DP_in;
   end
   always @(negedge DP_in)
   begin:TDPf
     #1 DP_out = DP_in;
   end

   always @(posedge RES_in)
   begin:TRESr
     #tdevice_RES RES_out = RES_in;
   end
   always @(negedge RES_in)
   begin:TRESf
     #1 RES_out = RES_in;
   end

    always @(PoweredUp or falling_edge_CSNeg_ipd)
    begin:CheckCEOnPowerUP
        if ((~PoweredUp) && falling_edge_CSNeg_ipd)
            $display ("Device is selected during Power Up");
    end

    always @(next_state or PoweredUp)
    begin: StateTransition
        if (PoweredUp)
        begin
            current_state = next_state;
        end
    end

///////////////////////////////////////////////////////////////////////////////
// write cycle decode
///////////////////////////////////////////////////////////////////////////////
    integer opcode_cnt = 0;
    integer addr_cnt   = 0;
    integer mode_cnt   = 0;
    integer dummy_cnt  = 0;
    integer data_cnt   = 0;
    integer bit_cnt    = 0;

    reg [2047:0] Data_in = 2048'b0;
    reg [7:0] opcode;
    reg [7:0] opcode_in;
    reg [23:0] addr_bytes;
    reg [23:0] hiaddr_bytes;
    reg [23:0] Address_in;
    reg [7:0] mode_bytes;
    reg [7:0] mode_in;
    reg [7:0] Byte_slv;

    always @(falling_edge_CSNeg_ipd or rising_edge_CSNeg_ipd or
             rising_edge_SCLK_ipd or falling_edge_SCLK_ipd)
    begin: Buscycle
        integer i;
        integer j;
        integer k;
        if (falling_edge_CSNeg_ipd)
        begin
            if (bus_cycle_state==STAND_BY)
            begin
                bus_cycle_state = OPCODE_BYTE;
                Instruct = NONE;
                write = 1'b1;
                opcode_cnt = 0;
                addr_cnt   = 0;
                data_cnt   = 0;
                mode_cnt   = 0;
                dummy_cnt  = 0;
            end
        end        
        if (rising_edge_SCLK_ipd)
        begin
            if (~CSNeg_ipd)
            begin
                case (bus_cycle_state)
                    OPCODE_BYTE :
                    begin
                        if (HOLDNeg_in)
                        begin
                            opcode_in[opcode_cnt] = SI_in;
                            opcode_cnt = opcode_cnt + 1;
                            if (opcode_cnt == BYTE)
                            begin
                                for (i=0;i<=7;i=i+1)
                                begin
                                    opcode[i] = opcode_in[7-i];
                                end
                                case(opcode)
                                    8'b00000110 : // 06h
                                    begin
                                        Instruct = WREN;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b00000100 :  // 04h
                                    begin
                                        Instruct = WRDI;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b10011111 :  // 9Fh
                                    begin
                                        Instruct = RDID;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b00000001 :  // 01h
                                    begin
                                        Instruct = WRR;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b00000101 : // 05h
                                    begin
                                        Instruct = RDSR;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b00000011 :  // 03h
                                    begin
                                        Instruct = READ;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b00001011 : // 0Bh
                                    begin
                                        Instruct = FAST_READ;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b00111011 :  // 3Bh
                                    begin
                                        Instruct = DUAL_READ;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b00100000 : // 20h
                                    begin
                                        Instruct = SE;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b11011000, 8'b01010010 : // D8h or 52h
                                    begin
                                        Instruct = BE64;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b11000111, 8'b01100000 : // C7h or 60h
                                    begin
                                        Instruct = CE;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b00000010: // 02h
                                    begin
                                        Instruct = PP;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b10111001: // B9h
                                    begin
                                        Instruct = DP;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b10101011: // ABh
                                    begin
                                        Instruct = RES_RD_ES;
                                        bus_cycle_state = DUMMY_BYTES;
                                    end
                                    8'b10010000: // 90h
                                    begin
                                        Instruct = REMS;
                                        bus_cycle_state = DUMMY_BYTES;
                                    end
                                    8'b10110001: // B1h
                                    begin
                                        Instruct = ENSO;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b11000001: // C1h
                                    begin
                                        Instruct = EXSO;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b00101011: // 2Bh
                                    begin
                                        Instruct = RDSCUR;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b00101111: // 2Fh
                                    begin
                                        Instruct = WRSCUR;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b01011010: // 5Ah
                                    begin
                                        Instruct = RDDMC;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                endcase
                            end
                        end
                        else
                            $display("Device is in HOLD mode");
                    end  // end of OPCODE_BYTE

                    ADDRESS_BYTES :
                    begin
                        if (HOLDNeg_in)
                        begin
                            if ((Instruct == READ   || Instruct == FAST_READ ||
                                Instruct == DUAL_READ || Instruct == SE      ||
                                Instruct == BE64      || Instruct == PP      ||
                                Instruct == RDDMC     || Instruct == REMS) 
                                && HOLDNeg_in)
                            begin
                                Address_in[addr_cnt] = SI_in;
                                addr_cnt = addr_cnt + 1;
                                if (addr_cnt == BYTE && Instruct == REMS)
                                begin
                                    for (i=7;i>=0;i=i-1)
                                    begin
                                        addr_bytes[7-i] = Address_in[i];
                                    end
                                    Address = addr_bytes ;
                                    change_addr = 1'b1;
                                    #1000 change_addr = 1'b0;
                                    bus_cycle_state = DATA_BYTES;
                                end
                                else if (addr_cnt == 3*BYTE)
                                begin
                                    for (i=23;i>=0;i=i-1)
                                    begin
                                        addr_bytes[23-i] = Address_in[i];
                                    end
                                    Address = addr_bytes ;
                                    change_addr = 1'b1;
                                    #1000 change_addr = 1'b0;
                                    if (Instruct == READ || Instruct == SE ||
                                        Instruct == BE64 || Instruct == PP)
                                        bus_cycle_state = DATA_BYTES;
                                    else
                                        bus_cycle_state = DUMMY_BYTES;
                                end        
                            end
                        end
                        else
                            $display("Device is in HOLD mode");
                    end  // end of ADDRESS_BYTE

                    DUMMY_BYTES :
                    begin
                        if (HOLDNeg_in)
                        begin
                            dummy_cnt = dummy_cnt + 1;
                            if (dummy_cnt == BYTE && (Instruct == FAST_READ || 
                                Instruct == DUAL_READ || Instruct == RDDMC))
                                bus_cycle_state = DATA_BYTES;
                            else if (dummy_cnt == 2*BYTE && Instruct == REMS)
                                bus_cycle_state = ADDRESS_BYTES;
                            else if (dummy_cnt == 3*BYTE) 
                            // 3 dummy bytes are only for RES_RD_ES
                                bus_cycle_state = DATA_BYTES;
                        end
                        else
                            $display("Device is in HOLD mode");
                    end  // end of DUMMY_BYTES

                    DATA_BYTES : 
                    begin
                        if (HOLDNeg_in)
                        begin
                            if (data_cnt > 2047)
                            //In case of serial mode and PP, if more than 256
                            //bytes are sent to the device
                            begin
                                if (bit_cnt == 0)
                                begin
                                    for (i=0;i<=(255*BYTE-1);i=i+1)
                                    begin
                                        Data_in[i] = Data_in[i+8];
                                    end
                                end
                                Data_in[2040 + bit_cnt] = SI_in;
                                bit_cnt = bit_cnt + 1;
                                if (bit_cnt == 8)
                                begin
                                    bit_cnt = 0;
                                end
                                data_cnt = data_cnt + 1;
                            end
                            else
                            begin
                                Data_in[data_cnt] = SI_in;
                                data_cnt = data_cnt + 1;
                                bit_cnt = 0;
                            end
                        end
                        else
                            $display("Device is in HOLD mode");
                    end  // end of DATA_BYTES
                endcase
            end
        end
        if (falling_edge_SCLK_ipd)
        begin
            if ((bus_cycle_state == DATA_BYTES) && (~CSNeg_ipd))
            begin
                if ((Instruct == RDID      || Instruct == RDSR      || 
                     Instruct == READ      || Instruct == FAST_READ || 
                     Instruct == DUAL_READ || Instruct == RES_RD_ES || 
                     Instruct == REMS      || Instruct == RDSCUR    || 
                     Instruct == RDDMC) && HOLDNeg_in)
                begin
                    read_out = 1'b1;
                    #1 read_out = 1'b0;
                end
            end
        end
        if (rising_edge_CSNeg_ipd)
        begin
            if ((bus_cycle_state != DATA_BYTES) &&
                (bus_cycle_state != DUMMY_BYTES))
            begin
                bus_cycle_state = STAND_BY;
            end
            else
            begin
                if (bus_cycle_state == DUMMY_BYTES)
                begin
                    bus_cycle_state = STAND_BY;
                    if (HOLDNeg_in && (Instruct == RES_RD_ES) &&
                    (dummy_cnt == 0))
                        write = 1'b0;
                end
                else if (bus_cycle_state == DATA_BYTES)
                begin
                    bus_cycle_state = STAND_BY;    

                        case (Instruct)
                            WREN,
                            WRDI,
                            SE,
                            BE64,
                            CE,
                            DP,
                            ENSO,
                            EXSO:
                            begin
                                if (data_cnt == 0)
                                    write = 1'b0;
                            end

                            RES_RD_ES:
                            begin
                                write = 1'b0;
                            end

                            WRR:
                            begin
                                if (data_cnt == 8 )
                                begin
                                    if (!(SRWD && ~WPNeg_in))
                                    begin
                                        write = 1'b0;
                                        Status_reg_in = Data_in[7:0];
                                    end
                                    else
                                        write = 1'b0;
                                        $display("Can't write to status reg");
                                        $display("Write protect mode is on");
                                end
                            end

                            WRSCUR:
                            begin
                                if ((data_cnt == 8 ) && (~LDSO))
                                begin
                                    write = 1'b0;
                                    Security_reg_in = Data_in[7:0];
                                end
                                else
                                    $display("Security reg can't be changed");
                            end

                            PP:
                            begin
                                if (data_cnt > 0)
                                begin
                                    if ((data_cnt % 8) == 0)
                                    begin
                                        write = 1'b0;
                                        for (i=0;i<=255;i=i+1)
                                        begin
                                            for (j=7;j>=0;j=j-1)
                                            begin
                                                Byte_slv[j] =
                                                Data_in[(i*8) + (7-j)];
                                            end
                                            WByte[i] = Byte_slv;
                                        end
                                        if (data_cnt > 256*BYTE)
                                            Byte_number = 255;
                                        else
                                            Byte_number = ((data_cnt/8) - 1);
                                    end
                                end
                            end
                        endcase
                end
            end
        end
    end // end of Buscycle

    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the Page Program
    ///////////////////////////////////////////////////////////////////////////
    event pdone_event;

    always @(PSTART)
    begin
        if (PSTART && PDONE)
        begin
            PDONE = 1'b0;
            ->pdone_event;
        end
    end

    always @(pdone_event)
    begin:pdone_process
        PDONE = 1'b0;
        #tdevice_PP PDONE = 1'b1;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the Write Status Register Operation
    // start
    ///////////////////////////////////////////////////////////////////////////
    event wdone_event;

    always @(WSTART)
    begin
        if (WSTART && WDONE)
        begin
            WDONE = 1'b0;
            ->wdone_event;
        end
    end

    always @(wdone_event)
    begin:wdone_process
        WDONE = 1'b0;
        #tdevice_WRR WDONE = 1'b1;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Timing control for the Erase Operations
    ///////////////////////////////////////////////////////////////////////////
    time duration_erase;

    event edone_event;

    always @(ESTART)
    begin: erase
        if (ESTART && EDONE)
        begin
            if (Instruct == CE)
            begin
                duration_erase = tdevice_BE;
            end
            else if (Instruct == BE64)
            begin
                duration_erase = tdevice_SE64;
            end
            else
            begin
                duration_erase = tdevice_SE4;
            end

            EDONE = 1'b0;
            ->edone_event;
        end
    end

    always @(edone_event)
    begin : edone_process
        EDONE = 1'b0;
        #duration_erase EDONE = 1'b1;
    end

   ////////////////////////////////////////////////////////////////////////////
   // Main Behavior Process
   // combinational process for next state generation
   ////////////////////////////////////////////////////////////////////////////
    reg rising_edge_PDONE   = 1'b0;
    reg rising_edge_EDONE   = 1'b0;
    reg rising_edge_WDONE   = 1'b0;
    reg falling_edge_write  = 1'b0;
    reg rising_edge_DP_out = 1'b0;

    integer i;
    integer j;

    always @(falling_edge_write or rising_edge_PDONE or rising_edge_WDONE
    or rising_edge_EDONE or rising_edge_DP_out or rising_edge_RES_out)
    begin: StateGen1
        if (falling_edge_write)
        begin
            case (current_state)
                IDLE :
                begin
                    if (~write)
                    begin
                        if ((Instruct == WRR) && WEL)
                        begin
                            if (~(Status_reg[7] && (~WPNeg_in)))
                                next_state = WRITE_SR;
                        end

                        else if (Instruct == PP && WEL)
                        begin
                            blck = Address / 24'h10000;
                            if (Block_Prot[blck] == 1'b0)
                                next_state = PAGE_PG;
                        end

                        else if ((Instruct == SE) && WEL)
                        begin
                            blck = Address / 24'h10000;
                            if (Block_Prot[blck] == 1'b0)
                                next_state = SECTOR_ER;
                        end

                        else if ((Instruct == BE64) && WEL)
                        begin
                            blck = Address / 24'h10000;
                            if (Block_Prot[blck] == 1'b0)
                                next_state = BLOCK_ER;
                        end

                        else if ((Instruct == CE) && WEL)
                        begin
                            if (Block_Prot == 16'b0)
                                next_state = CHIP_ER;
                        end

                        else if (Instruct == ENSO)
                            next_state = SECURE_OTP;

                        else
                            next_state = IDLE;

                    end  // end of (~write)
                end  // end of IDLE

                SECURE_OTP :
                begin
                    if (~write)
                    begin
                        if (Instruct == EXSO)
                            next_state = IDLE;

                        else if (Instruct == PP && WEL && ~LDSO && ~SEC_OTP && 
                         ((Address % 12'h100) >= 8'h10) && 
                         ((Address % 12'h100) <= OTPHiAddr))
                            next_state = SC_OTP_PG;                            
                    end
                end
            endcase
        end  // end of falling_edge_write

        if (rising_edge_PDONE)
        begin
            if (current_state == PAGE_PG)
            begin
                next_state = IDLE;
            end
            else if (current_state == SC_OTP_PG)
            begin
                next_state = SECURE_OTP;
            end
        end

        if (rising_edge_WDONE)
        begin
            if (current_state == WRITE_SR)
            begin
                next_state = IDLE;
            end
        end

        if (rising_edge_EDONE)
        begin
            if (current_state == SECTOR_ER || current_state == BLOCK_ER || 
                current_state == CHIP_ER)
            begin
                next_state = IDLE;
            end
        end

        if (rising_edge_RES_out)
        begin
            if (current_state == DP_DOWN)
                next_state = IDLE;
        end

        if (rising_edge_DP_out)
        begin
            if (current_state == IDLE)
                next_state = DP_DOWN;
        end

    end  // end of StateGen1

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general functionality
    ///////////////////////////////////////////////////////////////////////////
    reg rising_edge_read_out = 1'b0;
    reg Instruct_event       = 1'b0;
    reg change_addr_event    = 1'b0;
    reg current_state_event  = 1'b0;
    reg rising_edge_powered  = 1'b0;

    integer WData [0:255];
    integer WOTPData;
    integer Addr;
    integer Addr_tmp;

    always @(oe_event)
    begin
        oe = 1'b1;
        #1 oe = 1'b0;
    end

    always @(rising_edge_read_out or Instruct_event or change_addr_event or
             oe or current_state_event or falling_edge_write or EDONE or WDONE
             or PDONE or CSNeg_ipd or rising_edge_powered or 
             rising_edge_DP_out or rising_edge_RES_out)
    begin: Functionality
    integer i,j;

        if (rising_edge_read_out)
        begin
            if (PoweredUp == 1'b1)
                ->oe_event;
        end

        if (Instruct_event)
        begin
            read_cnt = 0;
            fast_read = 1'b0;
            dual_read = 1'b0;
            slow_read = 1'b0;
            if (current_state == DP_DOWN)
            begin
                if (DP_in == 1'b1)
                begin
                    $display ("Command results can be corrupted ");
                end
            end
        end

        if (rising_edge_powered)
        begin
            Status_reg[4] = 1'b0;// BP2
            Status_reg[3] = 1'b0;// BP1
            Status_reg[2] = 1'b0;// BP0
            change_BP = 1'b1;
            #1 change_BP = 1'b0;
        end 

        if (change_addr_event)
        begin
            read_addr = Address;
        end

        if (oe || current_state_event)
        begin
            case (current_state)
                IDLE,
                SECURE_OTP :
                begin
                    if (oe && ~DP_in)
                    begin
                        if (Instruct == RDSR)
                        begin
                        // Read Status register
                            SOut_zd = Status_reg[7-read_cnt];
                            read_cnt = read_cnt + 1;
                            if (read_cnt == 8)
                                read_cnt = 0;
                        end
                        else if (Instruct == RDID)
                        begin
                            // Read JEDEC ID 
                            ident_out = {Jedec_DeviceID,Jedec_MemTypeID,
                                         Jedec_MemDensity};
                            SOut_zd = ident_out[23-read_cnt];
                            read_cnt  = read_cnt + 1;
                            if (read_cnt == 24)
                                read_cnt = 0;
                        end
                        else if (Instruct == REMS)
                        begin
                            /* Read JEDEC assigned Manufacturer ID 
                               and specific device ID*/
                            if (read_addr % 2 == 0)
                            begin
                                ident_out2 = {Manuf_ID,Device_ID};
                            end
                            else
                            begin
                                ident_out2 = {Device_ID,Manuf_ID};
                            end
                            SOut_zd = ident_out2[15-read_cnt];
                            read_cnt  = read_cnt + 1;
                            if (read_cnt == 16)
                                read_cnt = 0;
                        end
                        else if (Instruct == RDSCUR)
                        begin
                            // Read Security register
                            SOut_zd = Security_reg[7-read_cnt];
                            read_cnt = read_cnt + 1;
                            if (read_cnt == 8)
                                read_cnt = 0;
                        end

                        else if (Instruct == RDDMC)
                        begin
                            // Read DMC array
                            data_out[7:0] = DMC_array[read_addr];
                            SOut_zd = data_out[7-read_cnt];
                            read_cnt = read_cnt + 1;
                            if (read_cnt == 8)
                            begin
                                read_cnt = 0;
                                if (read_addr == 8'h37)
                                    read_addr = 0;
                                else
                                    read_addr = read_addr + 1;
                            end
                        end
                        else if (Instruct == READ || Instruct == FAST_READ)
                        begin
                            //Read Memory array
                            if (Instruct == READ)
                            begin
                                fast_read = 1'b0;
                                slow_read = 1'b1;
                            end
                            else
                            begin
                                fast_read = 1'b1;
                                slow_read = 1'b0;
                            end
                            if (current_state == IDLE)
                            begin
                                data_out[7:0] = Mem[read_addr];
                            end
                            else
                            begin
                                if (read_addr < OTPHiAddr)
                                begin
                                    data_out[7:0] = OTPMem[read_addr];
                                end
                                else
                                begin
                                    $display ("Address is out of OTP range");
                                end
                            end

                            SOut_zd  = data_out[7-read_cnt];
                            read_cnt = read_cnt + 1;
                            if (read_cnt == 8)
                            begin
                                read_cnt = 0;
                                if (read_addr == AddrRANGE)
                                    read_addr = 0;
                                else
                                    read_addr = read_addr + 1;
                            end
                        end
                        else if (Instruct == DUAL_READ)
                        begin
                            // Read memory array (data output on SI & SO)
                            fast_read = 1'b0;
                            slow_read = 1'b0;
                            dual_read = 1'b1;
                            if (current_state == IDLE)
                            begin
                                data_out[7:0] = Mem[read_addr];
                            end
                            else
                            begin
                                data_out[7:0] = OTPMem[read_addr];
                            end
                            SOut_zd       = data_out[7-2*read_cnt];
                            SIOut_zd      = data_out[6-2*read_cnt];
                            read_cnt = read_cnt + 1;
                            if (read_cnt == 4)
                            begin
                                read_cnt = 0;
                                if (read_addr == AddrRANGE)
                                    read_addr = 0;
                                else
                                    read_addr = read_addr + 1;
                            end
                        end
                    end
                    else if (oe && DP_in)
                    begin
                        $display ("Command results can be corrupted ");
                        SOut_zd = 1'bX;
                        read_cnt = read_cnt + 1;
                        if (read_cnt == 8)
                            read_cnt = 0;
                    end  
                end  // end of IDLE

                WRITE_SR,
                PAGE_PG,
                SC_OTP_PG,
                SECTOR_ER,
                BLOCK_ER,
                CHIP_ER :
                begin
                    if (oe && Instruct == RDSR)
                    begin
                    //Read Status Register
                        SOut_zd = Status_reg[7-read_cnt];
                        read_cnt = read_cnt + 1;
                        if (read_cnt == 8)
                            read_cnt = 0;
                    end
                    else if (oe && Instruct == RDSCUR)
                    begin
                    // Read Security register
                        SOut_zd = Security_reg[7-read_cnt];
                        read_cnt = read_cnt + 1;
                        if (read_cnt == 8)
                            read_cnt = 0;
                    end
                end

                DP_DOWN :
                begin
                    if (oe)
                    begin
                    // Read ID
                        if (Instruct == RES_RD_ES)
                        begin
                            data_out[7:0] = ElectronicID;
                            SOut_zd = data_out[7-read_cnt];
                            read_cnt = read_cnt + 1;
                            if (read_cnt == 8)
                                read_cnt = 0;
                        end
                        else
                            $display("DEEP POWER DOWN MODE-NO READS ALLOWED");
                    end
                end

            endcase
        end

        if (falling_edge_write)
        begin
            case (current_state)
                IDLE :
                begin
                    if (~write)
                    begin
                        if (Instruct == WREN)
                            Status_reg[1] = 1'b1;
                        else if (Instruct == WRDI)
                            Status_reg[1] = 1'b0;
                        else if (Instruct == WRR && WEL)
                        begin
                            if (~(Status_reg[7] == 1'b1 && WPNeg_in == 1'b0))
                            begin
                                WSTART = 1'b1;
                                WSTART <= #1 1'b0;
                                Status_reg[0] = 1'b1;
                            end
                            else 
                                Status_reg[1] = 1'b0;
                        end
                        else if ((Instruct == PP) && WEL)
                        begin
                            blck = Address / 24'h10000;
                            if (Block_Prot[blck] == 1'b0)
                            begin
                                PSTART = 1'b1;
                                PSTART <= #1 1'b0;
                                Status_reg[0] = 1'b1; //WIP
                                Addr = Address;
                                Addr_tmp = Address;
                                SA = blck;
                                wr_cnt = Byte_number;
                                for (i=0;i<=wr_cnt;i=i+1)
                                begin
                                    if (Viol != 1'b0)
                                        WData[i] = -1;
                                    else
                                        WData[i] = WByte[i];
                                end
                            end
                            else
                            begin
                                Status_reg[1] = 1'b0;
                            end
                        end
                        else if (Instruct == BE64 && WEL)
                        begin
                            blck = Address / 24'h10000;
                            if (Block_Prot[blck] == 1'b0)
                            begin
                                ESTART = 1'b1;
                                ESTART <= #1 1'b0;
                                Status_reg[0] = 1'b1;
                                Addr = Address;
                            end
                            else
                            begin
                                Status_reg[1] = 1'b0;
                            end
                        end
                        else if (Instruct == CE && WEL)
                        begin
                            if(Status_reg[2]==1'b0 && Status_reg[3]==1'b0 &&
                               Status_reg[4]==1'b0)
                            begin
                                ESTART = 1'b1;
                                ESTART <= #1 1'b0;
                                Status_reg[0] = 1'b1;
                            end
                            else
                            begin
                                Status_reg[1] = 1'b0;
                            end
                        end
                        else if (Instruct == SE && WEL)
                        begin
                            blck = Address / 24'h10000;
                            if (Block_Prot[blck] == 1'b0)
                            begin
                                ESTART = 1'b1;
                                ESTART <= #1 1'b0;
                                Status_reg[0] = 1'b1;
                                Addr = Address;
                            end
                            else
                            begin
                                Status_reg[1] = 1'b0;
                            end
                        end
                        else if (Instruct == DP)
                        begin
                            RES_in <= 1'b0;
                            DP_in  <= 1'b1;
                        end
                        else if (Instruct == WRSCUR)
                        begin
                            for (i=0;i<=7;i=i+1)
                                Security_reg[i] = Security_reg_in[7-i];
                        end
                    end
                end // end of IDLE

                DP_DOWN :
                begin
                    if (~write)
                    begin
                        if (Instruct == RES_RD_ES)
                            RES_in = 1'b1;
                    end
                end

                SECURE_OTP:
                begin
                    if (~write)
                    begin
                        if (Instruct == WREN)
                        begin
                            Status_reg[1] = 1'b1;
                        end
                        else if ((Instruct == PP) && WEL)
                        begin

                            if (~LDSO && ~SEC_OTP)
                            begin
                                Addr = (Address % 12'h100);
                                if (Addr >= 8'h10 && Addr <= OTPHiAddr)
                                begin
                                    PSTART = 1'b1;
                                    PSTART <= #1 1'b0;
                                    Status_reg[0] = 1'b1; //WIP
                                    Addr_tmp = Address;
                                    SA = blck;
                                    wr_cnt = Byte_number;
                                    for (i=0;i<=wr_cnt;i=i+1)
                                    begin
                                        if (Viol != 1'b0)
                                            WData[i] = -1;
                                        else
                                            WData[i] = WByte[i];
                                    end
                                end
                                else
                                    $display("Address is outside OTP range");
                                    Status_reg[1] = 1'b0;
                            end
                            else
                            begin
                                Status_reg[1] = 1'b0;
                                $display("OTP locked-programming not allowed");
                            end
                        end
                    end
                end
            endcase
        end

        if(current_state_event || EDONE)
        begin
            case (current_state)
                BLOCK_ER :
                begin
                    ADDRHILO_BLK(AddrLo, AddrHi, Addr);
                    for (i=AddrLo;i<=AddrHi;i=i+1)
                    begin
                        Mem[i] = -1;
                    end
                    if (EDONE)
                    begin
                        Status_reg[0] = 1'b0;
                        Status_reg[1] = 1'b0;
                        for (i=AddrLo;i<=AddrHi;i=i+1)
                        begin
                            Mem[i] = MaxData;
                        end
                    end
                end
                CHIP_ER :
                begin
                    for (i=0;i<=AddrRANGE;i=i+1)
                    begin
                        Mem[i] = -1;
                    end

                    if (EDONE)
                    begin
                        Status_reg[0] = 1'b0;
                        Status_reg[1] = 1'b0;
                        for (i=0;i<=AddrRANGE;i=i+1)
                        begin
                            Mem[i] = MaxData;
                        end
                    end
                end
                SECTOR_ER :
                begin
                    ADDRHILO_SEC4(AddrLo, AddrHi, Addr);
                    for (i=AddrLo;i<=AddrHi;i=i+1)
                    begin
                        Mem[i] = -1;
                    end
                    if (EDONE)
                    begin
                        Status_reg[0] = 1'b0;
                        Status_reg[1] = 1'b0;
                        for (i=AddrLo;i<=AddrHi;i=i+1)
                        begin
                            Mem[i] =  MaxData;
                        end
                    end
                end
            endcase
        end

        if(current_state_event || WDONE)
        begin
            if (current_state == WRITE_SR)
            begin
                if (WDONE)
                begin
                    Status_reg[0] = 1'b0;//WIP
                    Status_reg[1] = 1'b0;//WEL
                    Status_reg[7] = Status_reg_in[0];//MSB first, SRWD
                    if(~(Status_reg[7] && ~WPNeg_in))
                    begin
                        Status_reg[4] = Status_reg_in[3];// BP2
                        Status_reg[3] = Status_reg_in[4];// BP1
                        Status_reg[2] = Status_reg_in[5];// BP0
                        change_BP = 1'b1;
                        #1 change_BP = 1'b0;
                    end
                end
            end
        end

        if(current_state_event || PDONE)
        begin
            if (current_state == PAGE_PG)
            begin
                ADDRHILO_PG(AddrLo, AddrHi, Addr);
                cnt = 0;

                for (i=0;i<=wr_cnt;i=i+1)
                begin
                    new_int = WData[i];
                    old_int = Mem[Addr + i - cnt];
                    if (new_int > -1)
                    begin
                        new_bit = new_int;
                        if (old_int > -1)
                        begin
                            old_bit = old_int;
                            for(j=0;j<=7;j=j+1)
                                if (~old_bit[j])
                                    new_bit[j]=1'b0;
                            new_int=new_bit;
                        end

                        WData[i]= new_int;
                    end
                    else
                    begin
                        WData[i] = -1;
                    end

                    Mem[Addr + i -cnt] = - 1;

                    if ((Addr + i) == AddrHi)
                    begin
                        Addr = AddrLo;
                        cnt = i + 1;
                    end
                end

                cnt = 0;

                if (PDONE)
                begin
                    Status_reg[0] = 1'b0;//WIP
                    Status_reg[1] = 1'b0;// WEL
                    for (i=0;i<=wr_cnt;i=i+1)
                    begin
                        Mem[Addr_tmp + i - cnt] = WData[i];
                        if ((Addr_tmp + i) == AddrHi)
                        begin
                            Addr_tmp = AddrLo;
                            cnt = i + 1;
                        end
                    end
                end
            end
            else if (current_state == SC_OTP_PG)
            begin

                cnt = 0;

                for (i=0;i<=wr_cnt;i=i+1)
                begin
                    new_int = WData[i];
                    old_int = OTPMem[Addr + i - cnt];
                    if (new_int > -1)
                    begin
                        new_bit = new_int;
                        if (old_int > -1)
                        begin
                            old_bit = old_int;
                            for(j=0;j<=7;j=j+1)
                                if (~old_bit[j])
                                    new_bit[j]=1'b0;
                            new_int=new_bit;
                        end

                        WData[i]= new_int;
                    end
                    else
                    begin
                        WData[i] = -1;
                    end

                    OTPMem[Addr + i -cnt] = - 1;

                    if ((Addr + i) == OTPHiAddr)
                    begin
                        Addr = 8'h10;
                        cnt = i + 1;
                    end
                end

                cnt = 0;

                if (PDONE)
                begin
                    Status_reg[0] = 1'b0;//WIP
                    Status_reg[1] = 1'b0;// WEL
                    for (i=0;i<=wr_cnt;i=i+1)
                    begin
                        OTPMem[Addr_tmp + i - cnt] = WData[i];
                        if ((Addr_tmp + i) == OTPHiAddr)
                        begin
                            Addr_tmp = 8'h10;
                            cnt = i + 1;
                        end
                    end
                end

            end
        end

        //Output Disable Control
        if (CSNeg_ipd )
        begin
            SIOut_zd      = 1'bZ;
            SOut_zd       = 1'bZ;
        end

        if (rising_edge_RES_out)
        begin
            if(RES_out)
            begin
                RES_in = 1'b0;
            end
        end

        if (rising_edge_DP_out)
        begin
            if (current_state == IDLE)
            begin
                DP_in = 1'b0;
            end
        end

    end  // end of Functionality

    ///////////////////////////////////////////////////////////////////////////

    always @(SOut_zd or HOLDNeg_in or SIOut_zd)
    begin
        if (~HOLDNeg_in)
        begin
            hold_mode = 1'b1;
            SIOut_z   = 1'bZ;
            SOut_z    = 1'bZ;
        end
        else
        begin
            if (hold_mode)
            begin
                SIOut_z <= #(tpd_HOLDNeg_SO) SIOut_zd;
                SOut_z  <= #(tpd_HOLDNeg_SO) SOut_zd;
                hold_mode = 1'b0;
            end
            else
            begin
                SIOut_z = SIOut_zd;
                SOut_z  = SOut_zd;
                hold_mode = 1'b0;
            end
        end
    end

// tasks
// Procedure ADDRHILO_BLK
 task ADDRHILO_BLK;
 inout  AddrLOW;
 inout  AddrHIGH;
 input   Addr;
 integer AddrLOW;
 integer AddrHIGH;
 integer Addr;
 integer sector;
 begin
    sector = Addr / 20'h10000;
    AddrLOW = sector * 20'h10000;
    AddrHIGH = sector * 20'h10000 + 16'hFFFF;
 end
 endtask

// Procedure ADDRHILO_PG
 task ADDRHILO_PG;
 inout  AddrLOW;
 inout  AddrHIGH;
 input   Addr;
 integer AddrLOW;
 integer AddrHIGH;
 integer Addr;
 integer page;
 begin

    page = Addr / 16'h100;
    AddrLOW = page * 16'h100;
    AddrHIGH = page * 16'h100 + 8'hFF;

 end
 endtask

// Procedure ADDRHILO_SEC4
 task ADDRHILO_SEC4;
 inout   AddrLOW;
 inout   AddrHIGH;
 input   Addr;
 integer AddrLOW;
 integer AddrHIGH;
 integer Addr;
 begin
    AddrLOW  = (Address/(SecSize_4+1))*(SecSize_4+1);
    AddrHIGH = (Address/(SecSize_4+1))*(SecSize_4+1) + SecSize_4;
 end
 endtask

    // Protected blocks: determined by BP bits (Status register bits 4:2)
    always @(change_BP)
    begin
        if (change_BP)
        begin
            case (Status_reg[4:2])
                3'b000:
                begin
                    Block_Prot = 16'h0;
                end
                3'b001:
                begin
                    Block_Prot[15]    = 1'b1;
                    Block_Prot[14:0]  = 15'b0;
                end
                3'b010:
                begin
                    Block_Prot[15:14] = 2'b11;
                    Block_Prot[13:0]  = 14'b0;
                end
                3'b011:
                begin
                    Block_Prot[15:12] = 4'b1111;
                    Block_Prot[11:0]  = 12'b0;
                end
                3'b100:
                begin
                    Block_Prot[15:8]  = 8'b11111111;
                    Block_Prot[7:0]   = 8'b0;
                end
                3'b101, 3'b110, 3'b111:
                begin
                    Block_Prot = 16'b1111111111111111;
                end
            endcase
        end
    end

    always @(negedge CSNeg_ipd)
    begin
        falling_edge_CSNeg_ipd = 1'b1;
        #1 falling_edge_CSNeg_ipd = 1'b0;
    end

    always @(posedge SCLK_ipd)
    begin
        rising_edge_SCLK_ipd = 1'b1;
        #1 rising_edge_SCLK_ipd = 1'b0;
    end

    always @(negedge SCLK_ipd)
    begin
        falling_edge_SCLK_ipd = 1'b1;
        #1 falling_edge_SCLK_ipd = 1'b0;
    end

    always @(posedge CSNeg_ipd)
    begin
        rising_edge_CSNeg_ipd = 1'b1;
        #1 rising_edge_CSNeg_ipd = 1'b0;
    end

    always @(negedge write)
    begin
        falling_edge_write = 1'b1;
        #1 falling_edge_write = 1'b0;
    end

    always @(posedge PDONE)
    begin
        rising_edge_PDONE = 1'b1;
        #1 rising_edge_PDONE = 1'b0;
    end

    always @(posedge WDONE)
    begin
        rising_edge_WDONE = 1'b1;
        #1 rising_edge_WDONE = 1'b0;
    end

    always @(posedge EDONE)
    begin
        rising_edge_EDONE = 1'b1;
        #1 rising_edge_EDONE = 1'b0;
    end

    always @(posedge RES_out)
    begin
        rising_edge_RES_out = 1'b1;
        #1 rising_edge_RES_out = 1'b0;
    end

    always @(posedge DP_out)
    begin
        rising_edge_DP_out = 1'b1;
        #1 rising_edge_DP_out = 1'b0;
    end

    always @(posedge read_out)
    begin
        rising_edge_read_out = 1'b1;
        #1 rising_edge_read_out = 1'b0;
    end

    always @(posedge PoweredUp)
    begin
        rising_edge_powered = 1'b1;
        #1 rising_edge_powered = 1'b0;
    end

    always @(Instruct)
    begin
        Instruct_event = 1'b1;
        #1 Instruct_event = 1'b0;
    end

    always @(change_addr)
    begin
        change_addr_event = 1'b1;
        #1 change_addr_event = 1'b0;
    end

    always @(current_state)
    begin
        current_state_event = 1'b1;
        #1 current_state_event = 1'b0;
    end

endmodule
