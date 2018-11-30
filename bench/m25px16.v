//////////////////////////////////////////////////////////////////////////////
//  File name : m25px16.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2010 Free Model Foundry; http://www.FreeModelFoundry.com
//
//  MODIFICATION HISTORY:
//
//  version:   |      author:       |   mod date:    |  changes made:
//    V1.0         H.Dimitrijevic      10 May 18       Initial Release
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library: FLASH
//  Technology: FLASH MEMORY
//  Part:       M25PX16
//
//  Description: 16-Mbit, dual I/O, 4-Kbyte subsector erase,
//               serial Flash memory with 75 MHz SPI bus interface
//  Comments :
//      For correct simulation, simulator resolution should be set to 1 ps
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

module m25px16 
(
    C          ,
    SNeg       ,

    DQ0        ,
    DQ1        ,
    WNeg       ,
    HOLDNeg    

);

/////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
/////////////////////////////////////////////////////////////////////////
    input  C          ;    //Serial Clock Input
    input  SNeg       ;    //Chip Select Input

    inout  DQ0        ;    // Serial Data input I(1)
    inout  DQ1        ;    // Serial Data output I/O(2)
    input  WNeg       ;    // Write Protect/Enhanced Program supply voltage
    input  HOLDNeg    ;    // Hold 


    // interconnect path delay signals
    wire  C_ipd           ;
    wire  SNeg_ipd        ;

    wire  DQ0_ipd         ;
    wire  DQ1_ipd         ;
    wire  WNeg_ipd        ;
    wire  HOLDNeg_ipd     ;

    wire   DQ0_in            ;
    assign DQ0_in = DQ0_ipd  ;

    wire   DQ0_out           ;
    assign DQ0_out = DQ0     ;

    wire   DQ1_in              ;
    assign DQ1_in = DQ1_ipd    ;

    wire   DQ1_out             ;
    assign DQ1_out = DQ1       ;

    //  internal delays
    reg DP_in       ;
    reg DP_out      ;
    reg RDP_in      ;
    reg RDP_out     ;

    wire  DQ0_z               ;
    wire  DQ1_z               ;

    reg DQ0_out_zd  = 1'bZ    ;
    reg DQ0_out_z   = 1'bZ    ;

    reg DQ1_out_zd  = 1'bZ    ;
    reg DQ1_out_z   = 1'bZ    ;

    assign DQ0_z  = DQ0_out_z;
    assign DQ1_z  = DQ1_out_z;

    parameter UserPreload       = 1;
    parameter mem_file_name     = "m25px16.mem"; //"none";
    parameter otp_file_name     = "m25px16_OTP.mem";//"none";
    parameter TimingModel       = "DefaultTimingModel";

    parameter PartID        = "m25px16";
    parameter MaxData       = 255; 
    parameter SecNum        = 31;
    parameter SubSecNum     = 512;
    parameter SecSize       = 16'hFFFF;
    parameter SubSecSize    = 12'hFFF;
    parameter PageNum       = 16'h2000;
    parameter HiAddrBit     = 23;
    parameter AddrRANGE     = 24'h1FFFFF;
    parameter OTPSize       = 63;
    parameter OTPLoAddr     = 12'h00;
    parameter OTPHiAddr     = 12'h40;
    parameter BYTE          = 8;
    parameter Manuf_ID      = 8'h20;
    parameter DeviceID      = 16'h7115;
    parameter CFD_length    = 8'h10;
    parameter CFD_content   = 128'h0;

    // If speed simulation is needed uncomment following line

//     `define SPEEDSIM;

    // powerup
    reg PoweredUp = 1'b0;

    //FSM control signals
    reg PDONE    ; // Prog. Done
    reg PSTART   ; // Start Programming

    reg EDONE    ; // Erase Done
    reg ESTART   ; // Start Erasing

    reg WDONE    ; // Writing Done
    reg WSTART   ; // Start writing

    //Command Register
    reg write;
    reg read_out;

    //Sector Protection Status
    reg [SecNum:0] Sec_Prot = 32'b0;

    //Lock reg.
    reg[7:0] Lock_reg [0:SecNum];
    reg[7:0] Lock_reg_in = 8'b0;

    //Status reg.
    reg[7:0] Status_reg      = 8'b0;
    reg[7:0] Status_reg_in   = 8'b0;

    wire WIP;
    wire WEL;
    wire BP0;
    wire BP1;
    wire BP2;
    wire TB;
    wire SRWD;

    assign WIP  = Status_reg[0];
    assign WEL  = Status_reg[1];
    assign BP0  = Status_reg[2];
    assign BP1  = Status_reg[3];
    assign BP2  = Status_reg[4];
    assign TB   = Status_reg[5];
    assign SRWD = Status_reg[7];

    integer Byte_number = 0;
    integer sect;

    //Address
    integer Address = 0;         // 0 - AddrRANGE
    reg  change_addr;
    reg  rd_fast;       // = 1'b1;
    reg  rd_slow;
    reg  dual;
    reg  hold_mode;
    reg  change_BP = 0;

    wire fast_rd;
    wire rd;
    wire pgm;

    // timing check violation
    reg Viol = 1'b0;

    // OTP Memory Array
    integer OTPMem[OTPLoAddr:OTPHiAddr];
    reg[7:0] OTP_ctrl_byte; 
                       
    integer Mem[0:AddrRANGE];

    integer WByte[0:255];
    integer WOTPByte;
    integer AddrLo;
    integer AddrHi;

    reg[7:0]  old_bit, new_bit;
    integer old_int, new_int;
    integer wr_cnt;
    integer cnt;

    integer read_cnt = 0;
    integer read_addr = 0;
    reg[7:0] data_out;
    reg[159:0] ident_out;

    reg oe = 1'b0;
    event oe_event;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////

 buf   (C_ipd, C);
 buf   (SNeg_ipd, SNeg);

 buf   (DQ0_ipd, DQ0);
 buf   (DQ1_ipd, DQ1);
 buf   (WNeg_ipd, WNeg);
 buf   (HOLDNeg_ipd, HOLDNeg);

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
    nmos   (DQ0,  DQ0_z,  1);
    nmos   (DQ1,  DQ1_z,  1);

    wire deg_DQ0;
    wire deg_DQ1;

    wire dual_wr;
    assign dual_wr = deg_DQ0 && deg_DQ1;
    wire dual_rd;
    assign dual_rd = ~deg_DQ0 && ~deg_DQ1 && dual;
    wire power;
    assign power = PoweredUp;

specify
    // tpd delays: propagation delays (pin-to-pin delay within a component)
    // In Verilog is not necessary to declare any tipd_ delay variables,
    // they can be taken from SDF file

     // tpd delays
     specparam           tpd_SNeg_DQ1           =1; //tDIS
     specparam           tpd_C_DQ1              =1; //tV
     specparam           tpd_HOLDNeg_DQ1        =1; //tLZ

     // tsetup values: setup times
     specparam           tsetup_SNeg_C          =1; //tCSS
     specparam           tsetup_DQ0_C           =1; //tDSU
     specparam           tsetup_HOLDNeg_C       =1; //tHLCH,tHHCH
     specparam           tsetup_WNeg_SNeg       =1; //tWHSL

     // thold values: hold times
     specparam           thold_SNeg_C           =1; //tCHSH,tCHSL
     specparam           thold_DQ0_C            =1; //tDH
     specparam           thold_HOLDNeg_C        =1; //tCHHL,tCHHH
     specparam           thold_WNeg_SNeg        =1; //tSHWL

     //tpw values
     specparam           tpw_C_posedge          =1; //tCLH=6ns(75MHz)
     specparam           tpw_C_negedge          =1; //tCLL=6ns(75MHz)
     specparam           tpw_C_rd_posedge       =1; //15ns(33MHz)
     specparam           tpw_C_rd_negedge       =1; //15ns(33MHz)
     specparam           tpw_SNeg_negedge       =1; //tCSH=80ns

     // tperiod min (calculated as 1/max freq)
     specparam           tperiod_C              =1; //fc = 75MHz
     specparam           tperiod_C_rd           =1; //fr = 33MHz

     // tdevice values: values for internal delays
        `ifdef SPEEDSIM
            // Page Program Operation
            specparam   tdevice_PP                     = 3e7;   //tPP/100
                    //SubSector Erase Operation
            specparam   tdevice_SSE                     = 15e7; //tSSE/1000
                    //Sector Erase Operation
            specparam   tdevice_SE                     = 3e9;   //tSE/1000
                    //Bulk Erase Operation
            specparam   tdevice_BE                     = 80e9;   //tBE/1000
                    //Write Status Register Operation
            specparam   tdevice_WR                     = 1e7;   //tW/100
                   //Software Protect Mode
            specparam   tdevice_DP                     = 3e6;   //tDP
                    //Release from Software Protect Mode
            specparam   tdevice_RDP                    = 30e6;  //tRDP
                    //Time delay to write instructions
            specparam   tdevice_PUW                    = 10e9; //tPUW=10 ms;  

        `else
            // Page Program Operation
            specparam   tdevice_PP                     = 5e9;  //tPP=5 ms;
                    //SubSector Erase Operation
            specparam   tdevice_SSE                    = 15e10;//tSSE=150 ms;
                    //Sector Erase Operation
            specparam   tdevice_SE                     = 3e12; //tSE=3 s;
                    //Bulk Erase Operation
            specparam   tdevice_BE                     = 80e12; //tBE=80 s;
                    //Write Status Register Operation
            specparam   tdevice_WR                     = 15e9; //tW=15 ms;
                   //Software Protect Mode
            specparam   tdevice_DP                     = 3e6;  //tDP=3 us;
                    //Release from Software Protect Mode
            specparam   tdevice_RDP                    = 30e6; //tRDP=30 us;
                    //Time delay to write instructions
            specparam   tdevice_PUW                    = 10e9; //tPUW=10 ms;   
  
        `endif//SPEEDSIM

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
    if (SNeg) (SNeg => DQ1) = tpd_SNeg_DQ1;
    if (dual && SNeg) (SNeg => DQ0) = tpd_SNeg_DQ1;

       (C => DQ1) = tpd_C_DQ1;
    if (dual) (C => DQ0) = tpd_C_DQ1;

       (HOLDNeg => DQ1) = tpd_HOLDNeg_DQ1;
    if (dual)(HOLDNeg => DQ0) = tpd_HOLDNeg_DQ1;

///////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                          //
///////////////////////////////////////////////////////////////////////////////
        $setup ( DQ0              , posedge C &&& deg_DQ0,
                                               tsetup_DQ0_C  ,    Viol);
        $setup ( DQ1              , posedge C &&& dual_wr,
                                               tsetup_DQ0_C  ,    Viol);
        $setup ( negedge SNeg     , posedge C &&& power,
                                               tsetup_SNeg_C ,    Viol);
        $setup ( posedge SNeg     , posedge C &&& power,
                                               tsetup_SNeg_C ,    Viol);
        $setup ( negedge HOLDNeg  , posedge C &&& power,
                                               tsetup_HOLDNeg_C , Viol);
        $setup ( posedge HOLDNeg  , posedge C &&& power,
                                               tsetup_HOLDNeg_C , Viol);
        $setup ( posedge WNeg     , negedge SNeg &&& power,
                                               tsetup_WNeg_SNeg , Viol);

        $hold ( posedge C  &&& deg_DQ0 , DQ0 ,
                                                thold_DQ0_C  ,    Viol);
        $hold ( posedge C  &&& dual_wr , DQ1 ,
                                                thold_DQ0_C  ,    Viol);
        $hold ( posedge C  &&& power   , posedge SNeg ,
                                                thold_SNeg_C ,    Viol);
        $hold ( posedge C  &&& power   , negedge SNeg ,
                                                thold_SNeg_C ,    Viol);
        $hold ( posedge C  &&& power   , posedge HOLDNeg ,
                                                thold_HOLDNeg_C , Viol);
        $hold ( posedge C  &&& power   , negedge HOLDNeg ,
                                                thold_HOLDNeg_C , Viol);

        $hold ( posedge SNeg  &&& power   , posedge WNeg ,
                                                thold_WNeg_SNeg , Viol);

        $width (posedge C &&& pgm  , tpw_C_posedge);
        $width (negedge C &&& pgm  , tpw_C_posedge);
        $width (posedge C &&& rd   , tpw_C_rd_posedge);
        $width (negedge C &&& rd   , tpw_C_rd_posedge);
        $width (negedge SNeg       , tpw_SNeg_negedge);

        $period (posedge C &&& pgm , tperiod_C);
        $period (posedge C &&& rd  , tperiod_C_rd);

endspecify
///////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                       //
///////////////////////////////////////////////////////////////////////////////

// FSM states
 parameter IDLE            =4'd0;
 parameter WRITE_SR        =4'd1;
 parameter DP_DOWN_WAIT    =4'd2;
 parameter DP_DOWN         =4'd3;
 parameter SUBSEC_ER       =4'd4;
 parameter SEC_ER          =4'd5;
 parameter BULK_ER         =4'd6;
 parameter PAGE_PG         =4'd7;
 parameter OTP_PG          =4'd8;

 reg [3:0] current_state;
 reg [3:0] next_state;

// Instruction
 parameter NONE            =5'd0;
 parameter WREN            =5'd1;  
 parameter WRDI            =5'd2;
 parameter RDID            =5'd3;
 parameter RDSR            =5'd4; 
 parameter WRSR            =5'd5;
 parameter WRLR            =5'd6; 
 parameter RDLR            =5'd7;
 parameter READ            =5'd8;
 parameter FAST_READ       =5'd9;
 parameter DOFR            =5'd10;
 parameter ROTP            =5'd11;
 parameter POTP            =5'd12;
 parameter PP              =5'd13;
 parameter DIFP            =5'd14;
 parameter SSE             =5'd15; 
 parameter SE              =5'd16;
 parameter BE              =5'd17; 
 parameter DP              =5'd18; 
 parameter RDP             =5'd19;

 reg [4:0] Instruct;

//Bus cycle states
 parameter STAND_BY        =3'd0;
 parameter OPCODE_BYTE     =3'd1;
 parameter ADDRESS_BYTES   =3'd2;
 parameter DUMMY_BYTES     =3'd3;
 parameter DATA_BYTES      =3'd4;

 reg [2:0] bus_cycle_state;

 reg deq_DQ0;
    always @(DQ0_in, DQ0_z)
    begin
        if (DQ0_in == DQ0_z)
            deq_DQ0=1'b0;
        else
            deq_DQ0=1'b1;
    end
    // check when data is generated from model to avoid setuphold check in
    // those occasion
    assign deg_DQ0=deq_DQ0 && ~dual;

 reg deq_DQ1;
    always @(DQ1_in, DQ1_z)
    begin
        if (DQ1_in == DQ1_z)
            deq_DQ1=1'b0;
        else
            deq_DQ1=1'b1;
    end
    // check when data is generated from model to avoid setuphold check in
    // those occasion
    assign deg_DQ1=deq_DQ1;

///////////////////////////////////////////////////////////////////////////////
// initialize memory and load preload files if any
///////////////////////////////////////////////////////////////////////////////
    initial
    begin: InitMemory
        integer i;
        for (i=0;i<=AddrRANGE;i=i+1)
        begin
            Mem[i]=MaxData;
        end
        // File Read Section
        // m25px16.mem, memory preload file
        //   /       - comment
        //   @aaaaaa - <aaaaaa> stands for address
        //   dd    - <dd> is byte to be written at Mem(aaaaaa++)
        //           (aaaaaa is incremented at every load)
        //   NO empty lines !!!
        if ((UserPreload) && !(mem_file_name == "none"))
            $readmemh(mem_file_name, Mem);

        for (i=OTPLoAddr;i<=OTPHiAddr;i=i+1)
        begin
            OTPMem[i] = MaxData;
        end

        if (UserPreload && !(otp_file_name == "none"))
        begin
        // m25px16_otp memory file
        //   /       - comment
        //   @aaaaaa     - <aaaaaa> stands for address within last defined
        //   sector
        //   dd      - <dd> is byte to be written at OTPMem(aaa++)
        //   (aa is incremented at every load)
        //   only first 1-4 columns are loaded. NO empty lines !!!!!!!!!!!!!!!!
           $readmemh(otp_file_name,OTPMem);
        end

        OTP_ctrl_byte[7:0] = OTPMem[64];
    end

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
        RDP_in      = 1'b0;
        RDP_out     = 1'b0;
        Instruct    = NONE;

        bus_cycle_state = STAND_BY;
        current_state   = IDLE;
        next_state      = IDLE;        
    end

    initial
    begin : LockReg
        integer i;
        integer j;
        for(i=0;i<=SecNum;i=i+1)
        begin
            for(j=0;j<=7;j=j+1)
            begin
                Lock_reg[i][j] = 1'b0;
            end
        end
    end

    //Power Up time;
    initial
    begin
        PoweredUp = 1'b0;
        #tdevice_PUW PoweredUp = 1'b1;
    end

    always @(posedge DP_in)
    begin:TDPr
      #tdevice_DP DP_out = DP_in;
    end
    always @(negedge DP_in)
    begin:TDPf
      #1 DP_out = DP_in;
    end

    always @(posedge RDP_in)
    begin:TRDPr
      #tdevice_RDP RDP_out = RDP_in;
    end
    always @(negedge RDP_in)
    begin:TRDPf
      #1 RDP_out = RDP_in;
    end

    always @(next_state or PoweredUp)
    begin: StateTransition
        if (PoweredUp)
        begin
            current_state =#(1000) next_state;
        end
    end

    always @(SNeg_ipd)
    begin:CheckCEOnPowerUP
        if ((~PoweredUp) && (~SNeg_ipd))
            $display ("Device is selected during Power Up");
    end

//////////////////////////////////////////////////////////////////////////////
//   Instruction cycle decode
//////////////////////////////////////////////////////////////////////////////
 integer opcode_cnt = 0;
 integer addr_cnt   = 0;
 integer dummy_cnt  = 0;
 integer data_cnt   = 0;
 integer bit_cnt    = 0;
 integer dual_data_in[0:1023];

 reg[2047:0] Data_in = 2048'b0;
 reg [1:0] dual_nybble;
 reg [1:0] dual_slv;
 reg[7:0] code = 8'b0;
 reg[7:0] code_in = 8'b0;
 reg[7:0] Byte_slv = 8'b0;
 reg[HiAddrBit:0] addr_bytes;
 reg[23:0] Address_in = 8'b0;

 reg rising_edge_SNeg_ipd   = 1'b0;
 reg falling_edge_SNeg_ipd  = 1'b0;
 reg rising_edge_C_ipd      = 1'b0;
 reg falling_edge_C_ipd     = 1'b0;

    always @(falling_edge_C_ipd or rising_edge_C_ipd
             or rising_edge_SNeg_ipd or falling_edge_SNeg_ipd or HOLDNeg_ipd or DQ0_in)
    begin: Buscycle1
        integer i;
        integer j;
        integer k;
        if (falling_edge_SNeg_ipd)
        begin
            if (bus_cycle_state==STAND_BY)
            begin
                bus_cycle_state = OPCODE_BYTE;
                Instruct = NONE;
                write = 1'b1;
                opcode_cnt = 0;
                addr_cnt   = 0;
                dummy_cnt  = 0;
                data_cnt   = 0;
            end
        end

        if (rising_edge_C_ipd)
        begin
            if (~SNeg_ipd)  //Falling edge on Chip Select (S#) is required
                            //prior to the start of any instruction
            begin
                case (bus_cycle_state)
                    OPCODE_BYTE :
                    begin
                        if (HOLDNeg_ipd)
                        begin
                            code_in[opcode_cnt] = DQ0_in;
                            opcode_cnt = opcode_cnt + 1;
                            if (opcode_cnt == BYTE)
                            begin
                                for (i=0;i<=7;i=i+1)
                                begin
                                    code[i] = code_in[7-i];
                                end
                                case(code)
                                    8'b00000110 : //06h
                                    begin
                                        Instruct = WREN;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b00000100 : //04h
                                    begin
                                        Instruct = WRDI;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b10011111 ://9Fh
                                    begin
                                        Instruct = RDID;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b10011110 ://9Eh
                                    begin
                                        Instruct = RDID;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b00000101 : //05h
                                    begin
                                        Instruct = RDSR;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b00000001 : //01h
                                    begin
                                        Instruct = WRSR;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b11100101 : //E5h
                                    begin
                                        Instruct = WRLR;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b11101000 : //E8h
                                    begin
                                        Instruct = RDLR;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b00000011 ://03h
                                    begin
                                        Instruct = READ;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b00001011 ://0Bh
                                    begin
                                       Instruct = FAST_READ;
                                       bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b00111011 ://3Bh
                                    begin
                                        Instruct = DOFR;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b01001011 ://4Bh
                                    begin
                                        Instruct = ROTP;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b01000010 ://42h
                                    begin
                                        Instruct = POTP;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b00000010 : //02h
                                    begin
                                        Instruct = PP;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b10100010 : //A2h
                                    begin
                                        Instruct = DIFP;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b00100000 : //20h
                                    begin
                                        Instruct = SSE;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b11011000 : //D8h
                                    begin
                                        Instruct = SE;
                                        bus_cycle_state = ADDRESS_BYTES;
                                    end
                                    8'b11000111 : //C7h
                                    begin
                                        Instruct = BE;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b10111001 : //B9h
                                    begin
                                        Instruct = DP;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                    8'b10101011 : //ABh
                                    begin
                                        Instruct = RDP;
                                        bus_cycle_state = DATA_BYTES;
                                    end
                                endcase
                            end
                        end
                    end

                    ADDRESS_BYTES :
                    begin 
                        if (HOLDNeg_ipd)
                        begin                       
                            Address_in[addr_cnt] = DQ0_in;
                            addr_cnt = addr_cnt + 1;
                            if (addr_cnt == 3*BYTE)
                            begin
                                for (i=23;i>=0;i=i-1)
                                begin
                                    addr_bytes[23-i] = Address_in[i];
                                end
                                Address = addr_bytes;
                                change_addr = 1'b1;
                                #1 change_addr = 1'b0;
                                if (Instruct == DOFR || Instruct == FAST_READ || Instruct == ROTP)
                                    bus_cycle_state = DUMMY_BYTES;
                                else
                                    bus_cycle_state = DATA_BYTES;
                            end
                        end
                    end

                    DUMMY_BYTES :
                    begin
                        if (HOLDNeg_ipd)
                        begin 
                            dummy_cnt = dummy_cnt + 1;
                            if (dummy_cnt == BYTE)
                                bus_cycle_state = DATA_BYTES;
                        end
                    end

                    DATA_BYTES :
                    begin
                        if (HOLDNeg_ipd)
                        begin
                            if(Instruct == DIFP)
                            begin
                                dual_nybble = {DQ1_in, DQ0_in};
                                if(data_cnt > 1023)
                                begin
                                    //In case of DIFP,
                                    //if more than 256 bytes are sent to the device
                                    if(bit_cnt == 0)
                                    begin
                                        for(i=0;i<=1019;i=i+1)
                                        begin
                                            dual_data_in[i] = dual_data_in[i+4];
                                        end
                                    end
                                    dual_data_in[1020 + bit_cnt] = dual_nybble;
                                    bit_cnt = bit_cnt + 1;
                                    if(bit_cnt == 4)
                                    begin
                                        bit_cnt = 0;
                                    end
                                    data_cnt = data_cnt + 1;
                                end
                                else
                                begin
                                    if(dual_nybble !== 2'bZZ)
                                    begin
                                        dual_data_in[data_cnt] = dual_nybble;
                                    end
                                    data_cnt = data_cnt + 1;
                                    if((data_cnt % 4)== 0)
                                        Byte_number = data_cnt/4 -1;
                                end
                            end
                            else
                            begin
                                if (data_cnt > 2047)
                             //If more than 256 bytes are sent to the device
                                begin
                                    if (bit_cnt == 0)
                                    begin
                                        for (i=0;i<=(255*BYTE-1);i=i+1)
                                        begin
                                            Data_in[i] = Data_in[i+8];
                                        end
                                    end
                                    Data_in[2040 + bit_cnt] = DQ0_in;
                                    bit_cnt = bit_cnt + 1;
                                    if (bit_cnt == 8)
                                    begin
                                        bit_cnt = 0;
                                    end
                                    data_cnt = data_cnt + 1;
                                end
                                else
                                begin
                                    Data_in[data_cnt] = DQ0_in;
                                    data_cnt = data_cnt + 1;
                                    bit_cnt = 0;
                                end
                            end
                        end
                    end
                endcase
            end
        end

        if (falling_edge_C_ipd)
        begin
            if ((bus_cycle_state == DATA_BYTES) && (~SNeg_ipd))
            begin
                if ((Instruct == READ || Instruct == FAST_READ ||
                     Instruct == DOFR || Instruct == ROTP || Instruct == RDID ||
                     Instruct == RDSR || Instruct == RDLR) && HOLDNeg_ipd)
                begin
                    read_out = 1'b1;
                    #1 read_out = 1'b0;
                end
            end
        end

        if (rising_edge_SNeg_ipd)
        begin
            if ((bus_cycle_state != DATA_BYTES) &&
                (bus_cycle_state != DUMMY_BYTES))
            begin
                bus_cycle_state = STAND_BY;
            end
            else
            begin
                if (bus_cycle_state == DATA_BYTES)
                begin
                    bus_cycle_state = STAND_BY;
                    if (HOLDNeg_ipd)
                    begin
                        case (Instruct) 
                            PP :
                            begin
                                if ((data_cnt % 8) == 0 && data_cnt > 0)
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

                            DIFP :
                            begin
                                if((data_cnt % 4) == 0 && data_cnt > 0)
                                begin
                                    write = 1'b0;
                                    for(i=0;i<=255;i=i+1)
                                    begin
                                        for(j=3;j>=0;j=j-1)
                                        begin
                                            dual_slv = dual_data_in[(i*4)+(3-j)];
                                            if (j==3)
                                                    Byte_slv[7:6] = dual_slv;
                                            else if (j==2)
                                                    Byte_slv[5:4] = dual_slv;
                                            else if (j==1)
                                                    Byte_slv[3:2] = dual_slv;
                                            else
                                                    Byte_slv[1:0] = dual_slv;
                                        end
                                        WByte[i] = Byte_slv;
                                    end
                                    if(data_cnt > 1024)
                                        Byte_number = 255;
                                    else
                                        Byte_number = ((data_cnt/4)-1);
                                end
                            end

                            POTP :
                            begin
                                if ((data_cnt % 8) == 0 && data_cnt > 0)
                                begin
                                    write = 1'b0;
                                    for (i=0;i<=64;i=i+1)
                                    begin
                                        for (j=7;j>=0;j=j-1)
                                        begin
                                            Byte_slv[j] =
                                            Data_in[(i*8) + (7-j)];
                                        end
                                        WByte[i] = Byte_slv;
                                    end
                                    if (data_cnt > 65*BYTE)
                                        Byte_number = 64;
                                    else
                                        Byte_number = ((data_cnt/8) - 1);
                                end
                            end

                            WREN,
                            WRDI,
                            SE,
                            SSE,
                            BE,
                            DP,
                            RDP:
                            begin
                                if (data_cnt == 0)
                                    write = 1'b0;
                            end

                            WRSR :
                            begin
                                if(!(SRWD && ~WNeg_ipd))
                                begin
                                    if (data_cnt == 8)
                                    begin
                                        write = 1'b0;
                                        for(i=0;i<=7;i=i+1)
                                        begin
                                            Status_reg_in[i]= Data_in[7-i];
                                        end
                                    end
                                end
                                else
                                    write = 1'b0;
                            end

                            WRLR :
                            begin
                                if (data_cnt == 8)
                                begin
                                    write = 1'b0;
                                    for(i=0;i<=7;i=i+1)
                                    begin
                                        Lock_reg_in[i]= Data_in[7-i];
                                    end
                                end
                            end
                        endcase
                    end
                end
            end
        end
    end

///////////////////////////////////////////////////////////////////////////////
//// Timing control for the Program Operations
//// start
///////////////////////////////////////////////////////////////////////////////
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

///////////////////////////////////////////////////////////////////////////////
//// Timing control for the Write Status Register Operation
//// start
///////////////////////////////////////////////////////////////////////////////

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
        #tdevice_WR WDONE = 1'b1;
    end
///////////////////////////////////////////////////////////////////////////////
//// Timing control for the Erase Operations
///////////////////////////////////////////////////////////////////////////////
 time duration_erase;

    event edone_event;

    always @(ESTART)
    begin: erase
        if (ESTART && EDONE)
        begin
            if (Instruct == SSE)
            begin
                duration_erase = tdevice_SSE;
            end
            else if (Instruct == SE) 
            begin
                duration_erase = tdevice_SE;
            end
            if (Instruct == BE)
            begin
                duration_erase = tdevice_BE;
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

///////////////////////////////////////////////////////////////////////////////
//  Main Behavior Process
//  Combinational process for next state generation
///////////////////////////////////////////////////////////////////////////////
    reg rising_edge_PDONE = 1'b0;
    reg rising_edge_EDONE = 1'b0;
    reg rising_edge_WDONE = 1'b0;
    reg rising_edge_DP_out = 1'b0;
    reg falling_edge_write = 1'b0;
    reg lock = 1'b0;
    integer i;
    integer j;

    always @(falling_edge_write  or rising_edge_WDONE
    or rising_edge_EDONE)
    begin: StateGen1
        if (falling_edge_write)
        begin
            case (current_state)
                IDLE :
                begin
                    if (~write)
                    begin
                        if ((Instruct == WRSR) && WEL)
                        begin
                            if (~(SRWD && (~WNeg_ipd)))
                                next_state = WRITE_SR;
                            else
                                next_state = IDLE;
                        end

                        else if ((Instruct == PP || Instruct == DIFP) && WEL)
                        begin
                            sect = Address / 24'h10000;
                            if (Lock_reg[sect][0] == 1'b0 && Sec_Prot[sect] == 1'b0 )
                                next_state = PAGE_PG;
                            else
                                next_state = IDLE;
                        end

                        else if (Instruct == POTP && WEL)
                        begin
                            if (OTP_ctrl_byte[3:0]== 4'hF && 
                            ((Address >= OTPLoAddr) && (Address <= OTPHiAddr)))
                                next_state =  OTP_PG;
                            else
                                next_state =  IDLE;  
                        end

                        else if (Instruct == SSE && WEL)
                        begin
                            sect = Address / 24'h10000;
                            if (Lock_reg[sect][0] == 1'b0 && Sec_Prot[sect] == 1'b0)
                                next_state = SUBSEC_ER;
                            else
                                next_state = IDLE;
                        end

                        else if (Instruct == SE && WEL)
                        begin
                            sect = Address / 24'h10000;
                            if (Lock_reg[sect][0] == 1'b0 && Sec_Prot[sect] == 1'b0)
                                next_state = SEC_ER;
                            else
                                next_state = IDLE;
                        end

                        else if (Instruct == BE && WEL)
                        begin
                            if (BP2==1'b0 && BP1==1'b0 && BP0==1'b0)
                            begin
                                for(i=0;i<=SecNum;i=i+1)
                                begin
                                    for(j=0;j<=7;j=j+1)
                                    begin
                                        if (Lock_reg[i][j] == 1'b0)
                                        begin 
                                            if (lock == 1'b0)
                                                next_state = BULK_ER;
                                            else
                                                next_state = IDLE;
                                        end
                                        else
                                        begin
                                            lock = 1'b1;
                                            next_state = IDLE;
                                        end
                                    end
                                end
                            end
                        end

                        else if ((Instruct == DP) && PDONE && EDONE)
                            next_state = DP_DOWN_WAIT;
                        else
                            next_state = IDLE;
                    end
                end

                DP_DOWN :
                begin
                    if (~write)
                    begin
                        if (Instruct == RDP)
                            next_state = IDLE;
                    end
                end
            endcase
        end

        if (rising_edge_WDONE)
        begin
            if (current_state==WRITE_SR)
                next_state = IDLE;
        end

        if (rising_edge_EDONE)
        begin
            if (current_state==SUBSEC_ER || current_state==SEC_ER || current_state==BULK_ER)
                next_state = IDLE;
        end
    end

    always @(rising_edge_PDONE or rising_edge_DP_out)
    begin: StateGen2
        case (current_state)
            PAGE_PG :
            begin
            next_state = IDLE;
            end

            OTP_PG:
            begin
            next_state = IDLE;
            end

            DP_DOWN_WAIT:
            begin
                if (rising_edge_DP_out)
                    next_state = DP_DOWN;
            end

        endcase
    end



    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general functionality
    ///////////////////////////////////////////////////////////////////////////

    reg rising_edge_read_out = 1'b0;
    reg rising_edge_RDP_out  = 1'b0;
    reg Instruct_event       = 1'b0;
    reg change_addr_event    = 1'b0;
    reg rising_edge_powered  = 1'b0;
    reg current_state_event  = 1'b0;

    integer sector;
    integer WData [0:255];
    integer WOTPData;
    integer Addr;
    integer Addr_tmp;

    always @(oe_event)
    begin
        oe = 1'b1;
        #1 oe = 1'b0;
    end

    always @(rising_edge_read_out or Instruct_event or
             change_addr_event or oe or current_state_event or
             falling_edge_write or WDONE or PDONE or EDONE or SNeg_ipd or 
             rising_edge_powered or rising_edge_RDP_out or rising_edge_DP_out)
    begin: Functionality
    integer i,j,k;

        if (rising_edge_read_out)
        begin
            if (PoweredUp == 1'b1)
                ->oe_event;
        end

        if (Instruct_event)
        begin
            read_cnt = 0;
            rd_fast = 1'b1;
            rd_slow = 1'b0;
            dual    = 1'b0;
        end

        if (change_addr_event)
            read_addr = Address;

        if (oe || current_state_event)
        begin
            case (current_state)
                IDLE :
                begin
                    if (oe)
                    begin
                        if (Instruct == RDSR)
                        begin
                        //Read Status Register
                            DQ1_out_zd = Status_reg[7-read_cnt];
                            read_cnt = read_cnt + 1;
                            if (read_cnt == 8)
                                read_cnt = 0;
                        end
                        else if (Instruct == READ || Instruct == FAST_READ)
                        begin
                        //Read Memory array
                            if (Instruct == READ)
                            begin
                                rd_fast = 1'b0;
                                rd_slow = 1'b1;
                            end
                            data_out[7:0] = Mem[read_addr];
                            DQ1_out_zd  = data_out[7-read_cnt];
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
                        else if (Instruct == DOFR)
                        begin
                        //Read Memory array
                            rd_fast = 1'b0;
                            rd_slow = 1'b0;
                            dual    = 1'b1;
                            data_out[7:0] = Mem[read_addr];
                            DQ1_out_zd      = data_out[7-2*read_cnt];
                            DQ0_out_zd      = data_out[6-2*read_cnt];
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
                        else if (Instruct == RDID)
                        begin
                        // Read ID
                            ident_out = {Manuf_ID,DeviceID,CFD_length,CFD_content};
                            DQ1_out_zd = ident_out[159-read_cnt];
                            read_cnt  = read_cnt + 1;
                            if (read_cnt == 160)
                                read_cnt = 0;
                        end
                        else if (Instruct == RDLR)
                        begin
                        // Read Lock Register
                            rd_fast = 1'b1;
                            rd_slow = 1'b0;
                            sect = Address / 24'h10000;
                            data_out[7:0] = Lock_reg[sect][7:0];
                            DQ1_out_zd  = data_out[7-read_cnt];
                            read_cnt = read_cnt + 1;
                            if (read_cnt == 8)
                                read_addr = 0;
                        end
                        else if (Instruct == ROTP)
                        begin
                            if(read_addr>=OTPLoAddr && read_addr<=OTPHiAddr)
                            begin
                            //Read OTP Memory array
                                rd_fast = 1'b1;
                                rd_slow = 1'b0;
                                data_out[7:0] = OTPMem[read_addr];
                                DQ1_out_zd  = data_out[7-read_cnt];
                                read_cnt = read_cnt + 1;
                                if (read_cnt == 8)
                                begin
                                    read_cnt = 0;
                                    if (read_addr == OTPHiAddr)
                                        read_addr = OTPHiAddr + 1;
                                    else
                                        read_addr = read_addr + 1;
                                end
                            end
                            else if (read_addr > OTPHiAddr)
                            begin
                            //There is no rollover mechanism with ROTP instr.
                            //ROTP instr. must be sent with a max. of 65 bytes
                            //to read, since once the 65th byte has been read,
                            //the same (65th)byte keeps beeing read on the DQ1
                                DQ1_out_zd = OTPMem[OTPHiAddr];
                                read_cnt = read_cnt + 1;
                                if (read_cnt == 8)
                                    read_cnt = 0;
                            end
                        end
                    end
                end

                WRITE_SR,
                SEC_ER,
                SUBSEC_ER,
                BULK_ER,
                OTP_PG,
                PAGE_PG :
                begin
                    if (oe && Instruct == RDSR)
                    begin
                    //Read Status Register
                        DQ1_out_zd = Status_reg[7-read_cnt];
                        read_cnt = read_cnt + 1;
                        if (read_cnt == 8)
                            read_cnt = 0;
                    end
                end
            endcase
        end

        if (falling_edge_write)
        begin
            case (current_state)
                IDLE:
                begin
                    if (~write)
                    begin
                        if (Instruct == WREN)
                        begin
                            Status_reg[1] = 1'b1;
 																							end
                        else if (Instruct == WRDI)
                            Status_reg[1] = 1'b0;
                        else if (Instruct == WRSR && WEL &&
                                (~(SRWD == 1'b1 && WNeg_ipd == 1'b0)))
                        begin
                            WSTART = 1'b1;
                            WSTART <= #1 1'b0;
                            Status_reg[0] = 1'b1;
                        end
                        else if ((Instruct == PP || Instruct == DIFP) && WEL)
                        begin
                            sect = Address / 24'h10000;
                            if (Lock_reg[sect][0] == 1'b0 && Sec_Prot[sect] == 1'b0)
                            begin
                                PSTART = 1'b1;
                                PSTART <= #1 1'b0;
                                Status_reg[0] = 1'b1; //WIP
                                Addr = Address;
                                Addr_tmp = Address;
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
                                Status_reg[1] = 1'b0;
                        end
                        else if (Instruct == POTP && WEL == 1 && OTP_ctrl_byte[3:0]== 4'hF )
                        // If bits 3,2,1,0 in OTP control byte(65th) are set to 1
                        //the OTP address space is programmable.
                        begin
                            if ((Address >= OTPLoAddr) && (Address <= OTPHiAddr))
                            begin
                                PSTART = 1'b1;
                                PSTART <= #5 1'b0;
                                Status_reg[0] = 1'b1;
                                Addr    = Address;
                                Addr_tmp= Address;
                                wr_cnt  = Byte_number;
                                for (i=wr_cnt;i>=0;i=i-1)
                                begin
                                    if (Viol != 0)
                                        WData[i] = -1;
                                    else
                                        WData[i] = WByte[i];
                                end
                            end
                            else
                            begin
                                Status_reg[1] = 1'b0;
                                $display ("Given  address is ");
                                $display ("out of OTP address range");
                            end
                        end
                        else if (Instruct == WRLR && WEL)
                        begin
                            sect = Address / 24'h10000;
                            if (Lock_reg[sect][1]== 1'b0 && Lock_reg[sect][0]== 1'b0)
                            begin
                                for (i=0;i<=1;i=i+1)
                                begin
                                    Lock_reg[sect][i] = Lock_reg_in[i];
                                end
                              //Enable Latch (WEL) bit is reset after a 
                              //delay time less than tSHSL minimum value.
                                Status_reg[1] = 1'b0; 
                            end
                            else
                            begin
                                Status_reg[1] = 1'b0;
                            end
                        end
                        else if (Instruct == BE && WEL)
                        begin
                            if (BP2==1'b0 && BP1==1'b0 && BP0==1'b0)
                            begin
                                for(i=0;i<=SecNum;i=i+1)
                                begin
                                    for(j=0;j<=7;j=j+1)
                                    begin
                                        if (Lock_reg[i][j] == 1'b0)
                                        begin
                                            if (lock == 1'b0) 
                                            begin     
                                                ESTART = 1'b1;
                                                ESTART <= #1 1'b0;
                                                Status_reg[0] = 1'b1;
                                            end
                                            else
                                            Status_reg[1] = 1'b0;
                                        end
                                        else
                                        begin
                                            lock = 1'b1;
                                            Status_reg[1] = 1'b0;
                                        end
                                    end
                                end
                            end
                            else
                            begin
                                Status_reg[1] = 1'b0;
                            end
                        end
                        else if (Instruct == SSE && WEL)
                        begin
                            sect = Address / 24'h10000;
                            if (Lock_reg[sect][0]== 1'b0 && Sec_Prot[sect] == 1'b0)
                            begin
                                ESTART = 1'b1;
                                ESTART <= #1 1'b0;
                                Status_reg[0] = 1'b1;
                                Addr = Address;
                            end
                            else
                            begin
                                Status_reg[1] = 1'b0; 
                                Status_reg[0] = 1'b0;
                            end
                        end
                        else if (Instruct == SE && WEL)
                        begin
                            sect = Address / 24'h10000;
                            if (Lock_reg[sect][0]== 1'b0 && Sec_Prot[sect] == 1'b0)
                            begin
                                ESTART = 1'b1;
                                ESTART <= #1 1'b0;
                                Status_reg[0] = 1'b1;
                            end
                            else 
                            begin       
                                Status_reg[1] = 1'b0;
                                Status_reg[0] = 1'b0;
                            end
                        end
                        else if ((Instruct == DP) && PDONE && EDONE)
                        begin
                            RDP_in <= 1'b0;
                            DP_in = 1'b1;
                        end
                    end
                end

                DP_DOWN:
                begin
                    if (~write)
                    begin
                        if (Instruct == RDP)
                            RDP_in = 1'b1;
                    end
                end
            endcase
        end

        if(current_state_event || EDONE)
        begin
            case (current_state)
                SUBSEC_ER :
                begin
                    if (~EDONE)
                    begin
                        ADDRHILO_SSE(AddrLo, AddrHi, Addr);
                        for (i=AddrLo;i<=AddrHi;i=i+1)
                        begin
                            Mem[i] = -1;
                        end
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

                SEC_ER :
                begin
                    if (~EDONE)
                    begin
                        ADDRHILO_SE(AddrLo, AddrHi, Addr);
                        for (i=AddrLo;i<=AddrHi;i=i+1)
                        begin
                            Mem[i] = -1;
                        end
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
            
                BULK_ER :
                begin
                    if (~EDONE)
                    begin
                        for (i=0;i<=AddrRANGE;i=i+1)
                        begin
                            Mem[i] = -1;
                        end
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
                    Status_reg[7] = Status_reg_in[7];//MSB first, SRWD
                    Status_reg[5] = Status_reg_in[5];// TB
                    Status_reg[4] = Status_reg_in[4];// BP2
                    Status_reg[3] = Status_reg_in[3];// BP1
                    Status_reg[2] = Status_reg_in[2];// BP0

                    change_BP = 1'b1;
                    #1 change_BP = 1'b0;
                end
            end
        end

        if(current_state_event || PDONE)
        begin
            if (current_state == PAGE_PG)
            begin
                if (~PDONE)
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
                                begin
                                    if (~old_bit[j])
                                        new_bit[j]=1'b0;
                                end
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
                end

                if (PDONE)
                begin
                    Status_reg[0] = 1'b0;//wip
                    Status_reg[1] = 1'b0;
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

            else if (current_state == OTP_PG)
            begin
                if (~PDONE)
                begin
                    for (i=0;i<=wr_cnt;i=i+1)
                    begin
                        new_int = WData[i];
                        old_int = OTPMem[Addr + i];
                        if (new_int > -1)
                        begin
                            new_bit = new_int;
                            if (old_int > -1)
                            begin
                                if  ((Addr + i) < OTPHiAddr )
                                begin
                                    old_bit = old_int;
                                    for(j=0;j<=7;j=j+1)
                                    begin
                                         if (~old_bit[j])
                                            new_bit[j] = 1'b0;
                                    end
                                    new_int = new_bit;
                                end
                                else if  ((Addr + i) == OTPHiAddr)
                                begin 
                                    new_int[3:0] = new_bit[3:0];
                                end
                                WData[i] = new_int;
                            end 
                            else
                            begin
                                WData[i] = -1;
                            end
                            OTPMem[Addr + i] =  -1;
                        end
                    end
                end

                if (PDONE)
                begin
                    Status_reg[0] = 1'b0;
                    Status_reg[1] = 1'b0;
                    for (i=0;i<=wr_cnt;i=i+1)
                    begin
                        if ((Addr + i) <= OTPHiAddr )
                            OTPMem[Addr + i] = WData[i];
                        else
                        $display ("cannot program, address is out of range");
                    end
                    OTP_ctrl_byte[7:0] = OTPMem[64];
                end
            end
        end

        //Output Disable Control
        if (SNeg_ipd )
        begin
            DQ0_out_zd   = 1'bZ;
            DQ1_out_zd   = 1'bZ;
        end

        if (rising_edge_RDP_out)
        begin
            if(RDP_out)
            begin
                RDP_in = 1'b0;
            end
        end

        if (rising_edge_DP_out)
        begin
            if (current_state == DP_DOWN_WAIT)
            begin
                DP_in = 1'b0;
            end
        end
    end

    assign fast_rd = rd_fast;
    assign rd = rd_slow;
    assign pgm = ~rd_slow;

    always @(DQ1_out_zd or HOLDNeg_ipd or DQ0_out_zd)
    begin
        if (~HOLDNeg_ipd)
        begin
            hold_mode = 1'b1;
            DQ0_out_z = 1'bZ;
            DQ1_out_z = 1'bZ;
        end
        else
        begin
            if (hold_mode)
            begin
                DQ1_out_z <= #(tpd_HOLDNeg_DQ1) DQ1_out_zd;
                DQ0_out_z  <= #(tpd_HOLDNeg_DQ1) DQ0_out_zd;
                hold_mode = 1'b0;
            end
            else
            begin
                DQ0_out_z = DQ0_out_zd;
                DQ1_out_z = DQ1_out_zd;
                hold_mode = 1'b0;
            end
        end
    end

    always @(change_BP)
    begin
        if (change_BP)
        begin
            case (Status_reg[4:2])
                3'b000 :
                begin
                    Sec_Prot = 32'h0;
                end

                3'b001 :
                begin
                    if (~Status_reg[5])
                    begin
                        Sec_Prot[SecNum : (SecNum+1)*31/32] = 1'b1;
                        Sec_Prot[(SecNum+1)*31/32 - 1 : 0] = 31'b0;
                    end
                    else
                    begin
                        Sec_Prot[(SecNum+1)/32 - 1 : 0] = 1'b1;
                        Sec_Prot[SecNum : (SecNum+1)/32] = 31'h0;
                    end
                end

                3'b010 :
                begin
                    if (~Status_reg[5])
                    begin
                        Sec_Prot[SecNum : (SecNum+1)*15/16] = 2'b11;
                        Sec_Prot[(SecNum+1)*15/16 - 1 : 0] = 30'b0;
                    end
                    else
                    begin
                        Sec_Prot[(SecNum+1)/16 - 1 : 0] = 2'b11;
                        Sec_Prot[SecNum : (SecNum+1)/16] = 30'b0;
                    end
                end

                3'b011 :
                begin
                    if (~Status_reg[5])
                    begin
                        Sec_Prot[SecNum : (SecNum+1)*7/8] = 4'hF;
                        Sec_Prot[(SecNum+1)*7/8 - 1 : 0]  = 28'b0;
                    end
                    else
                    begin
                        Sec_Prot[(SecNum+1)/8 - 1 : 0]  = 4'hF;
                        Sec_Prot[SecNum : (SecNum+1)/8] = 28'b0;
                    end
                end

                3'b100 :
                begin
                    if (~Status_reg[5])
                    begin
                        Sec_Prot[SecNum : (SecNum+1)*3/4] = 8'hFF;
                        Sec_Prot[(SecNum+1)*3/4 - 1 : 0]  = 24'b0;
                    end
                    else
                    begin
                        Sec_Prot[(SecNum+1)/4 - 1 : 0]  = 8'hFF;
                        Sec_Prot[SecNum : (SecNum+1)/4] = 24'b0;
                    end
                end

                3'b101 :
                begin
                    if (~Status_reg[5])
                    begin
                        Sec_Prot[SecNum : (SecNum+1)*1/2]= 16'hFFFF;
                        Sec_Prot[(SecNum+1)*1/2 - 1 : 0] = 16'b0;
                    end
                    else
                    begin
                        Sec_Prot[(SecNum+1)/2 - 1 : 0] = 16'hFFFF;
                        Sec_Prot[SecNum : (SecNum+1)/2] = 16'b0;
                    end
                end

                3'b110 :
                begin
                    Sec_Prot = 32'hFFFFFFFF;
                end

                3'b111 :
                begin
                    Sec_Prot = 32'hFFFFFFFF;
                end

            endcase
        end
    end

    ////////////////////////////////////////////////////////////////////////
    // functions & tasks
    ////////////////////////////////////////////////////////////////////////

    // Procedure ADDRHILO_SE
    task ADDRHILO_SE;
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
    
    // Procedure ADDRHILO_SSE
    task ADDRHILO_SSE;
    inout   AddrLOW;
    inout   AddrHIGH;
    input   Addr;
    integer AddrLOW;
    integer AddrHIGH;
    integer Addr;
    integer sector;
    begin

        AddrLOW  = (Address/(SubSecSize+1))*(SubSecSize+1);
        AddrHIGH = (Address/(SubSecSize+1))*(SubSecSize+1) + SubSecSize;

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

    ////////////////////////////////////////////////////////////////
    // edge controll processes
    ////////////////////////////////////////////////////////////////

    always @(posedge PoweredUp)
    begin
        rising_edge_powered = 1'b1;
        #1 rising_edge_powered = 1'b0;
    end

    always @(posedge SNeg_ipd)
    begin
        rising_edge_SNeg_ipd = 1'b1;
        #1 rising_edge_SNeg_ipd = 1'b0;
    end

    always @(negedge SNeg_ipd)
    begin
        falling_edge_SNeg_ipd = 1'b1;
        #1 falling_edge_SNeg_ipd = 1'b0;
    end

    always @(posedge C_ipd)
    begin
        rising_edge_C_ipd = 1'b1;
        #1 rising_edge_C_ipd = 1'b0;
    end

    always @(negedge C_ipd)
    begin
        falling_edge_C_ipd = 1'b1;
        #1 falling_edge_C_ipd = 1'b0;
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

    always @(posedge DP_out)
    begin
        rising_edge_DP_out = 1'b1;
        #1 rising_edge_DP_out = 1'b0;
    end

    always @(posedge RDP_out)
    begin
        rising_edge_RDP_out = 1'b1;
        #1 rising_edge_RDP_out = 1'b0;
    end

    always @(posedge read_out)
    begin
        rising_edge_read_out = 1'b1;
        #1 rising_edge_read_out = 1'b0;
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
