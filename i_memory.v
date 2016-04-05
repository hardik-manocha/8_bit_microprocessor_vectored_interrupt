`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:14:53 06/25/2015 
// Design Name: 
// Module Name:    i_memory 
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
module i_memory_f(
input clk,
input [0:3]pc,
output reg [0:15]instruction
    );

//reg [0:15]data_reg;
wire [0:15]i_memory[0:15];    //memory to store instructions.//	//in2D memeory first bracket shows the no. of column and the second bracket shows the no. of rows//
assign i_memory[0]={16'b0010000000000001};	//MOV
assign i_memory[1]={16'b0010000100000001};	//ADD
assign i_memory[2]={16'b0010001000000001};	//ADC
assign i_memory[3]={16'b0010001100000001};
assign i_memory[4]={16'b0010010000000001};
assign i_memory[5]={16'b0010011000000001};
assign i_memory[6]={16'b0010011100000001};
assign i_memory[7]={16'b0010100100000001};
assign i_memory[8]={16'b0010101000000001};
assign i_memory[9]={16'b0010101100000001};
assign i_memory[10]={16'b0010100000000001};
assign i_memory[11]={16'b0010110000000001};
assign i_memory[12]={16'b0010110100000001};
assign i_memory[13]={16'b1000000000000001};
assign i_memory[14]={16'b1001000000000001};
assign i_memory[15]={16'b1001000000000001};
/*assign i_memory[16]={16'b1010001101100011};
assign i_memory[17]={16'b0001001101100011};
assign i_memory[18]={16'b1000000000000000};
*/


always @ (posedge clk)begin
	instruction=i_memory[pc];
end

endmodule

