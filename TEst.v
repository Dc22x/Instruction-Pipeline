`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:17:09 04/07/2016
// Design Name:   Instruction_Fetch
// Module Name:   U:/REDUX/TEST.v
// Project Name:  REDUX
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

module TEST;

	// Inputs
	reg clock;
	reg reset;

	// Outputs
	wire [31:0] PC;
	wire [63:0] IF_ID;

	// Instantiate the Unit Under Test (UUT)
	Instruction_Fetch uut (
		.clock(clock), 
		.reset(reset), 
		.PC(PC), 
		.IF_ID(IF_ID)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		reset = 1;
		
		#50;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
	#15 clock = ~clock; 
      
endmodule

