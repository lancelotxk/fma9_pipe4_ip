module SAD_6 #(parameter SIG_WIDTH = 23)(in1,in2,in3,in4,in5,in6,sum,carry);

//parameter SIG_WIDTH = 23;

input [2*(SIG_WIDTH+1):0] in1,in2,in3,in4,in5,in6;
output [2*(SIG_WIDTH+1)+2:0] sum,carry;  //input 49 bits and output will be 51 bits

wire [2*(SIG_WIDTH+1)+2:0]s1,c1,s2,c2,s3,c3,s4,c4;
wire [2*(SIG_WIDTH+1)+2:0]c1_sh,c2_sh,c3_sh;
//wire cin={1'b0};
wire [2*(SIG_WIDTH+1)+2:0] cout;

wire [2*(SIG_WIDTH+1)+2:0] in1_pad,in2_pad,in3_pad,in4_pad,in5_pad,in6_pad;
assign in1_pad={{in1[2*(SIG_WIDTH+1)]},{in1[2*(SIG_WIDTH+1)]},in1};
assign in2_pad={{in2[2*(SIG_WIDTH+1)]},{in2[2*(SIG_WIDTH+1)]},in2};
assign in3_pad={{in3[2*(SIG_WIDTH+1)]},{in3[2*(SIG_WIDTH+1)]},in3};
assign in4_pad={{in4[2*(SIG_WIDTH+1)]},{in4[2*(SIG_WIDTH+1)]},in4};
assign in5_pad={{in5[2*(SIG_WIDTH+1)]},{in5[2*(SIG_WIDTH+1)]},in5};
assign in6_pad={{in6[2*(SIG_WIDTH+1)]},{in6[2*(SIG_WIDTH+1)]},in6};

generate
	genvar  i;
	for (i=0;i<2*(SIG_WIDTH+1)+3;i=i+1) begin
		compress3_2 m1 ({in1_pad[i],in2_pad[i],in3_pad[i]},s1[i],c1[i]);
		compress3_2 m2 ({in4_pad[i],in5_pad[i],in6_pad[i]},s2[i],c2[i]);
		assign c1_sh=c1<<1;
		assign c2_sh=c2<<1;
		compress3_2 m3 ({s1[i],c1_sh[i],s2[i]},s3[i],c3[i]);
		assign c3_sh=c3<<1;
		compress3_2 m4 ({c2_sh[i],s3[i],c3_sh[i]},s4[i],c4[i]);
	/*	if (i==0) begin
			compress4_2 m3 ({s1[i],s2[i],1'b0,1'b0},1'b0,cout[i],c3[i],s3[i]);
			//assign cin=cout;
		end
		else  begin
			compress4_2 m3 ({s1[i],s2[i],c1[i-1],c2[i-1]},cout[i-1],cout[i],c3[i],s3[i]);
			//assign cin=cout;
		end */
	
	end
endgenerate
	

	



assign sum = s4;
assign carry = {c4[2*(SIG_WIDTH+1)+1:0],1'b0};



endmodule


