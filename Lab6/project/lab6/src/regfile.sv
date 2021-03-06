module regfile (
                input logic LD_REG, Clk, Reset,  
                input logic [15:0] BUS,
                input logic [2:0] DR_MUX, SR1_MUX, SR2,
                output logic [15:0] SR1_out, SR2_out
                );

	logic [7:0][15:0] Reg_Out;
	logic ld_reg0;
    always_ff @( posedge Clk ) begin
        if(~Reset) begin
			 Reg_Out[0] 	<=	16'h0000;
			 Reg_Out[1] 	<=	16'h0000;
			 Reg_Out[2] 	<=	16'h0000;
			 Reg_Out[3] 	<=	16'h0000;
			 Reg_Out[4] 	<=	16'h0000;
			 Reg_Out[5] 	<=	16'h0000;
			 Reg_Out[6] 	<=	16'h0000;
			 Reg_Out[7] 	<=	16'h0000;
		end
		else if(LD_REG) begin
			case (DR_MUX)
				3'b000	:	Reg_Out[0] <= BUS;
				3'b001	:	Reg_Out[1] <= BUS;
				3'b010	:	Reg_Out[2] <= BUS;
				3'b011	:	Reg_Out[3] <= BUS;
				3'b100	:	Reg_Out[4] <= BUS;
				3'b101	:	Reg_Out[5] <= BUS;
				3'b110	:	Reg_Out[6] <= BUS;
				3'b111	:	Reg_Out[7] <= BUS;
				default: ;
			endcase
		end
    end

    always_comb begin 
        case (SR1_MUX)
			3'b000	:	SR1_out = Reg_Out[0];
			3'b001	:	SR1_out = Reg_Out[1];
			3'b010	:	SR1_out = Reg_Out[2];
			3'b011	:	SR1_out = Reg_Out[3];
			3'b100	:	SR1_out = Reg_Out[4];
			3'b101	:	SR1_out = Reg_Out[5];
			3'b110	:	SR1_out = Reg_Out[6];
			3'b111	:	SR1_out = Reg_Out[7];
			default: ;
		endcase

		case (SR2)
			3'b000	:	SR2_out = Reg_Out[0];
			3'b001	:	SR2_out = Reg_Out[1];
			3'b010	:	SR2_out = Reg_Out[2];
			3'b011	:	SR2_out = Reg_Out[3];
			3'b100	:	SR2_out = Reg_Out[4];
			3'b101	:	SR2_out = Reg_Out[5];
			3'b110	:	SR2_out = Reg_Out[6];
			3'b111	:	SR2_out = Reg_Out[7];
			default: ;
		endcase
        
    end
endmodule