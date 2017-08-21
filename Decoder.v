`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:20:48 04/07/2016 
// Design Name: 
// Module Name:    Decoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Decoder( input clock,input [63:0] IF_ID, input  [99:0] EX_WB,
					 output reg [160:0] ID_EX
    );
reg [31:0] DATA[31:0];

//wire [5:0] op = ID[31:26];
//wire [4:0] rs = ID[25:21];
//wire [4:0] rt = ID[20:16];
//wire [4:0] rd = ID[15:11];



		initial begin
			DATA[0] <= 32'h00000001;
			DATA[1] <= 32'h00000001;
			DATA[2] <= 32'h00000002;
			DATA[3] <= 32'h0000000A;
			DATA[4] <= 32'h0000000F;
			DATA[5] <= 32'h00000005;
			DATA[6] <= 32'h00000006;
			DATA[7] <= 32'h00000007;
			DATA[8] <= 32'h00000008;
			DATA[9] <= 32'h00000009;
			DATA[10] <= 32'h00000010;
			DATA[11] <= 32'h0000000F;
			DATA[12] <= 32'h0000FFFe;
			DATA[13] <= 32'h0000000B;
			DATA[14] <= 32'h0000B000;
			DATA[15] <= 32'h00000000;
			DATA[16] <= 32'h00000000;
			DATA[17] <= 32'h00000000;
			DATA[18] <= 32'h00000000;
			DATA[19] <= 32'h00000000;
			DATA[20] <= 32'h00000000;
//			DATA[21] <= 32'b0;
//			DATA[22] <= 32'b0;
//			DATA[23] <= 32'b0;
//			DATA[24] <= 32'b0;
//			DATA[25] <= 32'b0;
//			DATA[26] <= 32'b0;
//			DATA[27] <= 32'b0;
//			DATA[28] <= 32'b0;
//			DATA[29] <= 32'b0;
//			DATA[30] <= 32'b0;
//			DATA[31] <= 32'b0;
			
		end

always @ (posedge clock)
begin
		
	if(EX_WB[66] == 1) //if flag is high then write back alu output into Data register 
		begin
			DATA[EX_WB[71:67]] <= EX_WB[31:0]; //data[rd] <= alu output.....this is an attempt to writeback
		end 
		
	ID_EX[31:0] <= IF_ID[63:32];// first 32 bits fed from PC stored into ID_EX
	ID_EX[63:32] <= DATA[IF_ID[25:21]]; // Operand 1..rs
	ID_EX[95:64] <= DATA[IF_ID[20:16]]; // Operand 2...rt
	ID_EX[100:96] <= IF_ID[15:11]; // Address of destination
	ID_EX[111:101] <= IF_ID[10:0]; //For branch Offset 
	ID_EX[143:128] <= IF_ID[25:0]; // Immediate
	ID_EX[159:144] <= {16{IF_ID[15]}}; // sign extend
	//ID_EX[191:160]  <= IF_ID[31:0];  //PC VALUE
	
				if (EX_WB[65] == 1) // Branch flag
					begin
							ID_EX[121:106] = 16'b0100000000000000; //No operation
					end
	
			case (IF_ID[31:26])
				6'b000000: ID_EX[127:112] <= 16'b0000000000000001; //add
				6'b000001: ID_EX[127:112] <= 16'b0000000000000010; //sub
				6'b000010: ID_EX[127:112] <= 16'b0000000000000100; // LI 
				6'b000011: ID_EX[127:112] <= 16'b0000000000001000; // Shift left
				6'b000100: ID_EX[127:112] <= 16'b0000000000010000;  // shift right
				6'b000101: ID_EX[127:112] <= 16'b0000000000100000;  // AND
				6'b000110: ID_EX[127:112] <= 16'b0000000001000000;  //OR
				6'b000111: ID_EX[127:112] <= 16'b0000000010000000;  //XOR
				6'b001000: ID_EX[127:112] <= 16'b0000000100000000;  //BRanch
				6'b001001: ID_EX[127:112] <= 16'b0000001000000000;   //BRANCH NOT EQUAL I.e CHECKS IF RS doesnt equal RT
				6'b001010: ID_EX[127:112] <= 16'b0000010000000000;  //MOVE
				6'b001011: ID_EX[127:112] <= 16'b0000100000000000; // ADD IMMEDIATE WITH SIGN EXTEND
				6'b001100: ID_EX[127:112] <= 16'b0001000000000000; // Multiply
				6'b001101: ID_EX[127:112] <= 16'b0010000000000000;  // Halt
				6'b001110: ID_EX[127:112] <= 16'b0100000000000000;  // No OP
			endcase
	
	end
			

			

					    

endmodule
