`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.12.2023 22:02:05
// Design Name: 
// Module Name: corrector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module corrector( input [15:0]X ,input [2:1] SCa,SCb,SCc,SCd, input [2:0]tempA,tempB,tempC,output [15:0]final_out);

wire [4:1]a,b,c,d;
wire Region_1, Region_2, Region_3;

assign Region_1 = ((tempA>tempB)&(tempA>tempC)) ? 1'b1:1'b0;


assign Region_2 = ((tempB>tempA)&(tempB>tempC)) ? 1'b1:1'b0;


assign Region_3 = ((tempC>tempA)&(tempC>tempB)) ? 1'b1:1'b0;


assign a ={X[0],X[1],X[2],X[3]};
assign b ={X[4],X[5],X[6],X[7]};
assign c ={X[8],X[9],X[10],X[11]};
assign d ={X[12],X[13],X[14],X[15]};


wire [7:0]ROp1,ROp2,ROp3,ROp4; 


assign ROp1[1:0]=SCa^{a[1],a[2]};
assign ROp1[3:2]=SCb^{b[1],b[2]};
assign ROp1[5:4]=SCc^{c[1],c[2]};
assign ROp1[7:6]=SCd^{d[1],d[2]};


assign ROp2[1:0]=SCa^{a[3],a[4]};
assign ROp2[3:2]=SCb^{b[3],b[4]};
assign ROp2[5:4]=SCc^{c[3],c[4]};
assign ROp2[7:6]=SCd^{d[3],d[4]};


assign ROp3[1:0]=SCa^{a[2],a[3]};
assign ROp3[3:2]=SCb^{b[2],b[3]};
assign ROp3[5:4]=SCc^{c[2],c[3]};
assign ROp3[7:6]=SCd^{d[2],d[3]};


wire [15:0] out1,out2,out3;


assign out1 = (Region_1)?  {ROp1[7:6],d[3],d[4],
                                 ROp1[5:4],c[3],c[4],
                                 ROp1[3:2],b[3],b[4],
                                 ROp1[1:0],a[3],a[4]}: 16'd0;


assign out2 = (Region_2)?  {d[1],d[2],ROp2[7:6],
                                 c[1],c[2],ROp2[5:4],
                                 b[1],b[2],ROp2[3:2],
                                 a[1],a[2],ROp2[1:0]}: 16'd0;


assign out3 = (Region_3)?  {d[1],ROp3[7:6],d[4],
                                 c[1], ROp3[5:4],c[4],
                                 b[1], ROp3[3:2],b[4],
                                 a[1], ROp3[1:0],a[4]}: 16'd0;
/*
assign out4 = (Region_4)?  {d[1],d[2],d[3],d[4],
                                 c[1],c[2],c[3],c[4],
                                 b[1],b[2],b[3],b[4],
                                 a[1],a[2],a[3],a[4]}: 16'd0;


*/
assign final_out = out1 ^ out2 ^ out3 ;

endmodule