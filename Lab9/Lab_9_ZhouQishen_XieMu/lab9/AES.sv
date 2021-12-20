/************************************************************************
AES Decryption Core Logic

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

module AES (
	input		logic 	CLK,
	input		logic 	RESET,
	input		logic 	AES_START,
	output		logic 	AES_DONE,
	input		logic 	[127:0] AES_KEY,
	input		logic 	[127:0] AES_MSG_ENC,
	output		logic 	[127:0] AES_MSG_DEC
);

	// 32bit 4 * (10+1)
	logic [1407:0]	Word;
	logic [127:0]	State_Curr;
	logic [127:0]	State_Next;
	logic [127:0]	Shift_Out;
	logic [127:0]	Sub_Out;
	logic [127:0]	AddRoundKey_Out;
	logic [31:0]	MixColumns_In;
	logic [31:0]	MixColumns_Out;
	logic [127:0]	Key;
	logic [4:0]		Counter;
	logic [4:0]		Counter_Next;
	
	// FSM State_Curr definiton
	enum logic [4:0]{
		WAIT,
		KEY_SCHEDULE,
		ADDROUNDKEY_PREV,
		// loop
		INV_SHIFTROWS,
		INV_SUBBYTES,
		ADDROUNDKEY,
		INV_MIXCOLUMNS_1,
		INV_MIXCOLUMNS_2,
		INV_MIXCOLUMNS_3,
		INV_MIXCOLUMNS_4,
		INV_MIXCOLUMNS_FINISH,
		// loop end
		INV_SHIFTROWS_END,
		INV_SUBBYTES_END,
		ADDROUNDKEY_END,
		DONE
	} AES_STATE, AES_NEXT_STATE;


	// prepare the words for AddRoundKey
	KeyExpansion KeyExpansion_Instance(.clk(CLK), .Cipherkey(AES_KEY), .KeySchedule(Word));

	// InvShiftRows
	InvShiftRows InvShiftRows_Instance(.data_in(State_Curr), .data_out(Shift_Out));

	// InvSubBytes
	InvSubBytes InvSubBytes_0	(.clk(CLK), .in(State_Curr[7:0]), 		.out(Sub_Out[7:0]));
	InvSubBytes InvSubBytes_1	(.clk(CLK), .in(State_Curr[15:8]), 		.out(Sub_Out[15:8]));
	InvSubBytes InvSubBytes_2	(.clk(CLK), .in(State_Curr[23:16]), 		.out(Sub_Out[23:16]));
	InvSubBytes InvSubBytes_3	(.clk(CLK), .in(State_Curr[31:24]), 		.out(Sub_Out[31:24]));
	InvSubBytes InvSubBytes_4	(.clk(CLK), .in(State_Curr[39:32]), 		.out(Sub_Out[39:32]));
	InvSubBytes InvSubBytes_5	(.clk(CLK), .in(State_Curr[47:40]), 		.out(Sub_Out[47:40]));
	InvSubBytes InvSubBytes_6	(.clk(CLK), .in(State_Curr[55:48]), 		.out(Sub_Out[55:48]));
	InvSubBytes InvSubBytes_7	(.clk(CLK), .in(State_Curr[63:56]), 		.out(Sub_Out[63:56]));
	InvSubBytes InvSubBytes_8	(.clk(CLK), .in(State_Curr[71:64]), 		.out(Sub_Out[71:64]));
	InvSubBytes InvSubBytes_9	(.clk(CLK), .in(State_Curr[79:72]), 		.out(Sub_Out[79:72]));
	InvSubBytes InvSubBytes_10	(.clk(CLK), .in(State_Curr[87:80]),		.out(Sub_Out[87:80]));
	InvSubBytes InvSubBytes_11	(.clk(CLK), .in(State_Curr[95:88]), 		.out(Sub_Out[95:88]));
	InvSubBytes InvSubBytes_12	(.clk(CLK), .in(State_Curr[103:96]), 	.out(Sub_Out[103:96]));
	InvSubBytes InvSubBytes_13	(.clk(CLK), .in(State_Curr[111:104]), 	.out(Sub_Out[111:104]));
	InvSubBytes InvSubBytes_14	(.clk(CLK), .in(State_Curr[119:112]), 	.out(Sub_Out[119:112]));
	InvSubBytes InvSubBytes_15	(.clk(CLK), .in(State_Curr[127:120]), 	.out(Sub_Out[127:120]));

	// AddRoundKey
	AddRoundKey AddRoundKey_Instance(.state(State_Curr), .roundKey(Key), .out(AddRoundKey_Out));

	// InvMixColumns
	InvMixColumns InvMixColumns_Instance(.in(MixColumns_In),.out(MixColumns_Out));


	always_ff @(posedge CLK)
	begin
		if (RESET) begin
			AES_STATE <= WAIT;
			Counter <=4'b0;
		end
		
		else begin
			State_Curr <= State_Next;
			AES_STATE <= AES_NEXT_STATE;
			Counter <= Counter_Next;
		end
	end
	
	always_comb begin
			Counter_Next = Counter;
			AES_NEXT_STATE = AES_STATE;
			unique case (AES_STATE)
			WAIT:
				begin
					if (AES_START == 1'b1)begin
						Counter_Next = 4'b0;
						AES_NEXT_STATE = KEY_SCHEDULE;
					end 
					else begin
						AES_NEXT_STATE = WAIT;
					end
				end
			
			KEY_SCHEDULE:
				begin
					if (Counter == 10) begin
						AES_NEXT_STATE = ADDROUNDKEY_PREV;
						Counter_Next = 0;
					end
					else begin
						AES_NEXT_STATE = KEY_SCHEDULE;
						Counter_Next = Counter + 4'b1;
					end
				end
			
			ADDROUNDKEY_PREV: 
				AES_NEXT_STATE = INV_SHIFTROWS;
			
			INV_SHIFTROWS: 
				AES_NEXT_STATE = INV_SUBBYTES;
			
			INV_SUBBYTES: 
				AES_NEXT_STATE = ADDROUNDKEY;

			ADDROUNDKEY:
				AES_NEXT_STATE = INV_MIXCOLUMNS_1;

			INV_MIXCOLUMNS_1: 
				AES_NEXT_STATE = INV_MIXCOLUMNS_2;
			
			INV_MIXCOLUMNS_2: 
				AES_NEXT_STATE = INV_MIXCOLUMNS_3;
						
			INV_MIXCOLUMNS_3: 
				AES_NEXT_STATE = INV_MIXCOLUMNS_4;
			
			INV_MIXCOLUMNS_4: 
				AES_NEXT_STATE = INV_MIXCOLUMNS_FINISH;

			INV_MIXCOLUMNS_FINISH:
				begin
					if (Counter == 4'd8)begin
						AES_NEXT_STATE = INV_SHIFTROWS_END;
					end
					else begin
						AES_NEXT_STATE = INV_SHIFTROWS;
						Counter_Next = Counter + 4'b1;
					end
				end
			
			INV_SHIFTROWS_END: 
				AES_NEXT_STATE = INV_SUBBYTES_END;
			
			INV_SUBBYTES_END: 
				AES_NEXT_STATE = ADDROUNDKEY_END;
	
			ADDROUNDKEY_END: 
				AES_NEXT_STATE = DONE;
			
			DONE:
				begin
					if (AES_START==0) begin
						AES_NEXT_STATE = WAIT;
					end
					else begin
						AES_NEXT_STATE = DONE;
					end
				end
			
			default: begin
				AES_NEXT_STATE = WAIT;
			end
		endcase
		
		
		
		
		State_Next = State_Curr;
		AES_DONE = 1'b0;
		AES_MSG_DEC = 128'b0;
		MixColumns_In = 32'b0;
		Key = 128'b0;
		case (AES_STATE)
			WAIT:
				begin
				end
			
			KEY_SCHEDULE:
				begin
					State_Next = AES_MSG_ENC;
				end
			
			ADDROUNDKEY_PREV:
				begin
					Key = Word[127:0];
					State_Next = AddRoundKey_Out;
				end
			
			INV_SHIFTROWS:
				begin
					State_Next = Shift_Out;
				end
			
			INV_SUBBYTES:
				begin
					State_Next = Sub_Out;
				end
			
			ADDROUNDKEY:
				begin
					case (Counter)
						4'd8: Key = Word[1279:1152];
						4'd7: Key = Word[1151:1024];
						4'd6: Key = Word[1023:896];
						4'd5: Key = Word[895:768];
						4'd4: Key = Word[767:640];
						4'd3: Key = Word[639:512];
						4'd2: Key = Word[511:384];
						4'd1: Key = Word[383:256];
						4'd0: Key = Word[255:128];
						default: Key = 128'b0;
					endcase
					State_Next = AddRoundKey_Out;
				end
			
			INV_MIXCOLUMNS_1:
				begin
					MixColumns_In = State_Curr[31:0];
					State_Next[31:0] = MixColumns_Out;
				end
			
			INV_MIXCOLUMNS_2:
				begin
					MixColumns_In = State_Curr[63:32];
					State_Next[63:32] = MixColumns_Out;
				end
			
			INV_MIXCOLUMNS_3:
				begin
					MixColumns_In = State_Curr[95:64];
					State_Next[95:64] = MixColumns_Out;
				end
			
			INV_MIXCOLUMNS_4:
				begin
					MixColumns_In = State_Curr[127:96];
					State_Next[127:96] = MixColumns_Out;
				end
			
			INV_MIXCOLUMNS_FINISH:
				begin
				end
			
			INV_SHIFTROWS_END:
				begin
					State_Next = Shift_Out;
				end
				
			INV_SUBBYTES_END:
				begin
					State_Next = Sub_Out;
				end				
			
			ADDROUNDKEY_END:
				begin
					Key = Word[1407:1280];
					State_Next = AddRoundKey_Out;
				end
			
			DONE:
				begin
					AES_MSG_DEC = AddRoundKey_Out;
					AES_DONE = 1'b1;
				end
			
			default: begin
			end
		endcase
	end
endmodule
