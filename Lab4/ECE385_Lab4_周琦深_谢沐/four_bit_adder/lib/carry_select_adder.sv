module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
    logic c4,c8,c80,c81,cC,cC0,cC1,cG0,cG1;
    logic [15:0] S1,S0;
    
    //calculate the carry out signal.....
    //c4 provided by the first adder. 
	 always_comb
	 begin
    c8 = (c4 & c81) | c80;
    cC = (c8 & cC1) | cC0;
    CO = (cC & cG1) | cG0;

    // 3 muxs below that choose value......
    if (c4)
        Sum[7:4] = S1[7:4];
    else
        Sum[7:4] = S0[7:4];
    

    if (c8)
        Sum[11:8] = S1[11:8];
    else
        Sum[11:8] = S0[11:8];
    

    if (cC)
        Sum[15:12] = S1[15:12];
    else
        Sum[15:12] = S0[15:12];
    end

    // the 7 four bits full adder used before the muxes: 
    // written in the ripple adder....
    ripple_4bit FA04(.x(A[3:0]),.y(B[3:0]),.cin( 0),.s(Sum[3:0]),.cout(c4));

    ripple_4bit FA08(.x(A[7:4]),.y(B[7:4]),.cin( 0),.s(S0[7:4]),.cout(c80));
    ripple_4bit FA18(.x(A[7:4]),.y(B[7:4]),.cin( 1),.s(S1[7:4]),.cout(c81));

    ripple_4bit FA0B(.x(A[11:8]),.y(B[11:8]),.cin( 0),.s(S0[11:8]),.cout(cC0));
    ripple_4bit FA1B(.x(A[11:8]),.y(B[11:8]),.cin( 1),.s(S1[11:8]),.cout(cC1));
    
    ripple_4bit FA0G(.x(A[15:12]),.y(B[15:12]),.cin( 0),.s(S0[15:12]),.cout(cG0));
    ripple_4bit FA1G(.x(A[15:12]),.y(B[15:12]),.cin( 1),.s(S1[15:12]),.cout(cG1));
endmodule
