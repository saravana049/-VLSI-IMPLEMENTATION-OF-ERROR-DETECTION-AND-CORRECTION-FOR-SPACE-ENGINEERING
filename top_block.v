`timescale 1ns / 1ps

module top_block (input [15:0]data_in, output [15:0]data_out );
wire [33:0] enc;
wire [33:0] encoder_op;

Encoding_block2 b1 (data_in, enc);
//assign  encoder_op = enc;
//Dec_block2 b2 ( encoder_op, data_out);
endmodule