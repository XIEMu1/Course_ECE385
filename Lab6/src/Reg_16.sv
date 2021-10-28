module reg_16 (input  logic Clk, Reset, Shift_In, Load, Shift_En,
              input  logic [15:0]  D,
              output logic Shift_Out,
              output logic [15:0]  Data_Out);

	// the module has 3 state: Reset, Load, Shift_En
    always_ff @ (posedge Clk)
    begin			
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 16'h0;			// set to 0 in hex, 4 is used for controling the length
		 else if (Load)
			  Data_Out <= D;			// save the data D into the Data_Out
    end


endmodule
