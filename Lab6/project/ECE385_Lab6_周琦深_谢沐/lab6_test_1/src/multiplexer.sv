module multiplexer4_1  
    #(parameter len = 16)            
                    (
						input logic     [1:0] sel, 
						input logic     [len-1 : 0] d0, d1, d2, d3,
						output logic    [len-1: 0] out
					);
	always_comb
	begin
		unique case (sel)
			2'b00	:	out = d0;
			2'b01	:	out = d1;
			2'b10	:	out = d2;
			2'b11	:	out = d3;
		endcase
	end
endmodule 


module multiplexer2_1
    #(parameter len = 16)
				(
					input 	logic 	sel, 
			  		input	logic 	[len-1 : 0] d0, d1,
			  		output 	logic 	[len-1 : 0]	out
		  		);
	always_comb
	begin
		unique case (sel)
			1'b0 	:	out = d0;
			1'b1	:	out = d1;
		endcase
	end
endmodule 


module multiplexer2_1_3
    #(parameter len = 3)
				(
					input 	logic 	sel, 
			  		input	logic 	[len-1 : 0] d0, d1,
			  		output 	logic 	[len-1 : 0]	out
		  		);
	always_comb
	begin
		unique case (sel)
			1'b0 	:	out = d0;
			1'b1	:	out = d1;
		endcase
	end
endmodule 


module tristate_gate           
                    (
						input logic     [3:0] sel, 
						input logic     [15 : 0] d0, d1, d2, d3,
						output logic    [15: 0] out
					);
	always_comb
	begin
		unique case (sel)
			4'b0001	:	out = d0;
			4'b0010	:	out = d1;
			4'b0100	:	out = d2;
			4'b1000	:	out = d3;
		default: out = 16'h0000;
		endcase
	end
endmodule 