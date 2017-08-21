`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:14:49 04/17/2016 
// Design Name: 
// Module Name:    ALU 
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
module Execution( input clock, input [160:0] ID_EX , output reg [99:0] EX_WB
    );

initial
begin
	EX_WB[66] = 1'b0; //Writeback flag
	EX_WB[65] = 1'b0; //branch flag
end


always @ (posedge clock)
	begin
	// flag bits
	
		case(ID_EX[127:112])
		
			16'b0000000000000001:  //add
				begin 
				EX_WB[31:0] = ID_EX[63:32] + ID_EX[95:64];  //rs + rt
				EX_WB[63:32] = ID_EX[31:0]; //PC
				//EX_WB[66] = 1'b1;				
				EX_WB[71:67] = ID_EX[100:96]; // Desination
				end 
			
			
			16'b0000000000000010: //sub
				begin 
				EX_WB[31:0] = ID_EX[63:32] - ID_EX[95:64]; //rs - rt
				EX_WB[63:32] = ID_EX[31:0]; //PC
//				EX_WB[65:65] = 1'b0;
//				EX_WB[66:66] = 1'b1;
				EX_WB[71:67] = ID_EX[100:96]; // Desination
				end 
				
			16'b0000000000000100: //Load immediate
				begin 
				EX_WB[31:0] = ID_EX[143:128];
				EX_WB[63:32] = ID_EX[31:0]; //PC
//				EX_WB[65:65] = 1'b1;
//				EX_WB[66:66] = 1'b0;
				EX_WB[71:67] = ID_EX[100:96]; // Desination
				end 
				
			16'b0000000000001000: // shift left
				begin 
				EX_WB[63:32] = ID_EX[63:32] <<  ID_EX[20:16]; // PC Shifted
				EX_WB[63:32] = ID_EX[31:0]; //PC
//				EX_WB[65:65] = 1'b1;
//				EX_WB[66:66] = 1'b0;
				
				EX_WB[71:67] = ID_EX[100:96]; // Desination
				end 
				
				
			16'b0000000000010000: // shift right
				begin 
				EX_WB[63:32] = ID_EX[63:32] >>  ID_EX[20:16];
				EX_WB[63:32] = ID_EX[31:0]; //PC
				
//				EX_WB[65:65] = 1'b1;
//				EX_WB[66:66] = 1'b0;
				EX_WB[71:67] = ID_EX[100:96]; // Desination
				end 
				
			16'b0000000000100000: // AND
				begin 
				EX_WB[31:0] = ID_EX[63:32] & ID_EX[95:64];
				EX_WB[63:32] = ID_EX[31:0]; //PC
				
				EX_WB[71:67] = ID_EX[100:96];
//				EX_WB[65:65] = 1'b1;
//				EX_WB[66:66] = 1'b0;
				end 	
				
				
			16'b0000000001000000: //OR
				begin 
				EX_WB[31:0] = ID_EX[63:32] | ID_EX[95:64]; 
				EX_WB[63:32] = ID_EX[31:0]; //PC
				EX_WB[71:67] = ID_EX[100:96];  // Desination
			
				end 	 
				
			16'b0000000010000000: //XOR
				begin 
				EX_WB[31:0] = ID_EX[63:32] ^ ID_EX[95:64];
				EX_WB[63:32] = ID_EX[31:0]; //PC
				EX_WB[71:67] = ID_EX[100:96]; // Desination
//				EX_WB[65:65] = 1'b1;
//				EX_WB[66:66] = 1'b0;
				end 	

			16'b0000000100000000: //BR
				begin 
					
					
				EX_WB[63:32] = ID_EX[31:0] - 7;
				EX_WB[EX_WB[63:32]] = ID_EX[100:96];	 // Desination
				
				EX_WB[65] = ID_EX[31];
 				EX_WB[66] = 1'b0;
					
				end 			
				
			16'b0000001000000000: //BNE
				begin 
				if(ID_EX[63:32] !== ID_EX[95:64])
					begin
						EX_WB[63:32] = ID_EX[31:0] + 1 + ID_EX[143:128]; // PC
						EX_WB[65] = 1;  //branch
						EX_WB[66] = 0;  // Write enable
					end
				end 	
				
			16'b0000010000000000: //MOVE
				begin 
					EX_WB[31:0] = ID_EX[95:64]; // writes back to target bits in data
					EX_WB[63:32] = ID_EX[31:0]; //PC
//					EX_WB[65:65] = 1'b1;
//					EX_WB[66:66] = 1'b0;
				end

			16'b0000100000000000: // ADD IMMEDIATE WITH SIGN EXTEND
				begin 
				EX_WB[31:0] = ID_EX[159:144] + ID_EX[95:64];
				EX_WB[EX_WB[63:32]] = ID_EX[100:96];	 // Desination
				EX_WB[63:32] = ID_EX[31:0]; //PC
//				EX_WB[65:65] = 1'b1;
//				EX_WB[66:66] = 1'b0;
				end
			
			16'b0001000000000000: //MULTI
				begin 
				EX_WB[31:0] = ID_EX[63:32] * ID_EX[95:64];
				EX_WB[EX_WB[63:32]] = ID_EX[100:96];	 // Desination
				EX_WB[63:32] = ID_EX[31:0]; //PC
				end 
			
			16'b0010000000000000: //HALT
				begin 
				$stop;
				end 
			
			16'b0100000000000000: //NO OP
				begin 
				EX_WB[31:0] = EX_WB[31:0];
				end 
				
endcase
end
endmodule
