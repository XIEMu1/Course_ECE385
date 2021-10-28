module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
    logic c4,c8,c12;
    logic pg0,pg4,pg8,pg12;
    logic gg0,gg4,gg8,gg12;

    always_comb 
    begin
        c4 = gg0;
        c8 = gg4 | gg0 & pg4;
        c12 = gg8 | gg4 & pg8 | gg0 & pg4 & pg8;
        CO = gg12 | gg8 & pg12 | gg4 & pg8 & pg12 | gg0 & pg4 & pg8 & pg12;
    end

    CLA adder0(.X(A[3:0]),.Y(B[3:0]),.cin( 0),.S(Sum[3:0]),.gm(gg0),.pm(pg0));
    CLA adder4(.X(A[7:4]),.Y(B[7:4]),.cin(c4),.S(Sum[7:4]),.gm(gg4),.pm(pg4));
    CLA adder8(.X(A[11:8]),.Y(B[11:8]),.cin(c8),.S(Sum[11:8]),.gm(gg8),.pm(pg8));
    CLA adder12(.X(A[15:12]),.Y(B[15:12]),.cin(c12),.S(Sum[15:12]),.gm(gg12),.pm(pg12));

endmodule

module CLA
(
    input [3:0]X,
    input [3:0]Y,
    input cin,
    output [3:0]S,
    output gm,
    output pm
);
    logic p0,p1,p2,p3;
    logic g0,g1,g2,g3;
    logic c1,c2,c3;

    always_comb 
    begin
        c1  = cin & p0 | g0;
        c2  = cin & p0 & p1 | g0 & p1 | g1;
        c3  = cin & p0 & p1 & p2 | g0 & p1 & p2 | g1 & p2 | g2;
    end

    Full_Adder_mod fa0(.x(X[0]),.y(Y[0]),.cin(cin),.s(S[0]),.g(g0),.p(p0));
    Full_Adder_mod fa1(.x(X[1]),.y(Y[1]),.cin(c1),.s(S[1]),.g(g1),.p(p1));
    Full_Adder_mod fa2(.x(X[2]),.y(Y[2]),.cin(c2),.s(S[2]),.g(g2),.p(p2));
    Full_Adder_mod fa3(.x(X[3]),.y(Y[3]),.cin(c3),.s(S[3]),.g(g3),.p(p3));
    
	 assign  gm = g0 & p1 & p2 & p3 | g1 & p2 & p3 | g2 & p3 | g3;
    assign  pm = p0 & p1 & p2 & p3;

endmodule

// one bit full adder that add two differnet output g() and p(). 
module Full_Adder_mod (
    input x,
    input y,
    input cin,
    output s,
    output g,
    output p
);
    assign s = x^y^cin;
    assign g = x&y;
    assign p = x|y;
endmodule