`include "MIPS1000_defines.v"

module DE2_Top
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_50,						//	50 MHz
		CLOCK_27,           //  27 MHz
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		KEY,
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B  						  //	VGA Blue[9:0]
	);

////////////////////////	Clock Input	 	////////////////////////
input			CLOCK_50;				//	50 MHz
input			CLOCK_27;				//	27 MHz
////////////////////////	DPDT Switch		////////////////////////
input	[17:0]	SW;						//	Toggle Switch[17:0]
input  [3:0]  KEY;          //  Push Button[3:0]
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]

wire clk;
wire rst;

wire IO_EnableN;
wire [31:0] MemDataOut;
wire [31:0] InstructionAddr;
wire [`MEM_ADDR_WIDTH-1:0] abus1;
wire [`MEM_ADDR_WIDTH-1:0] abus2;
//wire [31:0] dbus1;  
//wire [31:0] dbus2i;
//wire [31:0] dbus2o;
wire  [3:0] DataWE;
wire [31:0] IO_DataOut;
wire [31:0] DataOut;
wire [31:0] DataIn;
wire [31:0] DataAddr;
wire [31:0] InstructionIn;

/*
reg clk;

always @ (posedge CLOCK_50)
  clk <= SW[0];
*/

assign clk    = CLOCK_50;

// Memory data -> Processor
assign DataIn = IO_EnableN ? MemDataOut : IO_DataOut;

// Physical instruction memory address
assign abus1  = InstructionAddr[`MEM_ADDR_WIDTH+1:2];

// Physical data memory address
assign abus2  = DataAddr[`MEM_ADDR_WIDTH+1:2];

Reset_Control Reset_Control
(
  .clk          (CLOCK_50), 
  .rst_in       (SW[0]), 
  .rst_out      (rst)
);

VGA_Interface VGA_Interface
(
  .CLOCK_50     (CLOCK_50),	 // 50 MHz
  .CLOCK_27     (CLOCK_27),  // 27 MHz
  .KEY          (KEY),       //	Pushbutton[3:0]
  .SW           (SW[0]),
  .rst          (rst),
  .VGA_CLK      (VGA_CLK),   //	VGA Clock
  .VGA_HS       (VGA_HS),    //	VGA H_SYNC
  .VGA_VS       (VGA_VS),    //	VGA V_SYNC
  .VGA_BLANK    (VGA_BLANK), //	VGA BLANK
  .VGA_SYNC     (VGA_SYNC),  //	VGA SYNC
  .VGA_R        (VGA_R),     //	VGA Red[9:0]
  .VGA_G        (VGA_G),     //	VGA Green[9:0]
  .VGA_B        (VGA_B),     //	VGA Blue[9:0]

  .IO_DataAddr  (DataAddr),
  .PROC_DataOut (DataOut),
  .IO_DataOut   (IO_DataOut),
  .IO_EnableN   (IO_EnableN)
);

three_port_sram Memory
(
  .clk    (clk),
  .abus1  (abus1),
  .abus2  (abus2),
  .dbus1  (InstructionIn),
  .dbus2i (DataOut),
  .dbus2o (MemDataOut),
  .re1    (1'b1),
  .re2    (1'b1),
  .bwe    (DataWE)
);

PPS_Processor Processor
(
  .clk      (clk),
  .rst      (rst),
  .inst_addr(InstructionAddr),
  .data_addr(DataAddr),
  .inst     (InstructionIn),
  .data_in  (DataIn),
  .data_out (DataOut),
  .bwe      (DataWE)
);

endmodule

 
