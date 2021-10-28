//Two-always example for state machine

module control_logic (input  logic Clk, Reset, ClearA_LoadB, Run, M
                output logic Clr_Ld, Shift_En, Add, Sub, Clr_XA );
    // This module is the control unit of the multiplier

    // Input:
    //      logic Clk: clock; 
    //      logic Reset: reset; 
    //      logic ClearA_LoadB: clear A then load B; 
    //      logic Execute: run signal
    // 
    // Output:
    //      logic Clr_Ld: clear A and load B; 
    //      logic Shift; 
    //      logic Add; 
    //      logic Sub
    // 
    // 



    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [3:0] {Res, Idol, Prep, Op_0, Op_1, Sft, Fns} curr_state, next_state; 
    enum logic [3:0] iter_num;

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= Res;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
	    next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            Res:    next_state = Idol
            Idol :  if (~Run)
                        next_state = B;
                    if (~ClearA_LoadB)
                        next_state = Prep;
            Prep:   next_state = Idol;
            Op0:    next_state = Sft;
            Op1:    next_state = Sft;
            Shf:    if (iter_num <= 1'x5)
                        next_state = Op_0;
                    if (iter_num == 1'x6)
                        next_state = Op_1;
                    if (iter_num == 1'x7)
                        next_state = Fns;
            Fns:    next_state = Idol;
							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 

            Res:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b0;
                    Sub      = 1'b0;
                end

            Idol:
                begin                
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b0;
                    Sub      = 1'b0;
                end

            Prep:
                begin
                    Clr_Ld   = 1'b0;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b0;
                    Sub      = 1'b0;
                end

            Op_0:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    if (M == 1'b0)
                        Add  = 1'b0;
                    else
                        Add  = 1'b1;
                    Shift_En = 1'b0;
                    Sub      = 1'b0;
                    ripple_4bit Ader_1(.A(1'x1), .B(iter_num), .C_in(1'b0), .Sum(iter_num), .C_out());

                end

            Op_1:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b0;
                    if (M == 1'b0)
                        Sub  = 1'b0;
                    else
                        Sub  = 1'b1;
                    ripple_4bit Ader_2(.A(1'x1), .B(iter_num), .C_in(1'b0), .Sum(iter_num), .C_out());
                end

            Sft:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b1;
                    Sub      = 1'b0;
                end
    
            Fns:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b1;
                    Add      = 1'b0;
                    Shift_En = 1'b0;
                    Sub      = 1'b0;
                end  
              
        endcase
    end

endmodule