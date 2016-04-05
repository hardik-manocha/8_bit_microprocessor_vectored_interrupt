`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:41 06/25/2015 
// Design Name: 
// Module Name:    top_mp 
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
module top_mp(
input clk,
input rst
    );

wire [0:3]pc1;
wire [0:15]ir1;
reg [0:3]pc=0;
wire [0:3]address;
wire [0:7]datain;
wire [0:7]dataout;
wire sta1;


i_memory_f l2 (clk,pc,ir1);
mp_nonpipelined_f l1 (clk,rst,pc1,ir1,address,datain,dataout,sta1);
main_memory_f l3 (clk,rst,address,datain,dataout,sta1);

  always @ (posedge clk)begin
    
    pc=pc1;
  end


endmodule

