//Two-always example for state machine

module control_logic 
(
    input  logic Clk, Reset, ClearA_LoadB, Run, M,
    output logic Clr_Ld, Shift_En, Add, Sub, Clr_XA
);
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

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
				begin
            curr_state <= Res;
				end
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
	    next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            Res:    next_state = Idol;
            Idol :  begin
						if (~Run)
                            next_state = Op_0;
                        if (~ClearA_LoadB)
                            next_state = Prep;
						end
            Prep:    next_state = Idol;
            Op_0:    next_state = Sft_0;
            Sft_0:   next_state = Op_1;

            Op_1:    next_state = Sft_1;
			Sft_1:   next_state = Op_2;

            Op_2:    next_state = Sft_2;
            Sft_2:   next_state = Op_3;

            Op_3:    next_state = Sft_3;
            Sft_3:   next_state = Op_4;

            Op_4:    next_state = Sft_4;
            Sft_4:   next_state = Op_5;

            Op_5:    next_state = Sft_5;
            Sft_5:   next_state = Op_6;

            Op_6:    next_state = Sft_6;
            Sft_6:   next_state = Op_7;

            Op_7:    next_state = Sft_7;
            Sft_7:   next_state = Fns;
            Fns:     next_state = Idol;
							  
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
                end

            Sft_0:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b1;
                    Sub      = 1'b0;
                end

            Op_1:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    if (M == 1'b0)
                        Add  = 1'b0;
                    else
                        Add  = 1'b1;
                    Shift_En = 1'b0;
                    Sub      = 1'b0;
                end

            

            Sft_1:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b1;
                    Sub      = 1'b0;
                end

            Op_2:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    if (M == 1'b0)
                        Add  = 1'b0;
                    else
                        Add  = 1'b1;
                    Shift_En = 1'b0;
                    Sub      = 1'b0;
                end

            Sft_2:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b1;
                    Sub      = 1'b0;
                end

            Op_3:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    if (M == 1'b0)
                        Add  = 1'b0;
                    else
                        Add  = 1'b1;
                    Shift_En = 1'b0;
                    Sub      = 1'b0;
                end

            Sft_3:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b1;
                    Sub      = 1'b0;
                end

            Op_4:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    if (M == 1'b0)
                        Add  = 1'b0;
                    else
                        Add  = 1'b1;
                    Shift_En = 1'b0;
                    Sub      = 1'b0;
                end

            Sft_4:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b1;
                    Sub      = 1'b0;
                end

            Op_5:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    if (M == 1'b0)
                        Add  = 1'b0;
                    else
                        Add  = 1'b1;
                    Shift_En = 1'b0;
                    Sub      = 1'b0;
                end

            Sft_5:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b1;
                    Sub      = 1'b0;
                end

            Op_6:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    if (M == 1'b0)
                        Add  = 1'b0;
                    else
                        Add  = 1'b1;
                    Shift_En = 1'b0;
                    Sub      = 1'b0;
                end

            Sft_6:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b1;
                    Sub      = 1'b0;
                end

            Op_7:
                begin
                    Clr_Ld   = 1'b1;
                    Clr_XA   = 1'b0;
                    Add      = 1'b0;
                    Shift_En = 1'b0;
                    if (M == 1'b0)
                        Sub  = 1'b0;
                    else
                        Sub  = 1'b1;
                    iter_num <<= 1;
                end

            Sft_7:
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