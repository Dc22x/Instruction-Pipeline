`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:24:06 04/07/2016
// Design Name:   Instruction_Fetch
// Module Name:   U:/WHYYYYY/TEST2.v
// Project Name:  WHYYYYY
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Instruction_Fetch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TEST2;

	// Inputs
	reg clock;
	reg reset;

	// Outputs
	wire [31:0] PC;
	wire [63:0] IF_ID;
	wire [160:0] ID_EX;
	wire [99:0] EX_WB;
	

	// Instantiate the Unit Under Test (UUT)
	Instruction_Fetch uut (
		.clock(clock), 
		.reset(reset), 
		.PC(PC), 
		.IF_ID(IF_ID),
		.EX_WB(IF_ID)
	);
	
	Decoder u1 (
		.clock(clock),  
		.IF_ID(IF_ID),
		.ID_EX(ID_EX),
	   .EX_WB(EX_WB)
	);
	
	Execution u2 ( 
				.clock(clock),
					.ID_EX(ID_EX),
					.EX_WB(EX_WB)
				);
	
	initial begin
		// Initialize Inputs
		clock = 0;
		reset = 1;
		
		#10;
		reset = 0;
		
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
	#15 clock = ~clock;
	end
      
endmodule

