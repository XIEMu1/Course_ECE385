module reg_8 (input  logic Clk, Reset, Shift_In, Load, Shift_En,
              input  logic [7:0]  D,
              output logic Shift_Out,
              output logic [7:0]  Data_Out);

	// the module has 3 state: Reset, Load, Shift_En
    always_ff @ (posedge Clk)
    begin			
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 8'h0;			// set to 0 in hex, 4 is used for controling the length
		 else if (Load)
			  Data_Out <= D;			// save the data D into the Data_Out
		 else if (Shift_En)
		 begin
			  //concatenate shifted in data to the previous left-most 3 bits
			  //note this works because we are in always_ff procedure block
			  Data_Out <= { Shift_In, Data_Out[7:1] };		// Data_Out[a,b,c,d] <- x => Data_Out[b,c,d,x]
	    end
    end
	
    assign Shift_Out = Data_Out[0];		// output the data DO[0]

endmodule
