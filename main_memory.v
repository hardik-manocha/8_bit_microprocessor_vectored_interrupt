`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:33:25 06/29/2015 
// Design Name: 
// Module Name:    main_memory 
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
module main_memory_f(
  input clk,rst,
  input [0:3]address1,
  output reg [0:7]datain_mp,
  input [0:7]dataout_mp, 
  input sta1
    );
	 
reg [0:7]main_memory[0:15];	 

 /*main_memory[0]={8'b01010001};
 main_memory[1]={8'b00000111};
 main_memory[2]={8'b01001100};
 main_memory[3]={8'b01100100};
 main_memory[4]={8'b11011000};
 main_memory[5]={8'b11110100};
 main_memory[6]={8'b00111110};
 main_memory[7]={8'b10101101};
 main_memory[8]={8'b10000101};
 main_memory[9]={8'b10100101};
 main_memory[10]={8'b00101101};
 main_memory[11]={8'b10101001};
 main_memory[12]={8'b10101101};
 main_memory[13]={8'b10100101};
 main_memory[14]={8'b10101100};
 main_memory[15]={8'b00101101};
 */

always @ (clk,address1,dataout_mp)begin
if(rst)begin
    main_memory[0]={8'b01010001};
    main_memory[1]={8'b00000111};
    main_memory[2]={8'b01001100};
    main_memory[3]={8'b01100100};
    main_memory[4]={8'b11011000};
    main_memory[5]={8'b11110100};
    main_memory[6]={8'b00111110};
    main_memory[7]={8'b10101101};
    main_memory[8]={8'b10000101};
    main_memory[9]={8'b10100101};
    main_memory[10]={8'b00101101};
    main_memory[11]={8'b10101001};
    main_memory[12]={8'b10101101};
    main_memory[13]={8'b10100101};
    main_memory[14]={8'b10101100};
    main_memory[15]={8'b00101101};
end
  
else begin
  if(sta1==1'b1)begin
    main_memory[address1]=dataout_mp;
  end
  
  else begin
    datain_mp=main_memory[address1];
  end
end
  
end
endmodule