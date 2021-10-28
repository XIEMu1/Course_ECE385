module datapath (

                input logic         LD_MAR,
									LD_MDR,
									LD_IR,
									LD_BEN,
									LD_CC,
									LD_REG,
									LD_PC,
									LD_LED, // for PAUSE instruction
									
				input logic         GatePC,
									GateMDR,
									GateALU,
									GateMARMUX,
									
				input logic [1:0]   PCMUX,
				input logic         DRMUX,
									SR1MUX,
									SR2MUX,
									ADDR1MUX,
				input logic [1:0]   ADDR2MUX,
									ALUK,
				  
				input logic         Mem_CE,
									Mem_UB,
									Mem_LB,
									Mem_OE,
									Mem_WE
);







	// Multiplexer definition

	multiplexer2_1 #(3) DR_MUX (
		
	);



	multiplexer4_1 PC_MUX ();


	multiplexer4_1 SR2_MUX ();

	multiplexer4_1 SR1_MUX ();

	multiplexer2_1 ADDR1_MUX ();

	multiplexer4_1 ADDR2_MUX ();


	reg_16 PC();
	reg_16 IR();
	reg_16 MAR();
	reg_16 MDR();







endmodule