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