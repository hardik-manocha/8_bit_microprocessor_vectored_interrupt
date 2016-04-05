`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:18 06/17/2015 
// Design Name: 
// Module Name:    mp_nonpipelined 
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
module mp_nonpipelined_f(                             //////////one instruction for main_memory data to move to register_memory
 input clk,
 input rst,
 output reg [0:3]pc,
 input [0:15]ir1,
 output reg [0:3]address,
 input [0:7]datain,
 output reg [0:7]dataout, 
 output reg sta
 );


//reg [0:5]pc=0;       //program counter. Its value is used to determine the instruction to be fetchedd from memory.
//wire [0:15]ir1;       //it will store the instruction fetched from memory.
//reg [0:11]ar;       //it will have the content of RA, RB, rstore ie.. the address from where data is to be taken and data is to be stored.
reg [0:7]acc;       //accumulator.
reg [0:15]ir=0;
reg mrc;            //memory register check. 
reg [0:3]RA;        //address of first operand available from instruction.
reg [0:3]RB;        //address of second operand available from instruction.
reg [0:3]rstore;    //address where the processed data will be stored.
reg [0:5]cstate;    //current state.
//reg nstate;         //next state.
reg [0:2]opcode;    //operational code.
reg [0:3]instruct;   //for instruction 4 bits.
reg fetch;
reg decode;
reg execute;
reg store;
//reg HALT,MVI,STA,LDA,JMP,ADD,ADC,SBB,SUB,INC,DEC,AND,OR,XOR,CMP,SHR,SHL;
//reg [0:7]main_memory[0:15];    //memory to store 8 bit data.
reg [0:7]A;
reg [0:7]B;       //temporary register to store temp 8 bit data.
//reg [0:15]i_memory[0:18];    //memory to store instructions.//		//in2D memeory first bracket shows the no. of column and the second bracket shows the no. of rows//
reg [0:7]register_memory[0:15];   //register stack of memory to store data in registers.
reg b1;
reg [0:7]flag_status;   //  |s|z|p|c|x|x|x|x|
reg FLAG_MOV,FLAG_ADD,FLAG_ADC,FLAG_SBB,FLAG_SUB,FLAG_INC,FLAG_DCR,FLAG_AND,FLAG_OR,FLAG_XOR,FLAG_CMP,FLAG_SHR,FLAG_SHL,FLAG_LDA,FLAG_STA,FLAG_JMP,FLAG_MVIA,FLAG_HLT;

function parity_bit;
input [7:0]a1;
integer i;
begin
	parity_bit=0;
	for(i=0;i<8;i=i+1)begin
	  parity_bit=parity_bit^a1[i];
	 end
end
endfunction


//i_memory l1 (clk,pc,ir1);


always @ (clk,rst)begin
  
  if(rst==1'b1)begin
    //filling up the main memory
   /* main_memory[0]={8'b01010001};
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
    
    //filling up the register memory
    register_memory[0]={8'b10000000};
    register_memory[1]={8'b01000000};
    register_memory[2]={8'b00100000};
    register_memory[3]={8'b10010000};
    register_memory[4]={8'b00001000};
    register_memory[5]={8'b00000100};
    register_memory[6]={8'b10000010};
    register_memory[7]={8'b00000001};
    register_memory[8]={8'b11000000};
    register_memory[9]={8'b01100000};
    register_memory[10]={8'b00110000};
    register_memory[11]={8'b00011000};
    register_memory[12]={8'b00001100};
    register_memory[13]={8'b00000110};
    register_memory[14]={8'b00000011};
    register_memory[15]={8'b10000001};
    
    //filling up the instruction memory
    

    
    cstate=6'b000000;
    //ir=0;
    acc=0; 
    b1=1'b1;
    flag_status[0]=1'b0;
	 flag_status[1]=1'b1;
	 flag_status[2:7]=6'b000000;	 
           pc=0;
  end
      
else
 
begin
  
  case (cstate) 
  
  0: begin
    
    //to imply fetching operation
    fetch=1'b1;
    decode=1'b0;
    execute=1'b0;
    store=1'b0;
    ////////////////////
    
    
    
    //ir=i_memory[pc];
    
    if(b1)begin
      cstate=6'b000001;
    end
    else begin
      cstate=6'b000000;
    end
    
  end//end of case 0;
  
  1: begin
    ir=ir1;
    if(b1)begin
      cstate=6'b000010;
    end
    else begin
      cstate=6'b000001;
    end
    
  end
  
  2: begin
    
    if(b1)begin
      cstate=6'b000011;
    end
    else begin
      cstate=6'b000010;
    end
    
  end
  
  
  3: begin
    
    if(b1)begin
      cstate=6'b000100;
    end
    else begin
      cstate=6'b000011;
    end
    
  end
  
  4:begin
    
    if(b1)begin
      cstate=6'b000101;
    end
    else begin
      cstate=6'b000100;
    end
    
  end
  
  5:begin
    
    if(b1)begin
      cstate=6'b000110;
    end
    else begin
      cstate=6'b000101;
    end
    
  end
  
  6: begin
    
    if(b1)begin
      cstate=6'b000111;
    end
    else begin
      cstate=6'b000110;
    end
    
  end

 7: begin
   
    //to imply decoding instruction operation
    fetch=1'b0;
    decode=1'b1;
    execute=1'b0;
    store=1'b0;
    ////////////////////
    
    //breaking down the Instruction register
    mrc=ir[0];
    opcode=ir[1:3];
    instruct=ir[4:7];
    RA=ir[8:11];
    RB=ir[12:15];
    rstore=ir[8:11];
    ///////////////////
    
    if(mrc==1'b1 & opcode==3'b000)begin
    FLAG_LDA=1'b1;
    end
    
    else if(mrc==1'b1 & opcode==3'b001)begin
    FLAG_STA=1'b1;
    sta=1'b1;
    end
    
    else if(mrc==1'b1 & opcode==3'b010)begin
    FLAG_JMP=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b000)begin
    FLAG_HLT=1'b1;
    end
    
    else if(mrc==1'b1 & opcode==3'b001)begin
    FLAG_MVIA=1'b1;
	 rstore=instruct;
    end
	 
	 else if(mrc==1'b0 & opcode==3'b001)begin
    FLAG_MVIA=1'b1;
	 rstore=instruct;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b0000)begin
    FLAG_MOV=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b0001)begin
    FLAG_ADD=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b0010)begin
    FLAG_ADC=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b0011)begin
    FLAG_SBB=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b0100)begin
    FLAG_SUB=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b0110)begin
    FLAG_INC=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b0111)begin
    FLAG_DCR=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b1001)begin
    FLAG_AND=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b1010)begin
    FLAG_OR=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b1011)begin
    FLAG_XOR=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b1000)begin
    FLAG_CMP=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b1101)begin
    FLAG_SHL=1'b1;
    end
    
    else if(mrc==1'b0 & opcode==3'b010 & instruct==4'b1100)begin
    FLAG_SHR=1'b1;
    end
    
    
    if(b1)begin
      cstate=6'b001000;
    end
    else begin
      cstate=6'b000111;
    end
    
  end   //end of case 1;
  
  
  8: begin
    
    if(b1)begin
      cstate=6'b001001;
    end
    else begin
      cstate=6'b001000;
    end
    
  end
  
  
  9:begin
    
    if(b1)begin
      cstate=6'b001010;
    end
    else begin
      cstate=6'b001001;
    end
    
  end
  
  
  10:begin
    
    if(b1)begin
      cstate=6'b001011;
    end
    else begin
      cstate=6'b001010;
    end
  end
  
  11:begin
    
    if(b1)begin
      cstate=6'b001100;
    end
    else begin
      cstate=6'b001011;
    end
    
  end
  
  
  12:begin
    
    if(b1)begin
      cstate=6'b001101;
    end
    else begin
      cstate=6'b001100;
    end
    
  end
  
  13: begin
  
    //to imply execution of instruction operation
    fetch=1'b0;
    decode=1'b0;
    execute=1'b1;
    store=1'b0;
    ////////////////////
    
    if(FLAG_MOV==1'b1)begin
      acc=register_memory[RB];
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_ADD==1'b1)begin
      A=register_memory[RA];
		B=register_memory[RB];
		acc=A+B;
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_ADC==1'b1)begin
      A=register_memory[RA];
		B=register_memory[RB];
		
		if(A[0]==B[0])begin
			flag_status[3]=1'b1;
		end
		
		acc=A+B;
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
		
    end
	 
	 else if(FLAG_SBB==1'b1)begin
      A=register_memory[RA];
		B=register_memory[RB];
		acc=A-B;
		flag_status[2]=parity_bit(acc);
		if(B>A)begin
			flag_status[0]=1'b1;
		end
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_SUB==1'b1)begin
      A=register_memory[RA];
		B=register_memory[RB];
		acc=A-B;
		flag_status[2]=parity_bit(acc);
		if(B>A)begin
			flag_status[0]=1'b1;
		end
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_INC==1'b1)begin
      A=register_memory[RA];
		acc=A+1;
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_DCR==1'b1)begin
      A=register_memory[RA];
		if(A==0)begin
			flag_status[0]=1'b1;
		end
		acc=A-1;
		
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_AND==1'b1)begin
      A=register_memory[RA];
		B=register_memory[RB];
		acc=A & B;
		
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_OR==1'b1)begin
      A=register_memory[RA];
		B=register_memory[RB];
		acc=A | B;
		
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_XOR==1'b1)begin
      A=register_memory[RA];
		B=register_memory[RB];
		acc=A ^ B;
		
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_CMP==1'b1)begin
      A=register_memory[RA];
		acc= ~ A;
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_SHL==1'b1)begin
      A=register_memory[RA];
		acc[0]= A[1];
		acc[1]= A[2];
		acc[2]= A[3];
		acc[3]= A[4];
		acc[4]= A[5];
		acc[5]= A[6];
		acc[6]= A[7];
		acc[7]= A[0];
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_SHR==1'b1)begin
      A=register_memory[RA];
		acc[0]= A[7];
		acc[1]= A[0];
		acc[2]= A[1];
		acc[3]= A[2];
		acc[4]= A[3];
		acc[5]= A[4];
		acc[6]= A[5];
		acc[7]= A[6];
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_LDA==1'b1)begin
	   address=RA;
	   //#2;
     acc=datain;            // main_memory[RA] previuosly
		flag_status[2]=parity_bit(acc);
		if(acc==0)begin
			flag_status[1]=1'b1;
		end
    end
	 
	 else if(FLAG_JMP==1'b1)begin
      pc=RA;
    end
	 
	 else if(FLAG_MVIA==1'b1)begin
      acc[0:3]=RA;
		acc[4:7]=RB;
    end
	 
	 else if(FLAG_HLT==1'b1)begin
      //$finish;
		$display("halt instruction reached");
    end
	 
	 
  
    if(b1)begin
    cstate=6'b001110;
    end
    else begin
      cstate=6'b001101;
    end
        
  end //end of case 2;
  
  
  14: begin
    if(b1)begin
      cstate=6'b001111;
    end
    else begin
      cstate=6'b001110;
    end
  end
  
  
  15: begin
    if(b1)begin
      cstate=6'b010000;
    end
    else begin
      cstate=6'b001111;
    end
end


16: begin
  if(b1)begin
      cstate=6'b010001;
    end
    else begin
      cstate=6'b010000;
    end
end


17: begin
  if(b1)begin
      cstate=6'b010010;
    end
    else begin
      cstate=6'b010001;
    end
end


18: begin
  if(b1)begin
      cstate=6'b010011;
    end
    else begin
      cstate=6'b010010;
    end
end

19: begin
if(b1)begin
      cstate=6'b010100;
    end
    else begin
      cstate=6'b010011;
    end
end


  20: begin
    
    //to imply store of operation instruction 
    fetch=1'b0;
    decode=1'b0;
    execute=1'b0;
    store=1'b1;
    ////////////////////
    
    if(FLAG_MOV==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_ADD==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_ADC==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_SBB==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_SUB==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_INC==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_DCR==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_AND==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_OR==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_XOR==1'b1)begin
      register_memory[rstore]=acc;
    end

	 else if(FLAG_CMP==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_SHL==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_SHR==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_STA==1'b1)begin
	   
	   address=rstore;
      dataout=acc;      ////////heer
    end
	 
	 else if(FLAG_JMP==1'b1)begin
      pc=pc-1;
    end
	 
	 /*else if(FLAG_MVIR==1'b1)begin
      register_memory[rstore]=acc;
    end
	 
	 else if(FLAG_MVIM==1'b1)begin
      main_memory[rstore]=acc;
    end
    */
	 
	 
	 
	 if(b1)begin
      cstate=6'b000000;
		
		FLAG_MOV=1'b0;
		FLAG_ADD=1'b0;
		FLAG_ADC=1'b0;
		FLAG_SBB=1'b0;
		FLAG_SUB=1'b0;
		FLAG_INC=1'b0;
		FLAG_DCR=1'b0;
		FLAG_AND=1'b0;
		FLAG_OR=1'b0;
		FLAG_XOR=1'b0;
		FLAG_CMP=1'b0;
		FLAG_SHR=1'b0;
		FLAG_SHL=1'b0;
		FLAG_LDA=1'b0;
		FLAG_STA=1'b0;
		FLAG_JMP=1'b0;
		FLAG_MVIA=1'b0;
		//FLAG_MVIR=1'b0;
		//FLAG_HLT=1'b0;
		
		pc=pc+1;
    end
    else begin
      cstate=6'b010100;
    end
	 
	 
    
    
    
  end //end of case 3;  
    

  endcase
  end
end //end of always

endmodule

