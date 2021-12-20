//------------------------------------------------------------------------------
// Company:          UIUC ECE Dept.
// Engineer:         Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Lab 6 Given Code - Incomplete ISDU
// Module Name:    ISDU - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 02-13-2017
//    Spring 2017 Distribution
//------------------------------------------------------------------------------


module ISDU (   input logic         Clk, 
									Reset,
									Run,
									Continue,
									
				input logic[3:0]    Opcode, 
				input logic         IR_5,
				input logic         IR_11,
				input logic         BEN,
				  
				output logic        LD_MAR,
									LD_MDR,
									LD_IR,
									LD_BEN,
									LD_CC,
									LD_REG,
									LD_PC,
									LD_LED, // for PAUSE instruction
									
				output logic        GatePC,
									GateMDR,
									GateALU,
									GateMARMUX,
									
				output logic [1:0]  PCMUX,
				output logic        DRMUX,
									SR1MUX,
									SR2MUX,
									ADDR1MUX,
				output logic [1:0]  ADDR2MUX,
									ALUK,
				  
				output logic        Mem_CE,
									Mem_UB,
									Mem_LB,
									Mem_OE,
									Mem_WE
				);

	enum logic [5:0] {  Halted, 
						PauseIR1, 
						PauseIR2, 
						S_18, 
						S_33_1, 
						S_33_2, 
						S_35, 
						S_32, 
						S_01,
						S_00,
						S_02,
						S_03,
						S_04,
						S_05,
						S_06,
						S_07,
						S_08,
						S_09,
						S_10,
						S_11,
						S_12,
						S_13,
						S_14,
						S_15,
						S_16_1,
						S_16_2,
						S_17,
						S_19,
						S_20,
						S_21,
						S_22,
						S_23,
						S_24_1,
						S_24_2,
						S_25_1,
						S_25_2,
						S_26,
						S_27,
						S_28_1,
						S_28_2,
						S_29_1,
						S_29_2,
						S_30,
						S_31,
						S_34
						}   State, Next_state;   // Internal state logic
		
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			State <= Halted;
		else 
			State <= Next_state;
	end
   
	always_comb
	begin 
		// Default next state is staying at current state
		Next_state = State;
		
		// Default controls signal values
		LD_MAR 		= 1'b0;
		LD_MDR 		= 1'b0;
		LD_IR 		= 1'b0;
		LD_BEN 		= 1'b0;
		LD_CC 		= 1'b0;
		LD_REG 		= 1'b0;
		LD_PC 		= 1'b0;
		LD_LED 		= 1'b0;
		 
		GatePC 		= 1'b0;
		GateMDR 	= 1'b0;
		GateALU 	= 1'b0;
		GateMARMUX 	= 1'b0;
		 
		ALUK 		= 2'b00;
		 
		PCMUX 		= 2'b00;
		DRMUX 		= 1'b0;
		SR1MUX 		= 1'b0;
		SR2MUX 		= 1'b0;
		ADDR1MUX 	= 1'b0;
		ADDR2MUX 	= 2'b00;
		 
		Mem_OE 		= 1'b1;
		Mem_WE 		= 1'b1;
	
		// Assign next state
		unique case (State)
			Halted : 
				if (Run) 
					Next_state = S_18;                      
			S_18 : 
				Next_state = S_33_1;
			// Any states involving SRAM require more than one clock cycles.
			// The exact number will be discussed in lecture.
			S_33_1 : 
				Next_state = S_33_2;
			S_33_2 : 
				Next_state = S_35;
			S_35 : 
				Next_state = S_32;
			// PauseIR1 and PauseIR2 are only for Week 1 such that TAs can see 
			// the values in IR.
			PauseIR1 : 
				if (~Continue) 
					Next_state = PauseIR1;
				else 
					Next_state = PauseIR2;
			PauseIR2 : 
				if (Continue) 
					Next_state = PauseIR2;
				else 
					Next_state = S_18;
			S_32 : 
				case (Opcode)
					4'b0001 : // ADD
						Next_state = S_01;
					4'b0101 : // AND
						Next_state = S_05;
					4'b1001 : // NOT
						Next_state = S_09;
					4'b0000 : // BR
						Next_state = S_00;
					4'b1100 : // JMP
						Next_state = S_12;
					4'b0100 : // JSR
						Next_state = S_04;
					4'b0110 : // LDR
						Next_state = S_06;
					4'b0111 : // STR
						Next_state = S_07;
					4'b1101 : // PAUSE
						Next_state = PauseIR1;

					// You need to finish the rest of opcodes.....

					default : 
						Next_state = S_18;
				endcase
			S_08 : //
				Next_state = S_18;

			// ========== ALU_OP ==========

			S_01 : // ADD
				Next_state = S_18;

			S_05 : // AND
				Next_state = S_18;
			
			S_09 : // NOT
				Next_state = S_18;


			// ========== TRAP ==========

			S_15 : // TRAP
				Next_state = S_28_1;

			S_28_1 : // About TRAP
				Next_state = S_28_2;
			
			S_28_2 : // About TRAP
				Next_state = S_30;

			S_30 : // About TRAP
				Next_state = S_18;


			// ========== LEA ==========

			S_14 : // LEA
				Next_state = S_18;


			// ========== LD ==========

			S_02 : // LD
				Next_state = S_25_1;

			S_06 : // LDR
				Next_state = S_25_1;

			S_10 : // LDI
				Next_state = S_24_1;

			S_24_1 : // About LD
				Next_state = S_24_2;

			S_24_2 : // About LD
				Next_state = S_26;

			S_26 : // About LD
				Next_state = S_25_1;

			S_25_1 : // About LD
				Next_state = S_25_2;

			S_25_2 : // About LD
				Next_state = S_27;

			S_27 : // About LD
				Next_state = S_18;			


			// ========== ST ==========

			S_11 : // STI
				Next_state = S_29_1;

			S_07 : // STR
				Next_state = S_23;
			
			S_14 : // ST
				Next_state = S_23;
			
			S_29_1 : // About ST
				Next_state = S_29_2;

			S_29_2 : // About ST
				Next_state = S_31;

			S_31 : // About ST
				Next_state = S_23;

			S_23 : // About ST
				Next_state = S_16_1;
			
			S_16_1 : // About ST
				Next_state = S_16_2;
			
			S_16_2 : // About ST
				Next_state = S_18;


			// ========== JUMP ==========

			S_00 : // BR
				if (BEN == 1'b1) begin
					Next_state = S_22;
					end
				else
					Next_state = S_18;
				

			S_22 : // About BR
				Next_state = S_18;

			S_12 : // JMP
				Next_state = S_18;

			S_04 : // JSR
				// conditional
				Next_state = S_21;
			
			S_21 : // BR
				Next_state = S_18;

			S_20 : // BR
				Next_state = S_18;

			// You need to finish the rest of states.....

			default : ;

		endcase
		
		// Assign control signals based on current state
		case (State)
			Halted: ;
			S_18 : 
				begin 
					GatePC = 1'b1;
					LD_MAR = 1'b1;
					PCMUX = 2'b00;
					LD_PC = 1'b1;
				end
			S_33_1 : 
				Mem_OE = 1'b0;
			S_33_2 : 
				begin 
					Mem_OE = 1'b0;
					LD_MDR = 1'b1;
				end
			S_35 : 
				begin 
					GateMDR = 1'b1;
					LD_IR = 1'b1;
				end
			PauseIR1: 
					LD_LED = 1'b1;
			PauseIR2: ;
			S_32 : 
				LD_BEN = 1'b1;

			// ========== ALU OP ==========

			S_01 : // AND
				begin 
					SR2MUX 		= 	IR_5;		// SR2MUX Control with IR5
					SR1MUX 		= 	1'b0;		// Address of SR1
					ALUK 		= 	2'b00;		// Operation 00 rep +
					GateALU 	= 	1'b1;		// ALU -> BUS
					LD_REG 		= 	1'b1;		// BUS -> REGFILE
					DRMUX 		= 	1'b0;		// Address of DR
					LD_CC 		= 	1'b1;		// Update nzp
					LD_BEN 		= 	1'b1;
					// incomplete...
				end

			S_05 : // AND
				begin
					SR2MUX 		= 	IR_5;		// SR2MUX Control with IR5
					SR1MUX 		= 	1'b0;		// Address of SR1
					ALUK 		= 	2'b01; 		// Operation 01 rep &
					GateALU 	= 	1'b1;		// ALU -> BUS
					DRMUX 		= 	1'b0;		// Address of DR
					LD_REG 		= 	1'b1;		// BUS -> REGFILE
					LD_CC 		= 	1'b1;		// Update nzp	
					LD_BEN 		= 	1'b1;				
				end
			
			S_09 : // NOT
				begin
					SR2MUX 		= 	1'b0;		// any value
					SR1MUX 		= 	1'b0;		// Address of SR1
					ALUK 		= 	2'b10; 		// Operation 01 rep ~
					GateALU 	= 	1'b1;		// ALU -> BUS
					DRMUX 		= 	1'b0;		// Address of DR
					LD_REG 		= 	1'b1;		// BUS -> REGFILE
					LD_CC 		= 	1'b1;		// Update nzp	
					LD_BEN 		= 	1'b1;
				end
		

			// ========== LD ==========

			S_06 : // LDR
				begin
					GateMARMUX  =	1'b1;		// MARMUX -> BUS
					ADDR2MUX	=	2'b01;		// select IR5:0
					ADDR1MUX	=	1'b0;		// select from SR1
					SR1MUX		=	1'b0;		// select IR8:6, BaseR
					LD_MAR		=	1'b1;		// MAR <- PC
				end

			S_25_1 : // About LD
				begin
					Mem_OE 		= 	1'b0;
					Mem_WE 		= 	1'b1;
				end

			S_25_2 : // About LD
				begin
					Mem_OE 		= 	1'b0;
					Mem_WE 		= 	1'b1;
					LD_MDR 		= 	1'b1;
				end

			S_27 : // About LD
				begin
					GateMDR		=	1'b1;		// MDR -> BUS
					DRMUX		=	1'b0;		// select DR in IR
					LD_REG		=	1'b1;		// REG <- BUS
					LD_CC		=	1'b1;		// update CC
					LD_BEN 		= 	1'b1;
				end

			// ========== ST ==========

			S_07 : // STR 
				begin
					GateMARMUX  =	1'b1;		// MARMUX -> BUS
					ADDR2MUX	=	2'b01;		// select IR5:0
					ADDR1MUX	=	1'b0;		// select from SR1
					SR1MUX		=	1'b0;		// select IR8:6, BaseR
					LD_MAR		=	1'b1;		// MAR <- PC
				end

			S_23 : // About ST, MDR <- 
				begin
					GateALU		=	1'b1;		// ALU -> BUS
					ALUK		=	2'b11;		// bypass ALU  // one bug
					SR1MUX		=	1'b1;		// select DR in IR11:9, SR
					LD_MDR		=	1'b1;		// MDR <- BUS
				end
			
			S_16_1 : // About ST
				begin
					Mem_OE 		= 	1'b1;
					Mem_WE 		= 	1'b0;
				end
			
			S_16_2 : // About ST
				begin
					Mem_OE 		= 	1'b1;
					Mem_WE 		= 	1'b0;
				end

			// ========== JUMP ==========

			S_00 : // BR
				begin
					;	// only for judge
				end

			S_22 : // About BR
				begin
					ADDR2MUX 	= 	2'b10;		// IR[8:0]
					ADDR1MUX 	= 	1'b1;		// PC
					LD_PC 		= 	1'b1;		// PC <- off9 + PC
					PCMUX 		= 	2'b10;		// select R1 + R2
				end

			S_12 : // JMP
				begin
					SR1MUX		=	1'b0;		// BaseR in IR
					ADDR1MUX	=	1'b0;		// select from SR1
					ADDR2MUX	=	2'b00;		// select 0
					PCMUX		=	2'b10;		// select R1 + R2
					LD_PC		=	1'b1;		// PC <- BaseR
				end

			S_04 : // JSR
				begin
					GatePC 		= 	1'b1;		// PC -> BUS
					DRMUX 		= 	IR_11;		// Adress of b111 = 7
					LD_REG 		= 	1'b1;		// REGFILE 7 <- PC
				end
			
			S_21 : // About BR
				begin
					ADDR1MUX 	= 	1'b1;		// PC
					ADDR2MUX 	= 	2'b11;		// IR[10:0]
					PCMUX 		= 	2'b10;		// select R1 + R2
					LD_PC 		= 	1'b1;		// PC <- PC + IR[10:0]
				end

			// You need to finish the rest of states.....

			default : ;
		endcase
	end 

	 // These should always be active
	assign Mem_CE = 1'b0;
	assign Mem_UB = 1'b0;
	assign Mem_LB = 1'b0;
	
endmodule
