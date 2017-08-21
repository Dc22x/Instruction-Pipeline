`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:42 04/07/2016 
// Design Name: 
// Module Name:    Instruction_Fetch 
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
module Instruction_Fetch(
	input clock,
	input reset,
	input [99:0] EX_WB,
	output reg [31:0] PC,
	output reg [63:0] IF_ID
    );



reg [31:0] mem[31:0]; 
initial 
begin
						     //op,     rs,      rt,      rd ,    shift , imm
							  
				mem[0] <= {6'b000000,5'b00010,5'b00001,5'b00000,5'b00000,6'b000010}; // ADD rs(2) + rt(1)  
				mem[1] <= {6'b000001,5'b00100,5'b00010,5'b00001,5'b00000,6'b000001};  // Subtract rs -rt
				mem[2] <= {6'b000000,5'b00011,5'b00011,5'b00100,5'b00000,6'b000000}; //add         
				mem[3] <= {6'b000001,5'b00000,5'b00000,5'b00000,5'b00000,6'b000111}; //sub reg0-reg0  into reg 0 r - type
				mem[4] <= {6'b000111,5'b00110,5'b00111,5'b00000,5'b00000,6'b000111}; //xor rs=reg 6(1010) with rt=reg 7(1011) output ->0001=A 
				mem[5] <=  {6'b000110,5'b00110,5'b00111,5'b00000,5'b00000,6'b000111}; //or  
				mem[6] <=  {6'b000101,5'b00110,5'b00111,5'b00000,5'b00000,6'b000111}; //and 
				mem[7] <=  {6'b000011,5'b00000,5'b00000,5'b00000,5'b00000,6'b000001}; //shift left 
				mem[8] <=  {6'b000010,5'b00000,5'b00000,5'b00000,5'b00000,6'b000111}; //load 7 into reg 0
				mem[9] <=  {6'b000010,5'b00000,5'b00000,5'b00000,5'b00000,6'b010000}; //load 16 into reg 0
				mem[10] <= {6'b001001,5'b00000,5'b00000,16'b1111111111111000};        //do a jump with offset -7
				mem[11] <= {6'b001001,5'b00000,5'b00001,16'b0000000000000010};        //do a jump with offset4 jump to going to jump because different value in reg
				mem[12] <= {6'b000010,5'b00000,5'b00000,5'b00000,5'b00000,6'b001111}; //load 15 into reg 0
				mem[13] <= {6'b001100,5'b01010,5'b01011,5'b00010,5'b00000,6'b000101}; //multiply
				mem[14] <= {6'b001000,5'b00000,5'b00000,16'b1111111111111000};        //jump backwards -7

							  
							  // changed instructions due to error in previous instructions
							  
			
		

		 PC <= 0;   //PC = 0
end

		always @ (posedge clock)
		begin 
			if(reset == 0)
			begin 
				if(EX_WB[66] == 1)  // if the WRITE BACK FLAG IS HIGH STORE UPDATE PC 
				begin
				PC = EX_WB[63:32]; //PC values from write back stage
				IF_ID[31:0] <= mem[PC]; //memory read into first 32 bits on instruction register.....
				IF_ID[63:32] <= PC; //PC Stored in last 32 bits, 
				end
				
				else
				begin
				IF_ID[31:0] <= mem[PC]; //memory read into first 32 bits on instruction register.....
				IF_ID[63:32] <= PC; //PC Stored in last 32 bits, 
				PC <= PC + 1;  //increments PC
				end
			end
		end
				
		
			



endmodule
