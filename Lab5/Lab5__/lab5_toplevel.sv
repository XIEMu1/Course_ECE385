/*  Date Created: Mon Jan 25 2015.
 *  Written to correspond with the spring 2016 lab manual.
 *
 *  ECE 385 Lab 4 (adders) template code.  This is the top level entity which
 *  connects an adder circuit to LEDs and buttons on the device.  It also
 *  declares some registers on the inputs and outputs of the adder to help
 *  generate timing information (fmax) and multiplex the DE115's 16 switches
 *  onto the adder's 32 inputs.
 *
 *	 Make sure you instantiate only one of the modules for each demo! 
 *   See section called module instatiation below.
 

/* Module declaration.  Everything within the parentheses()
 * is a port between this module and the outside world */
 


module lab5_toplevel
(
    input   logic           Clk,        	// 50MHz clock is only used to get timing estimate data
    input   logic           Reset,      	// From push-button 0.  Remember the button is active low (0 when pressed)
    input   logic           Run,      		// From push-button 1
    input   logic           ClearA_LoadB, // From push-button 3.
    input   logic[7:0]      S,         	// From slider switches
    
    // all outputs are registered
    output  logic           X,  	         // extend of A
	output  logic[7:0]		Aval,			// A and B register output
	output  logic[7:0]		Bval,
	output  logic[6:0]      AhexU,  	   // Hex drivers display both inputs to the adder.
    output  logic[6:0]      AhexL,
    output  logic[6:0]      BhexU,
    output  logic[6:0]      BhexL
);

    /* Declare Internal Registers */
    logic[7:0]  newA;  // use this as an input to your adder
    logic[7:0]  newB;  // use this as an input to your adder
    logic[7:0]	Adder;
	logic[7:0]	Sum;
    /* Declare Internal Wires
     * Wheather an internal logic signal becomes a register or wire depends
     * on if it is written inside an always_ff or always_comb block respectivly */
    logic 		     newX;
    logic[6:0]      Ahex0_comb;
    logic[6:0]      Ahex1_comb;
    logic[6:0]      Bhex0_comb;
    logic[6:0]      Bhex1_comb;

    /* Declare control logic*/
    logic Clr_Ld, Shift_En, Add, Sub, M, Clr_XA,AddX;


    /* Behavior of registers A, B, Sum, and CO 
     * We load new value at each rising edge to output register
     * instead, we keep the sum and CO stay the same until they should be updated. */
    always_ff @(posedge Clk) begin
		Aval <= newA;
		Bval <= newB;
		X <= newX;
    end

    /* Decoders for HEX drivers and output registers
     * Note that the hex drivers are calculated one cycle after Sum so
     * that they have minimal interfere with timing (fmax) analysis.
     * The human eye can't see this one-cycle latency so it's OK. */
    always_ff @(posedge Clk) begin
	 if (~Clr_XA) begin
        AhexL <= Ahex0_comb;
        AhexU <= Ahex1_comb;
        BhexL <= Bhex0_comb;
        BhexU <= Bhex1_comb;
		  end
    end


    // Adder transfer logic 
    always_comb begin
		if (Sub)
			Adder = ~S;
		else if (~Add)
			Adder = 8'h00;
		else
			Adder = S;
		
		if (Clr_XA)
			newX = 1'b0;
		else
			newX = AddX;
	end


    // 8-bit shift register block. 
    reg_8 A
    (
        //input
        .Clk,
        .Reset((~Clr_Ld)|(~Reset)|Clr_XA),
        .Shift_In(newX),
        .Load(Add|Sub),
        .Shift_En,
        .D(Sum),
        //output
        .Data_Out(newA)
    );
    reg_8 B
    (
        //input
        .Clk,
        .Reset(~Reset),
        .Shift_In(newA[0]),
        .Load(~Clr_Ld),
        .Shift_En,
        .D(S),
        //output
        .Data_Out(newB)
    );

    // control logic unit designed with state machine. 
    control control_logic
    (   
        //input
        .Clk,        
		.Reset,			
		.Run,
		.ClearA_LoadB,
		.M(newB[0]),

		//output
		.Clr_Ld,			
		.Shift_En,
		.Add,
		.Sub,
		.Clr_XA
    );

    // 9 bits full adder
    full_adder_9 FA9
	(
		.A({newA[7],newA}),	// A
		.B({Adder[7],Adder}),	// S
		.C_in(Sub),			// subtraction when Cin is 1. 
		.Sum,
		.X(AddX)
	); 
	
        HexDriver Ahex0_inst
    (
        .In0(newA[3:0]),   // This connects the 4 least significant bits of 
                        // register A to the input of a hex driver named Ahex0_inst
        .Out0(Ahex0_comb)
    );
    
    HexDriver Ahex1_inst
    (
        .In0(newA[7:4]),
        .Out0(Ahex1_comb)
    );
 
    
    HexDriver Bhex0_inst
    (
        .In0(newB[3:0]),
        .Out0(Bhex0_comb)
    );
    
    HexDriver Bhex1_inst
    (
        .In0(newB[7:4]),
        .Out0(Bhex1_comb)
    );
    
endmodule

