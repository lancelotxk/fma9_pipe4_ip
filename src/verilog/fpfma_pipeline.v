module fpfma_pipeline(rst,clk,A1,A2,A3,A4,A5,A6,A7,A8,A9, 
	     B1,B2,B3,B4,B5,B6,B7,B8,B9,C, rnd,result_p4);
`include "parameters.v"
// pipeline 1
input clk,rst;
input [WIDTH-1:0] A1,A2,A3,A4,A5,A6,A7,A8,A9;
input [WIDTH-1:0] B1,B2,B3,B4,B5,B6,B7,B8,B9;
input [WIDTH-1:0] C;
input [1:0] rnd;
//input clk, rst;  
output [WIDTH-1:0] result_p4;

reg [WIDTH-1:0] A1_r,A2_r,A3_r,A4_r,A5_r,A6_r,A7_r,A8_r,A9_r;
reg [WIDTH-1:0] B1_r,B2_r,B3_r,B4_r,B5_r,B6_r,B7_r,B8_r,B9_r;
reg [WIDTH-1:0] C_r;
reg [1:0] rnd_r;

always @(posedge clk or negedge rst) begin
	if(!rst) begin
	A1_r<=0;
	A2_r<=0;
	A3_r<=0;
	A4_r<=0;
	A5_r<=0;
	A6_r<=0;
	A7_r<=0;
	A8_r<=0;
	A9_r<=0;
	B1_r<=0;
	B2_r<=0;
	B3_r<=0;
	B4_r<=0;
	B5_r<=0;
	B6_r<=0;
	B7_r<=0;
	B8_r<=0;
	B9_r<=0;
	C_r<=0;
	rnd_r<=0;
	end else begin
	A1_r<=A1;
	A2_r<=A2;
	A3_r<=A3;
	A4_r<=A4;
	A5_r<=A5;
	A6_r<=A6;
	A7_r<=A7;
	A8_r<=A8;
	A9_r<=A9;
	B1_r<=B1;
	B2_r<=B2;
	B3_r<=B3;
	B4_r<=B4;
	B5_r<=B5;
	B6_r<=B6;
	B7_r<=B7;
	B8_r<=B8;
	B9_r<=B9;
	C_r<=C;
	rnd_r<=rnd;
	end 

end


//debug 2021/3/24
//wire [WIDTH-1:0] AA, BB;
//wire aasign,bbsign;
//wire [EXP_WIDTH-1:0] aaExp,bbExp;
//wire [SIG_WIDTH-1:0] aaSig,bbSig;

//Unpacking and subnormal checks
wire aIsSubnormal, bIsSubnormal, cIsSubnormal;
wire [8:0] aSign, bSign;
wire cSign;
wire [EXP_WIDTH-1:0] a1Exp,a2Exp,a3Exp,a4Exp,a5Exp,a6Exp,a7Exp,a8Exp,a9Exp;
wire [EXP_WIDTH-1:0] b1Exp,b2Exp,b3Exp,b4Exp,b5Exp,b6Exp,b7Exp,b8Exp,b9Exp ;
wire [EXP_WIDTH-1:0] cExp;
wire [SIG_WIDTH:0] a1Sig,a2Sig,a3Sig,a4Sig,a5Sig,a6Sig,a7Sig,a8Sig,a9Sig; 
wire [SIG_WIDTH:0] b1Sig,b2Sig,b3Sig,b4Sig,b5Sig,b6Sig,b7Sig,b8Sig,b9Sig;
wire [SIG_WIDTH:0] cSig;
wire a1iszero,a2iszero,a3iszero,a4iszero,a5iszero,a6iszero,a7iszero,a8iszero,a9iszero,ciszero;
wire b1iszero,b2iszero,b3iszero,b4iszero,b5iszero,b6iszero,b7iszero,b8iszero,b9iszero;

unpack PACK1(.A(A1_r),.B(A2_r),.C(A3_r), .aSign(aSign[0]),.aExp(a1Exp),.aSig(a1Sig), .bSign(aSign[1]),.bExp(a2Exp),.bSig(a2Sig), 
	.cSign(aSign[2]),.cExp(a3Exp),.cSig(a3Sig),.cIsSubnormal(),.aiszero(a1iszero),.biszero(a2iszero),.ciszero(a3iszero));
unpack PACK2(.A(A4_r),.B(A5_r),.C(A6_r), .aSign(aSign[3]),.aExp(a4Exp),.aSig(a4Sig), .bSign(aSign[4]),.bExp(a5Exp),.bSig(a5Sig), 
	.cSign(aSign[5]),.cExp(a6Exp),.cSig(a6Sig),.cIsSubnormal(),.aiszero(a4iszero),.biszero(a5iszero),.ciszero(a6iszero));
unpack PACK3(.A(A7_r),.B(A8_r),.C(A9_r), .aSign(aSign[6]),.aExp(a7Exp),.aSig(a7Sig), .bSign(aSign[7]),.bExp(a8Exp),.bSig(a8Sig), 
	.cSign(aSign[8]),.cExp(a9Exp),.cSig(a9Sig),.cIsSubnormal(),.aiszero(a7iszero),.biszero(a8iszero),.ciszero(a9iszero));

unpack PACK4(.A(B1_r),.B(B2_r),.C(B3_r), .aSign(bSign[0]),.aExp(b1Exp),.aSig(b1Sig), .bSign(bSign[1]),.bExp(b2Exp),.bSig(b2Sig), 
	.cSign(bSign[2]),.cExp(b3Exp),.cSig(b3Sig),.cIsSubnormal(),.aiszero(b1iszero),.biszero(b2iszero),.ciszero(b3iszero));
unpack PACK5(.A(B4_r),.B(B5_r),.C(B6_r), .aSign(bSign[3]),.aExp(b4Exp),.aSig(b4Sig), .bSign(bSign[4]),.bExp(b5Exp),.bSig(b5Sig), 
	.cSign(bSign[5]),.cExp(b6Exp),.cSig(b6Sig),.cIsSubnormal(),.aiszero(b4iszero),.biszero(b5iszero),.ciszero(b6iszero));
unpack PACK6(.A(B7_r),.B(B8_r),.C(B9_r), .aSign(bSign[6]),.aExp(b7Exp),.aSig(b7Sig), .bSign(bSign[7]),.bExp(b8Exp),.bSig(b8Sig), 
	.cSign(bSign[8]),.cExp(b9Exp),.cSig(b9Sig),.cIsSubnormal(),.aiszero(b7iszero),.biszero(b8iszero),.ciszero(b9iszero));

//unpack PACK7(AA,BB,C,aasign,aaExp,aaSig,bbsign,bbExp,bbSig,cSign,cExp,cSig);
unpack PACK7(.A(),.B(),.C(C_r),.aSign(), .aExp(), .aSig(),.bSign(), .bExp(), .bSig(),.cSign(cSign), .cExp(cExp), 
	.cSig(cSig),.cIsSubnormal(cIsSubnormal),.ciszero(ciszero));

wire [8:0] product_sign=aSign ^ bSign;    // product_sign[0] is the sign of A1*B1

//Exponent comparison
wire [EXP_WIDTH-1:0] exp1;
wire [SHAMT_WIDTH-1:0] shamt_ab1,shamt_ab2,shamt_ab3,shamt_ab4,shamt_ab5,shamt_ab6,shamt_ab7,shamt_ab8,shamt_ab9,shamt_c;

/*
exponentComparison  EC(a1Exp,a2Exp,a3Exp,a4Exp,a5Exp,a6Exp,a7Exp,a8Exp,a9Exp,
		       b1Exp,b2Exp,b3Exp,b4Exp,b5Exp,b6Exp,b7Exp,b8Exp,b9Exp,cExp,cIsSubnormal,
		       a1iszero,a2iszero,a3iszero,a4iszero,a5iszero,a6iszero,a7iszero,a8iszero,a9iszero,
		       b1iszero,b2iszero,b3iszero,b4iszero,b5iszero,b6iszero,b7iszero,b8iszero,b9iszero,
		       shamt_ab1,shamt_ab2,shamt_ab3,shamt_ab4,shamt_ab5,shamt_ab6,shamt_ab7,shamt_ab8,shamt_ab9,
		       shamt_c,exp1);
*/
assign exp1=1'b0;

//align C
wire [3*(SIG_WIDTH+1)+6:0] CAligned ;  // 79bits which the MSB is the sign

// 9*booth multiplier and the outputs are 18 CSA sum and carry
wire [2*(SIG_WIDTH+1)-1:0] S1big,S2big,S3big,S4big,S5big,S6big,S7big,S8big,S9big;
wire [2*(SIG_WIDTH+1)-1:0] C1big,C2big,C3big,C4big,C5big,C6big,C7big,C8big,C9big;
wire [2*(SIG_WIDTH+1)+1:0] S1big_1,S2big_1,S3big_1,S4big_1,S5big_1,S6big_1,S7big_1,S8big_1,S9big_1;
wire [2*(SIG_WIDTH+1)+1:0] C1big_1,C2big_1,C3big_1,C4big_1,C5big_1,C6big_1,C7big_1,C8big_1,C9big_1;

DW02_multp #(.a_width(24),.b_width(24),.out_width(50)) multp_1(.a(a1Sig),.b(b1Sig),.tc(1'b0),.out0(S1big_1),.out1(C1big_1) ); 
DW02_multp #(.a_width(24),.b_width(24),.out_width(50)) multp_2(.a(a2Sig),.b(b2Sig),.tc(1'b0),.out0(S2big_1),.out1(C2big_1) ); 
DW02_multp #(.a_width(24),.b_width(24),.out_width(50)) multp_3(.a(a3Sig),.b(b3Sig),.tc(1'b0),.out0(S3big_1),.out1(C3big_1) ); 
DW02_multp #(.a_width(24),.b_width(24),.out_width(50)) multp_4(.a(a4Sig),.b(b4Sig),.tc(1'b0),.out0(S4big_1),.out1(C4big_1) ); 
DW02_multp #(.a_width(24),.b_width(24),.out_width(50)) multp_5(.a(a5Sig),.b(b5Sig),.tc(1'b0),.out0(S5big_1),.out1(C5big_1) ); 
DW02_multp #(.a_width(24),.b_width(24),.out_width(50)) multp_6(.a(a6Sig),.b(b6Sig),.tc(1'b0),.out0(S6big_1),.out1(C6big_1) ); 
DW02_multp #(.a_width(24),.b_width(24),.out_width(50)) multp_7(.a(a7Sig),.b(b7Sig),.tc(1'b0),.out0(S7big_1),.out1(C7big_1) ); 
DW02_multp #(.a_width(24),.b_width(24),.out_width(50)) multp_8(.a(a8Sig),.b(b8Sig),.tc(1'b0),.out0(S8big_1),.out1(C8big_1) ); 
DW02_multp #(.a_width(24),.b_width(24),.out_width(50)) multp_9(.a(a9Sig),.b(b9Sig),.tc(1'b0),.out0(S9big_1),.out1(C9big_1) ); 

assign S1big=S1big_1[47:0];
assign C1big=C1big_1[47:0];
assign S2big=S2big_1[47:0];
assign C2big=C2big_1[47:0];
assign S3big=S3big_1[47:0];
assign C3big=C3big_1[47:0];
assign S4big=S4big_1[47:0];
assign C4big=C4big_1[47:0];
assign S5big=S5big_1[47:0];
assign C5big=C5big_1[47:0];
assign S6big=S6big_1[47:0];
assign C6big=C6big_1[47:0];
assign S7big=S7big_1[47:0];
assign C7big=C7big_1[47:0];
assign S8big=S8big_1[47:0];
assign C8big=C8big_1[47:0];
assign S9big=S9big_1[47:0];
assign C9big=C9big_1[47:0];

wire cSign_p1;
wire [8:0] product_sign_p1;
wire [SHAMT_WIDTH-1:0] shamt_c_p1;
wire [SIG_WIDTH:0] cSig_p1;
wire [EXP_WIDTH-1:0] exp1_p1;
wire [SHAMT_WIDTH-1:0] shamt_ab1_p1,shamt_ab2_p1,shamt_ab3_p1,shamt_ab4_p1,shamt_ab5_p1,shamt_ab6_p1,shamt_ab7_p1,shamt_ab8_p1,shamt_ab9_p1;
wire [2*(SIG_WIDTH+1)-1:0] S1big_p1,S2big_p1,S3big_p1,S4big_p1,S5big_p1,S6big_p1,S7big_p1,S8big_p1,S9big_p1;
wire [2*(SIG_WIDTH+1)-1:0] C1big_p1,C2big_p1,C3big_p1,C4big_p1,C5big_p1,C6big_p1,C7big_p1,C8big_p1,C9big_p1;
reg_pipeline1  pipe1 (rst,clk,exp1,product_sign,cSign,shamt_c,cSig,
	   	shamt_ab1,shamt_ab2,shamt_ab3,shamt_ab4,shamt_ab5,shamt_ab6,shamt_ab7,shamt_ab8,shamt_ab9,
	   	S1big,S2big,S3big,S4big,S5big,S6big,S7big,S8big,S9big,
	   	C1big,C2big,C3big,C4big,C5big,C6big,C7big,C8big,C9big,
	   exp1_p1,product_sign_p1,cSign_p1,shamt_c_p1,cSig_p1,
	   shamt_ab1_p1,shamt_ab2_p1,shamt_ab3_p1,shamt_ab4_p1,shamt_ab5_p1,shamt_ab6_p1,shamt_ab7_p1,shamt_ab8_p1,shamt_ab9_p1,
	   S1big_p1,S2big_p1,S3big_p1,S4big_p1,S5big_p1,S6big_p1,S7big_p1,S8big_p1,S9big_p1,
	   C1big_p1,C2big_p1,C3big_p1,C4big_p1,C5big_p1,C6big_p1,C7big_p1,C8big_p1,C9big_p1);


wire en_r2=1;


// pipeline 2

align ALGN(cSig_p1, shamt_c_p1, cSign_p1,CAligned);
wire [2*(SIG_WIDTH+1):0] s1,s2,s3,s4,s5,s6,s7,s8,s9; //49bits
wire [2*(SIG_WIDTH+1):0] c1,c2,c3,c4,c5,c6,c7,c8,c9; //49bits

shifter mul_shift (S1big_p1,S2big_p1,S3big_p1,S4big_p1,S5big_p1,S6big_p1,S7big_p1,S8big_p1,S9big_p1,
		   C1big_p1,C2big_p1,C3big_p1,C4big_p1,C5big_p1,C6big_p1,C7big_p1,C8big_p1,C9big_p1,
		   shamt_ab1_p1,shamt_ab2_p1,shamt_ab3_p1,shamt_ab4_p1,shamt_ab5_p1,shamt_ab6_p1,shamt_ab7_p1,shamt_ab8_p1,shamt_ab9_p1,
		   product_sign_p1,
		   s1,s2,s3,s4,s5,s6,s7,s8,s9,c1,c2,c3,c4,c5,c6,c7,c8,c9);

//wire [48:0] test=s1+c1;
wire [2*(SIG_WIDTH+1)+4:0] result_9_man_sum ,result_9_man_carry;
adder_pp add (s1,s2,s3,s4,s5,s6,s7,s8,s9,c1,c2,c3,c4,c5,c6,c7,c8,c9,result_9_man_sum ,result_9_man_carry);
//wire [52:0] sumof6 = s1+s2+s3+s4+s5+s6+s7+s8+s9+c1+c2+c3+c4+c5+c6+c7+c8+c9;
//wire [2*(SIG_WIDTH+1)+4:0] result_9_man = result_9_man_sum+result_9_man_carry;

wire [25:0] pad_man_1 = {26{result_9_man_sum[2*(SIG_WIDTH+1)+4]}};
wire [3*(SIG_WIDTH+1)+6:0] pad_man_sum = {pad_man_1,result_9_man_sum};
wire [25:0] pad_man_2 = {26{result_9_man_carry[2*(SIG_WIDTH+1)+4]}};
wire [3*(SIG_WIDTH+1)+6:0] pad_man_carry = {pad_man_2,result_9_man_carry};

wire [3*(SIG_WIDTH+1)+6:0] pad_man_sum_p2;
wire [3*(SIG_WIDTH+1)+6:0] pad_man_carry_p2;
wire [EXP_WIDTH-1:0] exp1_p2; 
wire [3*(SIG_WIDTH+1)+6:0] CAligned_p2;
wire cSign_p2;
reg_pipeline2 pipe2 (rst,clk,pad_man_sum,pad_man_carry,CAligned,cSign_p1,exp1_p1,exp1_p2,
					pad_man_sum_p2,pad_man_carry_p2,CAligned_p2,cSign_p2);


//pipeline 3
// send to a group of 3_2 compressors

wire [3*(SIG_WIDTH+1)+6:0] sum,carry;
compressor3_2_group compress_group (pad_man_sum_p2,pad_man_carry_p2,CAligned_p2,sum,carry,cSign_p2);
//wire [3*(SIG_WIDTH+1)+6:0] carry_shift = carry<<1;
//assign carry_shift[0]=cSign?1'b1:1'b0;

//wire [3*(SIG_WIDTH+1)+6:0] sum,carry;
wire [3*(SIG_WIDTH+1)+6:0] man_abc_pre,man_abc_pre_com;
carry_select_adder  ADD_CSA (.A(sum),.B(carry),.cin(1'b0),.cout(),.S(man_abc_pre));
wire [3*(SIG_WIDTH+1)+6:0] man_abc;
wire sign_eff;
assign sign_eff = man_abc_pre[3*(SIG_WIDTH+1)+6];


wire [3*(SIG_WIDTH+1)+6:0] man_abc_pre_p3;
wire [EXP_WIDTH-1:0] exp1_p3;
wire sign_eff_p3;
reg_pipeline3 pipe3 (rst,clk,man_abc_pre,exp1_p2,man_abc_pre_p3,exp1_p3,sign_eff,sign_eff_p3);

//pipeline 4

complement_2 comlement (man_abc_pre_p3,man_abc_pre_com);
assign man_abc = sign_eff_p3? man_abc_pre_com : man_abc_pre_p3 ; 
wire [3*(SIG_WIDTH+1)+5:0] man_abc_bin = man_abc[3*(SIG_WIDTH+1)+5:0];   //the MSB of man_abs is the sign of the result

wire [6:0] num;
LZC lzc (man_abc_bin,num);

wire [SIG_WIDTH:0] normalized;
wire [EXP_WIDTH-1:0] exp;
normalize normalize_shift (man_abc_bin,num,exp1_p3,normalized,exp);
wire [WIDTH-1:0] result;
assign result = {sign_eff_p3,exp,normalized[SIG_WIDTH-1:0]};

reg_pipeline4 pipe4 (rst,clk,result,result_p4,en_r2);

endmodule

module reg_pipeline1 (rst,clk,exp1,product_sign,cSign,shamt_c,cSig,
	   shamt_ab1,shamt_ab2,shamt_ab3,shamt_ab4,shamt_ab5,shamt_ab6,shamt_ab7,shamt_ab8,shamt_ab9,
	   S1big,S2big,S3big,S4big,S5big,S6big,S7big,S8big,S9big,
	   C1big,C2big,C3big,C4big,C5big,C6big,C7big,C8big,C9big,
	   exp1_p1,product_sign_p1,cSign_p1,shamt_c_p1,cSig_p1,
	   shamt_ab1_p1,shamt_ab2_p1,shamt_ab3_p1,shamt_ab4_p1,shamt_ab5_p1,shamt_ab6_p1,shamt_ab7_p1,shamt_ab8_p1,shamt_ab9_p1,
	   S1big_p1,S2big_p1,S3big_p1,S4big_p1,S5big_p1,S6big_p1,S7big_p1,S8big_p1,S9big_p1,
	   C1big_p1,C2big_p1,C3big_p1,C4big_p1,C5big_p1,C6big_p1,C7big_p1,C8big_p1,C9big_p1);
`include "parameters.v"
input rst,clk,cSign;
input [8:0] product_sign;
input [SHAMT_WIDTH-1:0] shamt_c;
input [SIG_WIDTH:0] cSig;
input [EXP_WIDTH-1:0] exp1;
input [SHAMT_WIDTH-1:0] shamt_ab1,shamt_ab2,shamt_ab3,shamt_ab4,shamt_ab5,shamt_ab6,shamt_ab7,shamt_ab8,shamt_ab9;
input [2*(SIG_WIDTH+1)-1:0] S1big,S2big,S3big,S4big,S5big,S6big,S7big,S8big,S9big;
input [2*(SIG_WIDTH+1)-1:0] C1big,C2big,C3big,C4big,C5big,C6big,C7big,C8big,C9big;
output reg cSign_p1;
output reg [8:0] product_sign_p1;
output reg [SHAMT_WIDTH-1:0] shamt_c_p1;
output reg  [SIG_WIDTH:0] cSig_p1;
output reg [EXP_WIDTH-1:0] exp1_p1;
output reg [SHAMT_WIDTH-1:0] shamt_ab1_p1,shamt_ab2_p1,shamt_ab3_p1,shamt_ab4_p1,shamt_ab5_p1,shamt_ab6_p1,shamt_ab7_p1,shamt_ab8_p1,shamt_ab9_p1;
output reg [2*(SIG_WIDTH+1)-1:0] S1big_p1,S2big_p1,S3big_p1,S4big_p1,S5big_p1,S6big_p1,S7big_p1,S8big_p1,S9big_p1;
output reg [2*(SIG_WIDTH+1)-1:0] C1big_p1,C2big_p1,C3big_p1,C4big_p1,C5big_p1,C6big_p1,C7big_p1,C8big_p1,C9big_p1;

always @(posedge clk or negedge rst) begin
	if(!rst) begin
		cSign_p1<=0;
		product_sign_p1<=0;
		shamt_c_p1<=0;
		cSig_p1<=0;
		exp1_p1<=0;
		shamt_ab1_p1<=0;
		shamt_ab2_p1<=0;
		shamt_ab3_p1<=0;
		shamt_ab4_p1<=0;
		shamt_ab5_p1<=0;
		shamt_ab6_p1<=0;
		shamt_ab7_p1<=0;
		shamt_ab8_p1<=0;
		shamt_ab9_p1<=0;
		S1big_p1<=0;
		S2big_p1<=0;
		S3big_p1<=0;
		S4big_p1<=0;
		S5big_p1<=0;
		S6big_p1<=0;
		S7big_p1<=0;
		S8big_p1<=0;
		S9big_p1<=0;
		C1big_p1<=0;
		C2big_p1<=0;
		C3big_p1<=0;
		C4big_p1<=0;
		C5big_p1<=0;
		C6big_p1<=0;
		C7big_p1<=0;
		C8big_p1<=0;
		C9big_p1<=0;
	end else begin
		cSign_p1<=cSign;
		product_sign_p1<=product_sign;
		shamt_c_p1<=shamt_c;
		cSig_p1<=cSig;
		exp1_p1<=exp1;
		shamt_ab1_p1<=shamt_ab1;
		shamt_ab2_p1<=shamt_ab2;
		shamt_ab3_p1<=shamt_ab3;
		shamt_ab4_p1<=shamt_ab4;
		shamt_ab5_p1<=shamt_ab5;
		shamt_ab6_p1<=shamt_ab6;
		shamt_ab7_p1<=shamt_ab7;
		shamt_ab8_p1<=shamt_ab8;
		shamt_ab9_p1<=shamt_ab9;
		S1big_p1<=S1big;
		S2big_p1<=S2big;
		S3big_p1<=S3big;
		S4big_p1<=S4big;
		S5big_p1<=S5big;
		S6big_p1<=S6big;
		S7big_p1<=S7big;
		S8big_p1<=S8big;
		S9big_p1<=S9big;
		C1big_p1<=C1big;
		C2big_p1<=C2big;
		C3big_p1<=C3big;
		C4big_p1<=C4big;
		C5big_p1<=C5big;
		C6big_p1<=C6big;
		C7big_p1<=C7big;
		C8big_p1<=C8big;
		C9big_p1<=C9big;
	end
end

endmodule

module reg_pipeline2 (rst,clk,pad_man_sum,pad_man_carry,CAligned,cSign_p1,exp1_p1,exp1_p2,
						pad_man_sum_p2,pad_man_carry_p2,CAligned_p2,cSign_p2);
`include "parameters.v"
input rst,clk;
input [3*(SIG_WIDTH+1)+6:0] pad_man_sum,pad_man_carry;
input [3*(SIG_WIDTH+1)+6:0] CAligned;
input cSign_p1;
input [EXP_WIDTH-1:0] exp1_p1;
output reg [EXP_WIDTH-1:0] exp1_p2; 
output reg [3*(SIG_WIDTH+1)+6:0] pad_man_sum_p2,pad_man_carry_p2;
output reg [3*(SIG_WIDTH+1)+6:0] CAligned_p2;
output reg cSign_p2;

always@ (posedge clk or negedge rst) begin
	if(!rst)begin
		pad_man_sum_p2<=0;
		pad_man_carry_p2<=0;
		CAligned_p2<=0;
		cSign_p2<=0;
		exp1_p2<=0;
	end else begin
		pad_man_sum_p2<=pad_man_sum;
		pad_man_carry_p2<=pad_man_carry;
		CAligned_p2<=CAligned;
		cSign_p2<=cSign_p1;
		exp1_p2<=exp1_p1;
	end
end
endmodule

module reg_pipeline3 (rst,clk,man_abc_pre,exp1_p2,man_abc_pre_p3,exp1_p3,sign_eff,sign_eff_p3);
`include "parameters.v"
input rst,clk;
input [3*(SIG_WIDTH+1)+6:0] man_abc_pre;
input [EXP_WIDTH-1:0] exp1_p2;
input sign_eff;
output reg [EXP_WIDTH-1:0] exp1_p3;
output reg [3*(SIG_WIDTH+1)+6:0] man_abc_pre_p3;
output reg sign_eff_p3;

always @ (posedge clk or negedge rst) begin
	if(!rst) begin
		exp1_p3<=0;
		man_abc_pre_p3<=0;
		sign_eff_p3<=0;
	end else begin
		exp1_p3<=exp1_p2;
		man_abc_pre_p3<=man_abc_pre;
		sign_eff_p3<=sign_eff;
	end
end
	
endmodule

module reg_pipeline4 (rst,clk,result,result_p4,en);
`include "parameters.v"
input rst,clk;
input [WIDTH-1:0] result;
input en;
output reg [WIDTH-1:0] result_p4;

always @ (posedge clk or negedge rst)begin
	if(!rst) begin
		result_p4<=0;
	end else if (en)begin
		result_p4<=result;
	end
end
endmodule
