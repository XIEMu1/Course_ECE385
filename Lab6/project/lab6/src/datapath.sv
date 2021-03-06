module datapath (
				input logic 		Clk, 
									Reset,

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
				  
				input logic         CE, UB, LB, OE, WE,

				input logic 		MIO_EN,

				input logic 		[15:0] MDR_In,

				output logic 		[15:0] MAR, MDR, IR, PC
);

	logic 	[15:0] 	BUS,
					PC_Out,
					IR_Out,
					MDR_Out,
					MAR_Out,

					PC_MUX_Out,
					
					
					SR2_MUX_Out,
					MDR_MUX_Out,

					ADDR1_MUX_Out,
					ADDR2_MUX_Out,

					SR1_Out,
					SR2_Out,

					BEN_Out,
					ALU_Out,
					BEN;
	
	logic	[2:0]	SR1_MUX_Out, DR_MUX_Out;






	// Multiplexer definition

	multiplexer2_1 #(3) DR_MUX (
							.sel(PCMUX),
							.d0(3'b111),
							.d1(IR_Out[11:9]),
							.out(DR_MUX_Out)
	);



	multiplexer4_1 PC_MUX (
							.sel(PCMUX),
							.d0(PC_Out + 1'b1),
							.d1(BUS),
							.d2(ADDR1_MUX_Out + ADDR2_MUX_Out),
							.d3(2'b00),
							.out(PC_MUX_Out)
	);


	multiplexer2_1 SR2_MUX (
							.sel(SR2MUX),
							.d0(SR2_Out),
							.d1(BUS),  // ?
							.out(SR2_MUX_Out)
	);

	multiplexer2_1 #(3) SR1_MUX (
							.sel(SR1MUX),
							.d0(IR_Out[8:6]),
							.d1(IR_Out[11:9]),
							.out(SR1_MUX_Out)
	);

	multiplexer2_1 ADDR1_MUX (
							.sel(ADDR1MUX),
							.d0(SR1_Out),
							.d1(PC_Out),
							.out(ADDR1_MUX_Out)
	);

	multiplexer4_1 ADDR2_MUX (
							.sel(ADDR2MUX),
							.d0(16'h0000),
							.d1({{10{IR_Out[5]}}, IR_Out[5:0]}),  // ?
							.d2({{7{IR_Out[5]}}, IR_Out[8:0]}),  // ?
							.d3({{5{IR_Out[5]}}, IR_Out[10:0]}),  // ?
							.out(ADDR2_MUX_Out)
	);

	multiplexer2_1 MDR_MUX (
							.sel(MIO_EN),
							.d0(BUS),  // ?
							.d1(MDR_In),  
							.out(MDR_MUX_Out)
	);


	reg_16 REG_PC(
			.Clk(Clk),
			.Reset(Reset),
			.Load(LD_PC),
			.Data_In(PC_MUX_Out),
			.Data_Out(PC_Out)
	);

	reg_16 REG_IR(
			.Clk(Clk),
			.Reset(Reset),
			.Load(LD_IR),
			.Data_In(BUS),
			.Data_Out(IR_Out)
	);

	reg_16 REG_MAR(
			.Clk(Clk),
			.Reset(Reset),
			.Load(LD_MAR),
			.Data_In(BUS),
			.Data_Out(MAR_Out)
	);
	
	reg_16 REG_MDR(
			.Clk(Clk),
			.Reset(Reset),
			.Load(LD_MDR),
			.Data_In(MDR_MUX_Out),
			.Data_Out(MDR_Out)
	);

	ALU ALU(
			.ALUK(ALUK),
			.A(SR1_Out),
			.B(SR2_Out),
			.ALU_Out(ALU_Out)
	);





	regfile RegFile(
			.LD_REG(LDREG),
			.Clk(CLk), 
			.Reset(Reset),
			.BUS(BUS),
			.DR_MUX(DR_MUX_Out), 
			.SR1_MUX(SR1_MUX_Out), 
			.SR2(),   //?
			.SR1_out(SR1_Out), 
			.SR2_out(SR2_Out)
	);

	tristate_gate Tristate_Gate(
							.sel({GatePC, GateMDR, GateALU, GateMARMUX}),
							.d0(ADDR1_MUX_Out + ADDR2_MUX_Out),
							.d1(ALU_Out),
							.d2(MDR_Out),
							.d3(PC_Out),
							.out(BUS)
	);

	always_comb begin
		MDR = MDR_Out;
		MAR = MAR_Out;
		IR = IR_Out;
		PC = PC_Out;
		BEN = BEN_Out;
	end 

endmodule