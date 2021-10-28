/* 9-bit adder used in shift progress and shift progress. */ 

module full_adder_9
(
    input   logic[8:0]     A,
    input   logic[8:0]     B,
	input 	logic		   C_in,
    output  logic[7:0]     Sum,
    output  logic          X
);
	 // This 9-bit adder are combined from 2 4-bit full adders and one 1-bit full adder
	 logic c1, c2, c3;
	 ripple_4bit FA40(.A(A[3:0]), .B(B[3:0]), .C_in, .Sum(Sum[3:0]), .C_out(c1));
	 ripple_4bit FA41(.A(A[7:4]), .B(B[7:4]), .C_in(c1), .Sum(Sum[7:4]), .C_out(c2));
	 
	 // calculate the last bit for output X 
	 full_adder  FA(.A(A[8]), .B(B[8]), .C_in(c2), .Sum(X),.C_out(c3));
endmodule

// copy from lab4 full adder. 
module ripple_4bit (
    input [3:0] x,
    input [3:0] y,
    input cin,
    output logic [3:0] s,
    output logic cout
);
    logic c0,c1,c2;
    full_adder FA0(.x(x[0]),.y(y[0]),.cin(cin),.s(s[0]),.cout(c0));
    full_adder FA1(.x(x[1]),.y(y[1]),.cin(c0),.s(s[1]),.cout(c1));
    full_adder FA2(.x(x[2]),.y(y[2]),.cin(c1),.s(s[2]),.cout(c2));
    full_adder FA3(.x(x[3]),.y(y[3]),.cin(c2),.s(s[3]),.cout(cout));
endmodule

module full_adder (
    input x,
    input y,
    input cin,
    output logic s,
    output logic cout
);

    assign s = x^y^cin;
    assign cout = (x&y) | (y&cin) | (cin&x);

    
endmodule