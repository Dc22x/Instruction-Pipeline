`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:03:55 04/08/2016
// Design Name:   Decoder
// Module Name:   U:/WHYYYYY/Decodertest.v
// Project Name:  WHYYYYY
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Decoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Decodertest;

	// Inputs
	reg clock;
	reg [63:0] ID;

	// Outputs
	wire [255:0] ID_EX;

	// Instantiate the Unit Under Test (UUT)
	Decoder uut (
		.clock(clock),  
		.ID(ID), 
		.ID_EX(ID_EX)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
    always begin
	#15 clock = ~clock;
	end

endmodule

