module complement_2(in,out);
`include "parameters.v"
input [3*(SIG_WIDTH+1)+6:0] in;
output [3*(SIG_WIDTH+1)+6:0] out;

assign out=(~in)+1'b1;



endmodule
