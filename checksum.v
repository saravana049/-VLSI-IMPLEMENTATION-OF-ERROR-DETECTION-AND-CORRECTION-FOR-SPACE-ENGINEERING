//ECC
module ECC1(input[15:0]data_in, output[15:0]data_out);

wire [31:0] Enc;
//wire [31:0] Err;

Encoding_block2 n1(data_in,Enc);
//Error_block1 n2(Enc,Err);
Dec_block2 n3(Enc, data_out);

endmodule

//encoding//
module Encoding_block2 (input [15:0]X, output [33:0] out);

//four groups//
wire [4:1]a,b,c,d;

//Diagonal and Parity//
wire [6:1]D; 
wire [4:1]P;

//Checkbits// 
wire [2:1]Ca, Cb, Cc, Cd;

assign a = {X[0],X[1],X[2],X[3]};
assign b = {X[4],X[5],X[6],X[7]};
assign c = {X[8],X[9],X[10],X[11]};
assign d = {X[12],X[13],X[14],X[15]};

assign D[1] = a[1]^b[2]^c[1]^d[2];
assign D[2] = b[1]^a[2]^c[2]^d[1];
assign D[3] = a[3]^b[4]^c[3]^d[4];
assign D[4] = b[3]^a[4]^c[4]^d[3];
assign D[5] = a[2]^b[3]^c[2]^d[3];
assign D[6] = b[2]^a[3]^c[3]^d[2];

assign P[1] = a[1]^b[1]^c[1]^d[1];
assign P[2] = a[2]^b[2]^c[2]^d[2];
assign P[3] = a[3]^b[3]^c[3]^d[3];
assign P[4] = a[4]^b[4]^c[4]^d[4];
/*
assign P[1] = a[1]^a[2]^a[3]^a[4];
assign P[2] = b[1]^b[2]^b[3]^b[4];
assign P[3] = c[1]^c[2]^c[3]^c[4];
assign P[4] = d[1]^d[2]^d[3]^d[4];

assign Ca = {a[1]^b[1],c[1]^d[1]};
assign Cb = {a[2]^b[2],c[2]^d[2]};
assign Cc = {a[3]^b[3],c[3]^d[3]};
assign Cd = {a[4]^b[4],c[4]^d[4]};
*/

assign Ca   = {a[1]^a[3],a[2]^a[4] };
assign Cb   = {b[1]^b[3],b[2]^b[4] };
assign Cc   = {c[1]^c[3],c[2]^c[4] };
assign Cd   = {d[1]^d[3],d[2]^d[4] };


assign out[15:0] = X[15:0];

assign out[33:16] = {D[6],D[5],D[4],P[4],Cd,D[3],P[3],Cc,D[2],P[2],Cb,D[1],P[1],Ca};

endmodule 


/*
module Error_block1 (input [31:0]Y, output [31:0]Dec);

wire [31:0]E;
reg a,b,c;

assign Dec[31:0] = E[31:0];

initial
begin
if (Y[0] == 1)
    a <= Y[0] & 0;
else 
    a <= Y[0] | 1;

if (Y[5] == 0)
    b <= Y[5] | 1;
else 
    b <= Y[5] & 0;

if (Y[8] == 1)
    c <= Y[8] & 0;
else 
    c <= Y[8] | 1;

end 
assign E[31:0] = {Y[31:9], c, Y[7:6], b, Y[4:1],a};
 
endmodule
*/

//decoding

module Dec_block2( input [33:0]X , output [15:0]final_out );

wire [4:1]Ra,Rb,Rc,Rd;

wire [6:1]D,RD;
wire[4:1] P,RP;  
wire [6:1]SD;
wire [4:1]SP;  


wire [2:1]Ca,Cb,Cc,Cd;
wire [2:1]RCa,RCb,RCc,RCd;

wire [2:1]SCa,SCb,SCc,SCd;

assign D={X[33],X[32],X[31],X[27],X[23],X[19]};

assign P={X[30],X[26],X[22],X[18]};


assign Ca={X[17],X[16]};
assign Cb={X[21],X[20]};
assign Cc={X[25],X[24]};
assign Cd={X[29],X[28]};


assign Ra ={X[0],X[1],X[2],X[3]};
assign Rb ={X[4],X[5],X[6],X[7]};
assign Rc ={X[8],X[9],X[10],X[11]};
assign Rd ={X[12],X[13],X[14],X[15]};

assign RD[1] = Ra[1]^Rb[2]^Rc[1]^Rd[2];
assign RD[2] = Rb[1]^Ra[2]^Rc[2]^Rd[1];
assign RD[3] = Ra[3]^Rb[4]^Rc[3]^Rd[4];
assign RD[4] = Rb[3]^Ra[4]^Rc[4]^Rd[3];
assign RD[5] = Ra[2]^Rb[3]^Rc[2]^Rd[3];
assign RD[6] = Rb[2]^Ra[3]^Rc[3]^Rd[2];
/*
assign RP[1] = Ra[1]^Ra[2]^Ra[3]^Ra[4];
assign RP[2] = Rb[1]^Rb[2]^Rb[3]^Rb[4];
assign RP[3] = Rc[1]^Rc[2]^Rc[3]^Rc[4];
assign RP[4] = Rd[1]^Rd[2]^Rd[3]^Rd[4];
*/
assign RP[1] = Ra[1]^Rb[1]^Rc[1]^Rd[1];
assign RP[2] = Ra[2]^Rb[2]^Rc[2]^Rd[2];
assign RP[3] = Ra[3]^Rb[3]^Rc[3]^Rd[3];
assign RP[4] = Ra[4]^Rb[4]^Rc[4]^Rd[4];
/*
assign RCa = {Ra[1]^Rb[1],Rc[1]^Rd[1]};
assign RCb = {Ra[2]^Rb[2],Rc[2]^Rd[2]};
assign RCc = {Ra[3]^Rb[3],Rc[3]^Rd[3]};
assign RCd = {Ra[4]^Rb[4],Rc[4]^Rd[4]};
*/
assign RCa   = {Ra[1]^Ra[3],Ra[2]^Ra[4] };
assign RCb   = {Rb[1]^Rb[3],Rb[2]^Rb[4] };
assign RCc   = {Rc[1]^Rc[3],Rc[2]^Rc[4] };
assign RCd   = {Rd[1]^Rd[3],Rd[2]^Rd[4] };

assign SD = D ^ RD;
assign SP = P ^ RP;

assign SCa= Ca ^ RCa;
assign SCb= Cb ^ RCb;
assign SCc= Cc ^ RCc;
assign SCd= Cd ^ RCd;

wire Region_1, Region_2, Region_3;
wire [2:0] tempA,tempB,tempC;

assign  tempA = SD[1]+SD[2]+SP[1]+SP[2];
assign  tempB = SD[3]+SD[4]+SP[3]+SP[4];
assign  tempC = SD[5]+SD[6]+SP[2]+SP[3];

assign Region_1 = ((tempA>tempB)&(tempA>tempC)) ? 1'b1:1'b0;


assign Region_2 = ((tempB>tempA)&(tempB>tempC)) ? 1'b1:1'b0;


assign Region_3 = ((tempC>tempA)&(tempC>tempB)) ? 1'b1:1'b0;


//corrector  C1( X[15:0],SCa,SCb,SCc,SCd,tempA,tempB,final_out);


//endmodule


//module corrector( input [15:0]X ,input [2:1] SCa,SCb,SCc,SCd, input [2:0]tempA,tempB,output [15:0]final_out);

wire [4:1]a,b,c,d;


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
